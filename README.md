# Capstone Casestudy - Cyclistic bike share company

## Casestudy - Introduction 
In this case study, I analyzed Cyclistic, a bike sharing company data. I have tried to cover all the phases of the data analysis process - Ask, Prepare, Process, Analyze, Share, Act.

### 1. Ask:
This is the first phase of the sdata analytics process. This is all about asking the right questions or SMART questions.
Few of them include
* Who are the stakeholders and what are their expectations?
* What is the business Objective? Is the data available is capable of solving the business objective?
* How the data is collected?
* Who is responsible for it and what is the timeline for the process?

Business Objective: The problem that we are trying to solve - How do annual members and casual riders use Cylistic bikes differently?
Key Stakeholders: 
    1. Lily Moreno,  the director of marketing
    2. Cyclistic executive team, which will decide whether to approve the recommended marketing program.


### 2. Prepare:
In this phase we organize the data and prepare it for analysis.
Cyclistic is a fictional company, and we use historical trip data to identify trends. The data has been made available by Motivate International Inc. 
We downloaded the data from the following link. 
[Download the previous 12 months of Cyclistic trip data here](https://divvy-tripdata.s3.amazonaws.com/index.html)
The link above contains many csv files. We downloaded last 12 months data and cobined all of them to form a big dataset. 
The data is ROCCC - Reliable, Original, Comprehensive, Current and Cited. Also it helps to answer the business question.
The data is organized in rows and columns, in which each row corresponds to single ride and each column is an attribute which describe the ride.

### 3. Process:
This phase is to clean the data and make it analysis ready. 
Note: the date formats were different for few months. I Made them consistent while combining the datasets, then it is imported. 
Then, the dataset is inspected for any kind of inconsistencies like formatting, human errors and so on.
Deleted unwanted fields/coluns and adding few columns like 'ride length', and from date column extracted 'year','month','day of week','hour' to aggegate the data at different levels.
Removed Bad data: There are few entries/rows made by company for quality check, which have negative ride lengths. I eliminated them.

### 4.Analyze:
In this phase, actual analysis takes place which include aggregations, making calculations, finding the trends in the data using plots. 
First, a discriptive analysis is done by creating an overall summary of the data.
Used different aggregate functions, summarize functions and plots to compare members and casual riders. 


### 5. Share:
In this phase, we support our analysis using appropriate visualizations, we share our analysis results to the stake holders.
I have used Tableau public for the visualizations: https://public.tableau.com/app/profile/naveeth.reddy.chitti/viz/Capstonecasestudy/Dashboard1
I have created a presentation summarizing my analysis and recommendations.

### Act:
A presentation is created and the pp fil eis added to the repository. 
