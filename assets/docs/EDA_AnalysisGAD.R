## --- Exploratory Data Analysis ---##

## --- VARIABLES DEFINITION --- ##

# GAD - General Anxiety Disorder
      # Consists  of GAD1 - GAD7 ranging from 0-3
      # GAD-7 is the sum of GAD1:GAD7
      # Scores on the GAD-7 range from 0-21 with higher scores indicating more severe anxiety symptoms
  

# PHQ - The Patient Health Questionnaire-8 (PHQ-8)
      # A brief diagnostic measure for depression (Kroenke & Spitzer, 2002)
      # PHQ-8 is the sum of PHQ1:PHQ8
      # PHQ-8 scores range from 0-24 with higher scores indicating more severe depressive symptoms

# MSSS - Multidimensional Scale of Perceived Social Support
      # Assesses self-reported social support
      # MSSS-12 is the sum of MSSS1:MSSS12
      # has three subscales, which each address a different source of social support:
      # Family, friends, and a significant other


# EDA steps

# 1. Data Cleaning

# 2. Descriptive Statistics

# 3. Calculating overall GAD, PHQ and MSSS mean.

# 4. Calculating the GAD, PHQ and MSSS means within each demographic setting, i.e Age, Gender, Tribe etc.

# 5. Visualizing the data to help understand the research question
  

# Load required libraries
library(readr)      # reads the excel file
library(dplyr)      # data manipulation
library(ggplot2)    # Plots the data
library(scales)     # attaches percentages to plots
library(patchwork)  # combines plots

# Load and explore the required dataset

shamiri_data <- read.csv("shamiri_imputed_dataset.csv",
                         header = TRUE)                 # 658 observations of 33 variables

str(shamiri_data)     # View structure of the imputed dataset


# 1. Data Cleaning

which(is.na(shamiri_data))        # Missing data check

which(duplicated(shamiri_data))   # duplicates check

# check for outliers
# GAD and PHQ range = 0:3
# MSSS range = 0:12

# Create is.outlier function  to check values outside the required range
# This function checks whether the variables are within the expected ranges

is.outlier <- function(data, coef=1.5){
  
  # select the columns needed
  selected_cols1 <- c("GAD1", "GAD2", "GAD3", "GAD4", "GAD5", "GAD6", "GAD7",
                     "PHQ1", "PHQ2", "PHQ3", "PHQ4", "PHQ5", "PHQ6", "PHQ7", "PHQ8")
  selected_cols2 <-  c("MSSS1","MSSS2", "MSSS3", "MSSS4", "MSSS5", "MSSS6", "MSSS7", "MSSS8", "MSSS9", "MSSS10", "MSSS11", "MSSS12")
  
  # initialize the list to store the outliers
  outlier_list <- NULL
  
  
  for (i in selected_cols1){
    x <- data[[i]]

    outliers <- x < 0 | x > 3
    outlier_list[[i]]<- outliers
  }
  
  for (i in selected_cols2){
    x <- data[[i]]
    
    outliers <- x < 0 | x > 12
    outlier_list[[i]]<- outliers
  }
  
  return(outlier_list)
  
}

# Print the results

outlier_results <- is.outlier(shamiri_data)

selected_cols1 <- c("GAD1", "GAD2", "GAD3", "GAD4", "GAD5", "GAD6", "GAD7",
                   "PHQ1", "PHQ2", "PHQ3", "PHQ4", "PHQ5", "PHQ6", "PHQ7", "PHQ8")

selected_cols2 <-  c("MSSS1","MSSS2", "MSSS3", "MSSS4", "MSSS5", "MSSS6", "MSSS7", "MSSS8", "MSSS9", "MSSS10", "MSSS11", "MSSS12")


for (i in selected_cols1){
  cat("Outliers in", i, ":",
      which(outlier_results[[i]]), "\n")
}


for (i in selected_cols2){
  cat("Outliers in", i, ":",
      which(outlier_results[[i]]), "\n")
}


# PHQ3 rows to check - they showed outliers presence

filtered <- shamiri_data[shamiri_data$PHQ3 < 0 | shamiri_data$PHQ3 > 3, ]
filtered$PHQ3


# Add Age_group variable for grouping the Ages

shamiri_data$Age_group <- ifelse(shamiri_data$Age < 15, "Less than 15 years",
                         ifelse(shamiri_data$Age >= 15 & shamiri_data$Age <= 18, "15 - 18 years", "More than 18 years"))





# 2. Descriptive Statistics

# Summary statistics for Age
summary(shamiri_data$Age)


# Frequency stastics for demographic variables
table(shamiri_data$Gender)
table(shamiri_data$Tribe)
table(shamiri_data$Age_group)
table(shamiri_data$School)
table(shamiri_data$School_Resources)
table(as_tibble(data.frame(shamiri_data$School, shamiri_data$School_Resources)))

# 2. Overall GAD, PHQ and MSSS means

# overall GAD mean score

shamiri_data <- shamiri_data %>%
  mutate(cum_sum_gad = rowSums(select(., GAD1:GAD7)))

