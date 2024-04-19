
Combo Analytics Engineer skill test
================
***Estimated duration*** from 2 to 4 hours according candidates experience in dbt

# Table of Contents
1. [Disclaimer](#disclaimer)
2. [Context](#context)
3. [Objectives of the Test](#objectives-of-the-test)
4. [Questions](#questions)
5. [Instructions](#instructions)
6. [Communication](#communication)

# Disclaimer
This case study is intended solely as a technical evaluation tool for hiring purposes. The final result will not be used for any business-related matters or legal considerations. Please be aware of the limited scope and purpose of this study.

# Company context
Founded in 2016, Combo is a SaaS company that simplifies HR for small businesses and their field teams. Initially operating on a subscription-based model with fixed pricing that was determined at the beginning of the contract, the company decided to migrate to a new usage-based pricing model. This transition is central to the company’s growth strategy and required changes to the way we operate internally.

## Example of the pricing transition
In order to fully grasp the implications of this transition, let's consider a concrete example involving a fictional client, referred to as "Customer A."

**Fixed pricing (Prior to 2023):**
- The pricing grid per location was the following:
    - 1-5 employees : 49€
    - 6-10 employees : 99€
    - 11-30 employees : 199€
    - 31+ employees : 299€
- In January 2021, the client started a subscription with Combo for 2 locations distributed as follows:
    - Location 1 (10 employees) : 99€
    - Location 2 (5 employees) : 49€

    For a total of 148€.

- In February 2022, the client had 5 locations distributed as follows:
    - Location 1 (10 employees) : 99€
    - Location 2 (5 employees) : 49€
    - Location 3 (30 employees) : 199€
    - Location 4 (5 employees) : 49€
    - Location 5 (5 employees) : 49€

    For a total of 445€ but he was still charged the same price of 148€ if he added these locations without contacting our sales team.

**Consumption-based pricing (Starting in 2023):**
- With the new pricing model, we explain to the clients that the pricing will depend on his usage as follows:
    - **Location pricing**

        The pricing based on the number of employees in the location:
        - micro location (0-5 employees) : 60€
        - small location (6-39 employees) : 80€
        - big location (40+ employees) : 216€

    - **Employee pricing**

        6 employees are included in the location pricing. The pricing for additional employees is the following:
        - 7-39 employees : 4€ per employee
        - 40+ employees : 2.4€ per employee
- On the new pricing, Customer A would have been charged in February 2022 as follows:
    - Location 1 (10 employees) : 80€ + 3 * 4€ = 92€
    - Location 2 (5 employees) : 60€
    - Location 3 (30 employees) : 80€ + 24 * 4€ = 176€
    - Location 4 (5 employees) : 60€
    - Location 5 (5 employees) : 60€

    For a total of 448€.
- To achieve the transition, we need to define what are the locations to bill and what are the billable employees for each location.
    - Billable employees: We consider that an employee is to be billed on his contract location if he was scheduled (with a shift or a rest) at least once in the week (independent of the location where his rest/shift happened).
    - Billable locations: We bill any location that is not archived. The size of the location is determined by the number of billable employees.
    - We measure these number on a weekly basis then a downstream process handles the averaging for the monthly invoicing.

# Objectives of the Test
1. To evaluate proficiency in designing and implementing effective data models, addressing a critical business process.
2. To assess the knowledge of dimensional modeling techniques
3. To assess proficiency in SQL and / or dbt framework

# Questions
Your data models should be designed to answer the following questions:
1. What are the number of billable locations and billable employees per week for each account?
2. What is the expected weekly revenue per account on the new pricing model?

# Instructions
## Setup
**Datasets** : You will work with 5 csvs, that are in the `data.zip`, file with the following structure:
- `accounts.csv` : Contains the list of accounts.
- `locations.csv` : Contains the list of locations.
- `memberships.csv` : Contains the list of the employees.
- `rests.csv` : Contains the list of rests.
- `shifts.csv` : Contains the list of shifts.
- `user_contracts.csv` : Contains the list of contracts.

**Database selection** : You are free to use any SQL based database of your choice, it will not be evaluated.
## Transformation
You will need to write transformation to create new tables from our source to answer the questions. You can do plain SQL or if you are already comfortable with it use dbt which is the transformation framework we use internally.

## Deliverables
1. Host your project on a public git repository (i.e. GitHub), which should include the dbt project and other relevant files.
2. Provide a README.md file with the following information:
    - A brief description of the project.
    - Instructions on how to set up the project.
    - Instructions on how to run the project.
    - Any assumptions you made.
    - Any additional information you would like to share.
3. Once you have completed the test, please share the link to the repository with us.

# Communication
If you have any questions or need clarification, please reach out to Adam Makhlouf at **adam.makhlouf@combohr.com**. We encourage you to document any assumptions or decisions you make in the README file.