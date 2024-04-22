# combo-test

Arthur Demuijnck
04/22/2024

## Deliverables
1. Host your project on a public git repository (i.e. GitHub), which should include the dbt project and other relevant files.

Repository link: https://github.com/ArthurDemuijnck/combo-test

2. Provide a README.md file with the following information:
    - A brief description of the project.
    - Instructions on how to set up the project.
    - Instructions on how to run the project.
    - Any assumptions you made.
    - Any additional information you would like to share.

The project's goal is to modelize Combo's new pricing. 
This pricing is based on the number of employees per location.


The set up used is a BigQuery project (combo-test-420808) 
https://console.cloud.google.com/bigquery?project=combo-test-420808.
I've added both Adam & Jerome's email addresses as Data Explorers on the project.

This project contains 2 datasets:
- RAW_IMPORT
    This contains all the raw datasets provided by Combo. All the raw datasets provided have been added as seeds in a dbt project.
- consumption_pricing
    This contains the 4 transformations needed to answer the test.
        - billable_employees: Table of billable employees and their weekly scheduled shifts or rests
        - billable_locations: Table of distinct non archived locations and their basic information
        - billable_accounts: Accounts with weekly count of billable employees and locations
        - account_weekly_pricing: Weekly account level bills

All the SQL files and definitions are in a dbt project (combo-test). 
This project contains the 4 models, the 6 seeds, documentation, tests and necessary macros.


# Questions
Your data models should be designed to answer the following questions:
1. What are the number of billable locations and billable employees per week for each account?

This question is answered thanks to the following model: billable_accounts
`select * from consumption_pricing.billable_accounts
`
This view shows weekly counts of employees and locations per account_id, filtered on only billable locations & employees.

2. What is the expected weekly revenue per account on the new pricing model?

This question is answered with the following model: account_weekly_pricing

This view computes weekly bill in € account-level.
To make it weekly, we compute it monthly then make it daily (divided by 30) to finally multiply it by 7 (to get it weekly).
