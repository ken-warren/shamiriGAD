# Analysis of Mental Health Disorder Among Teens in Kenya.

## Table of Contents
- [Overview](#overview)
- [Research Question](#research-question)
- [Aims](#aims)
- [Data Source](#data-source)
- [Data Wrangling](#data-wrangling)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Results](#results)

## Overview
Developing low-cost, culturally appropriate, and scalable interventions for youth depression and anxiety in low-income regions, such as sub-Saharan Africa, is a global mental health priority. The [Shamiri](https://www.bing.com/ck/a?!&&p=8600acd94b66e625JmltdHM9MTcxNzAyNzIwMCZpZ3VpZD0xNDI4MDJjOS02NGIwLTY2MmQtMmI5MS0xNjRhNjU1ZDY3MDEmaW5zaWQ9NTE5OA&ptn=3&ver=2&hsh=3&fclid=142802c9-64b0-662d-2b91-164a655d6701&psq=shamiri+&u=a1aHR0cHM6Ly93d3cuc2hhbWlyaS5pbnN0aXR1dGUv&ntb=1) intervention was specifically designed for adolescents in Kenya. The name “Shamiri” means “thrive” in Swahili, emphasizing its positive impact. The intervention draws upon evidence-based components from brief interventions that focus on nonclinical principles (e.g., growth mindset, gratitude, and virtues) rather than direct treatment of psychopathology.

## Research Question
**What is the relationship between the GAD and demographics such as tribe, gender, school and age?**

## Aims
1. To perform exploratory data analysis on the data
2. To visualize the data

## Data Source
Data Source: [Download CSV file](shamiri_imputed_dataset.csv).
The data was obtained from a Shamiri [questionnaire](https://github.com/ken-warren/gad-shamiri/blob/main/Baseline%20Measures%20for%20Schools.pdf) administered to the study's participants.
To understand the nature of the variables, you can click [here](https://github.com/ken-warren/gad-shamiri/blob/main/variables.md)

## Data Wrangling
The data was thoroughly checked for missing and duplicated values. There was no missing /duplicated values, hence no need for data cleaning. For better visualization, the ```Age``` variable was categorized into three groups;
- Less than 15 years
- 15 - 18 years, and
- More than 18 years

## Exploratory Data Analysis
Steps taken in this phase included;
1. Calculating overall GAD, PHQ and MSSS mean.
2. Calculating the GAD, PHQ and MSSS means within each demographic setting, i.e Age, Gender, Tribe etc.
3. Visualizing the data to help understand the research question

The following R packages were essential to achieve the above;
```r
library(ggplot2)
library(tidyverse)
library(dplyr)
library(patchwork)
```

## Results

## 1. Age Distribution.


![ageplot_page-0001](https://github.com/ken-warren/shamiriGAD/assets/134076996/56c17930-956d-4aac-aa30-b8cfa0b9f941)

The participants' mean age was 15 years with some of the study's participants having a minimum age of 12 years and a maximum age of 24 years. Most of the study's participants were aged 15 years (199).

![combined_ageplots_page-0001](https://github.com/ken-warren/shamiriGAD/assets/134076996/e67a4c9d-5b4c-4f61-a466-61f51cdcfb53)


## Overall GAD-7, PHQ-8 and MSSS-12 Means Scores 

The overall means scores were;
- ```GAD-7``` = 8.12 (Mild anxiety)
- ```PHQ-8``` = 9.23 (Moderate depressive symptoms)
- ```MSSS-12``` = 60.10 (support)

## GAD1 to GAD7 Score Across School Resources 

![RViolinPlots_page-0001](https://github.com/ken-warren/shamiriGAD/assets/134076996/ed545825-002d-45f7-98f4-6c51f959ad90)


### Average Generalized Anxiety Disorder (GAD) Scores by Demographic Characteristics
The overall mean score for GAD was 8.12 (Mild anxiety). From the bar graph below, we deduced that;
- GAD was more prevalent in minority tribes (8.49) compared to majority tribes (7.41).
- Females reported higher levels of GAD (8.64) compared to males (7.57).
- Participants less than 15 years had a lower GAD mean score (6.74) compared to those more than 18 years (10.8).
- Those whose school resources were poor had a higher GAD mean score (9.05) compared to those whose school resources were rich (7.73).
- Elite School showed high GAD mean score 9.30 compared to AHS whose GAD mean score was 6.97

  ![Rplot_GAD](https://github.com/ken-warren/shamiriGAD/assets/134076996/2c4cf698-bc82-4227-9d30-69a26a1dd262)


### Average Patient Health Questionnaire-9 (PHQ-9) Scores by Demographic Characteristics

  ![Rplot_PHQ](https://github.com/ken-warren/shamiriGAD/assets/134076996/d273e170-4a05-4794-a981-be0884035efc)


### Average Multidimensional Scale of Perceived Social Support (MSSS) Scores by Demographic Characteristics

  ![Rplot_MSSS](https://github.com/ken-warren/shamiriGAD/assets/134076996/e199b36c-9b5f-4753-bbb5-a639dbebf4f8)
