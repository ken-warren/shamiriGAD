# Load the required dataset
library(ggplot2)
library(tidyverse)
library(dplyr)
library(patchwork)

#Load and view the data
data <- read.csv("shamiri_imputed_dataset.csv", header = TRUE)

head(data)

# Data Checks
str(data)

which(is.na(data))
which(duplicated(data))

# Grouping the ages
data$Age_group <- ifelse(data$Age < 15, "Less than 15 years",
                         ifelse(data$Age >= 15 & data$Age <= 18, "15 - 18 years", "More than 18 years"))

# EDA
# overall GAD mean score
data <- data %>%
  mutate(cum_sum_gad = rowSums(select(., GAD1:GAD7)))

overall_gad_mean <- mean(data$cum_sum_gad, na.rm = TRUE)
overall_gad_mean

# Overall PHQ mean score
data <- data %>%
  mutate(cum_sum_phq = rowSums(select(., PHQ1:PHQ8)))

overall_phq_mean <- mean(data$cum_sum_phq, na.rm = TRUE)
overall_phq_mean

#Overall MSSS mean score
data <- data %>%
  mutate(cum_sum_msss=rowSums(select(., MSSS1:MSSS12)))
overall_msss_mean <- mean(data$cum_sum_msss,na.rm = TRUE)
overall_msss_mean

#Mean Scores by Tribe
grouped_data_1 <- data %>%
  group_by(Tribe) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# Bar chart representation
plot1 <- ggplot(grouped_data_1, aes(x = Tribe, y = mean_GAD, fill = Tribe)) +
  geom_bar(stat = "identity") +
  labs(x = "Tribe", y = "Mean GAD Score", title = "Mean GAD Scores by Tribe")

# Mean Scores by Gender
grouped_data_2 <- data %>%
  group_by(Gender) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar graph visualization
plot2 <- ggplot(grouped_data_2, aes(x = Gender, y = mean_GAD, fill = Gender)) +
  geom_bar(stat = "identity") +
  labs(x = "Gender", y = "Cumulative GAD Score", title = "A Bar Graph on GAD Scores by Gender")

# Scores by School Resources
grouped_data_3 <- data %>%
  group_by(School_Resources) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

plot3 <- ggplot(grouped_data_3, aes(x = School_Resources, y = mean_GAD, fill = School_Resources)) +
  geom_bar(stat = "identity") +
  labs(x = "School_Resources", y = "Mean GAD Score", title = "Mean GAD Scores by School Resources")

#Mean Scores by School
grouped_data_4 <- data %>%
  group_by(School) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar chart visualization
plot4 <- ggplot(grouped_data_4, aes(x = School, y = mean_GAD, fill = School)) +
  geom_bar(stat = "identity") +
  labs(x = "School", y = "Mean GAD Score", title = "Mean GAD Scores by School")

# Mean scores by Age group
grouped_data_5 <- data %>%
  group_by(Age_group) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar plot
plot5 <- ggplot(grouped_data_5, aes(x = Age_group, y = mean_GAD, fill = Age_group)) +
  geom_bar(stat = "identity") +
  labs(x = "Age Group", y = "Cumulative GAD Score", title = "GAD Scores by Age Group")

# Combine the plots
gad_plots <- plot1 + plot2 + plot3 + plot4 + plot5
gad_plots


# Mean Scores by Tribe
grouped_data_1 <- data %>%
  group_by(Tribe) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# Bar chart representation
plot6 <- ggplot(grouped_data_1, aes(x = Tribe, y = mean_PHQ, fill = Tribe)) +
  geom_bar(stat = "identity") +
  labs(x = "Tribe", y = "Mean PHQ Score", title = "Mean PHQ Scores by Tribe")

# GAD Mean Scores by Gender
grouped_data_2 <- data %>%
  group_by(Gender) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar graph  visualization
plot7 <- ggplot(grouped_data_2, aes(x = Gender, y = mean_PHQ, fill = Gender)) +
  geom_bar(stat =  "identity") +
  labs(x = "Gender", y = "Cumulative PHQ Score", title = "A boxplot on PHQ Scores by Gender")

# Mean Scores by School Resources
grouped_data_3 <- data %>%
  group_by(School_Resources) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

plot8 <- ggplot(grouped_data_3, aes(x = School_Resources, y = mean_PHQ, fill = School_Resources)) +
  geom_bar(stat = "identity") +
  labs(x = "School_Resources", y = "Mean PHQ Score", title = "Mean PHQ Scores by School Resources")

#Mean Scores by School
grouped_data_4 <- data %>%
  group_by(School) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar chart visualization
plot9 <- ggplot(grouped_data_4, aes(x = School, y = mean_PHQ, fill = School)) +
  geom_bar(stat = "identity") +
  labs(x = "School", y = "Mean PHQ Score", title = "Mean PHQ Scores by School")

# Mean scores by Age
grouped_data_5 <- data %>%
  group_by(Age_group) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar plot
plot10 <- ggplot(grouped_data_5, aes(x = Age_group, y = mean_PHQ, fill = Age_group)) +
  geom_bar(stat = "identity") +
  labs(x = "Age", y = "Cumulative PHQ Score", title = "PHQ Scores by Age Group")

# Combine the plots
phq_plots <- plot6 + plot7 + plot8 + plot9 + plot10
phq_plots


# Mean Scores by Tribe
grouped_data_1 <- data %>%
  group_by(Tribe) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# Bar chart representation
plot11 <- ggplot(grouped_data_1, aes(x = Tribe, y = mean_MSSS, fill = Tribe)) +
  geom_bar(stat = "identity") +
  labs(x = "Tribe", y = "Mean MSSS Score", title = "Mean MSSS Scores by Tribe")

# GAD Mean Scores by Gender
grouped_data_2 <- data %>%
  group_by(Gender) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# boxplot visualization
plot12 <- ggplot(grouped_data_2, aes(x = Gender, y = mean_MSSS, fill = Gender)) +
  geom_bar(stat = "identity") +
  labs(x = "Gender", y = "Cumulative MSSS Score", title = "Mean MSSS Scores by Gender")

# GAD Mean Scores by School Resources
grouped_data_3 <- data %>%
  group_by(School_Resources) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

plot13 <- ggplot(grouped_data_3, aes(x = School_Resources, y = mean_MSSS, fill = School_Resources)) +
  geom_bar(stat = "identity") +
  labs(x = "School Resources", y = "Mean MSSS Score", title = "Mean MSSS Scores by School Resources")

# Mean Scores by School
grouped_data_4 <- data %>%
  group_by(School) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# bar chart visualization
plot14 <- ggplot(grouped_data_4, aes(x = School, y = mean_MSSS, fill = School)) +
  geom_bar(stat = "identity") +
  labs(x = "School", y = "Mean MSSS Score", title = "Mean MSSS Scores by School")

# Mean scores by Age group
grouped_data_5 <- data %>%
  group_by(Age_group) %>%
  summarize(mean_GAD = mean(cum_sum_gad), mean_PHQ = mean(cum_sum_phq),mean_MSSS=mean(cum_sum_msss))

# Bar plot
plot15 <- ggplot(grouped_data_5, aes(x = Age_group, y = mean_MSSS, fill = Age_group)) +
  geom_bar(stat = "identity")
labs(x = "Age group", y = "Cumulative MSSS Score", title = "MSSS Scores by Age Group")

# Combine the plots
msss_plots <- plot11 + plot12 + plot13 + plot14 + plot15
msss_plots

