# Pewlett_Hackard_Analysis

## Challenge Summary

For this challenge, we are tasked to to a) find the number of positions by title that will be opening up due to retiring employees, and b) find the number of current employees eligible for the mentorship program. The parameters for each are below:

Retiring:
- Current employees
- Employees born between the years 1952 and 1955
- Employees who were hired between 1985 and 1988

Mentorship:
- Current employees
- Employees born in the year 1965

To solve this challenge, we have access to the complete database of information. The databse, however, is broken down into multiple tables. Instead of one table containing all the information, we have to sort through the tables to pick the information we need gathered. To better visualize the tables within the database and their relationships, we created an entity relationship diagram, or ERD. There are several versions of ERD, the most inclusive being a physical diagram, which inclues the the tables and column headers, data types, and their relationships to one another. For this assignmnet, our first step was to create one from the available information:

![schema.png](https://github.com/evanmgoodwin/Pewlett_Hackard_Analysis/blob/master/schema.png)

As we can see from the above ERD (also known as a schema), there are several tables that contain corresponding columns in other tables. At a glance, we can tell that emp_no is the most prevalent. Since the information we need isnt't arranged in a single table, we had to utilize an "inner join" to combine the employees table and titles table (see challenge_queries.sql). By joining these two tables, we were able to get the information needed for retiring employees in a single dataset. When joining tables, we can use conditional statements to specify the parameters we want for our new, joined table. In this instance, we used the "where" and subsequent "and" conditions to specify:
- birth date (between 1952 and 1955)
- hire date (between 1985 and 1988)
- to date (specified as '9999-01-01' to include current employees)
The resulting table included only employees from the first table (employees)

With the table built, we were able to perform a "count" on the retiring employees, grouped by job title. This gave us the following count:
![retiring_titles.png](https://github.com/evanmgoodwin/Pewlett_Hackard_Analysis/blob/master/titles_retiring.png)