overall_gad_mean <- mean(shamiri_data$cum_sum_gad, na.rm = TRUE)
overall_gad_mean


# Overall PHQ mean score

shamiri_data <- shamiri_data %>%
  mutate(cum_sum_phq = rowSums(select(., PHQ1:PHQ8)))

overall_phq_mean <- mean(shamiri_data$cum_sum_phq, na.rm = TRUE)
overall_phq_mean


#Overall MSSS mean score

shamiri_data <- shamiri_data %>%
  mutate(cum_sum_msss=rowSums(select(., MSSS1:MSSS12)))

overall_msss_mean <- mean(shamiri_data$cum_sum_msss,na.rm = TRUE)
overall_msss_mean


# 3.Calculating the GAD, PHQ and MSSS means within each demographic setting

# (i) Age

# Age distribution of study participants
summary(shamiri_data$Age)

# Histogram representation of the Age 

age_plot <- ggplot(shamiri_data, aes(x = Age)) +
  geom_histogram(binwidth = 1, fill = "slateblue", color = "lightsteelblue3") +
  scale_x_continuous(breaks = seq(11,26, by = 1)) +
  labs(title = "Age Distribution of Study Participants", y = "Participants Count") +
  geom_text(stat= "count", aes(label = after_stat(count)),
            vjust = -0.2, color = "black") +
  theme_classic()

age_plot


# Age vs GAD

# Mean GAD score by Age
AgeMeanGAD <- shamiri_data %>%
  group_by(Age) %>%
  summarize(meanGAD = mean(cum_sum_gad), meanPHQ = mean(cum_sum_phq), meanMSSS = mean(cum_sum_msss))
AgeMeanGAD 

 
# Scatter Plot
ageVsGad_plot <- ggplot(AgeMeanGAD, aes(x = Age, y = meanGAD)) +
  geom_point(size = 1.5, color = "black") +
  scale_x_continuous(breaks = seq(11,26, by = 2)) +
  geom_smooth(method = "lm", se = FALSE, size = 1, color = "slateblue") +
  labs(x = "Age", y = "GAD Mean Score", title = "GAD Mean Score by Age")

ageVsGad_plot




combined_age_plots <- age_plot + ageVsGad_plot
combined_age_plots


# (ii) School Resources

# Violin Plots for GAD1 to GAD7

# GAD1
Schl_ResVsGAD_plot1 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD1)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD1 Score", title = "GAD1 Score by School Resource") +
  theme_classic()

Schl_ResVsGAD_plot1

# GAD2
Schl_ResVsGAD_plot2 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD2)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD2 Score", title = "GAD2 Score by School Resource") +
  theme_classic() 

Schl_ResVsGAD_plot2

# GAD3
Schl_ResVsGAD_plot3 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD3)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD3 Score", title = "GAD3 Score by School Resource") +
  theme_classic()


Schl_ResVsGAD_plot3

# GAD4
Schl_ResVsGAD_plot4 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD4)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD4 Score", title = "GAD4 Score by School Resource") +
  theme_classic()

Schl_ResVsGAD_plot4

# GAD5
Schl_ResVsGAD_plot5 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD5)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD5 Score", title = "GAD5 Score by School Resource") +
  theme_classic()

Schl_ResVsGAD_plot5

# GAD6
Schl_ResVsGAD_plot6 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD6)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD6 Score", title = "GAD6 Score by School Resource") +
  theme_classic()

Schl_ResVsGAD_plot6

# GAD7
Schl_ResVsGAD_plot7 <- ggplot(shamiri_data, aes(x = School_Resources, y = GAD7)) +
  geom_violin(fill = "slateblue", color = "orchid", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "orchid", outlier.shape = NA) +
  labs(x = "School Resources", y = "GAD7 Score", title = "GAD7 Score by School Resource") +
  theme_classic()

Schl_ResVsGAD_plot7

# Mean GAD by School Resources
Schl_ResMeanGAD <- shamiri_data %>%
  group_by(School_Resources) %>%
  summarize(meanGAD = mean(cum_sum_gad), meanPHQ = mean(cum_sum_phq), meanMSSS = mean(cum_sum_msss))
Schl_ResMeanGAD

# Bar Plot
Schl_ResVsMeanGAD_plot <- ggplot(Schl_ResMeanGAD, aes(x = School_Resources, y = meanGAD, fill = School_Resources)) +
  geom_bar(stat = "identity", width = 0.8, color = "black") +
  labs(x = "School Resources", y = "Mean GAD Score", title = "Mean GAD Scores by School Resources") +
  scale_fill_manual(values = c("slateblue", "navyblue", "lightblue")) +
  theme_classic()

Schl_ResVsMeanGAD_plot

# Combine the GAD plots by School Resources
combined_Schl_ResPlots <- Schl_ResVsGAD_plot1 + Schl_ResVsGAD_plot2 + Schl_ResVsGAD_plot3 + Schl_ResVsGAD_plot4 +
  Schl_ResVsGAD_plot5 + Schl_ResVsGAD_plot6 + Schl_ResVsGAD_plot7 + plot_annotation(title = "Combined Violing Plots by School Resources")
combined_Schl_ResPlots


