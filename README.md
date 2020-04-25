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

To solve this challenge, we have access to the complete database of information. The database, however, is broken down into multiple tables. Instead of one table containing all the information, we have to sort through the tables to pick the information we need gathered. To better visualize the tables within the database and their relationships, we created an entity relationship diagram, or ERD. There are several versions of ERD, the most inclusive being a physical diagram, which inclues the the tables and column headers, data types, and their relationships to one another. For this assignmnet, our first step was to create one from the available information:

![schema.png](https://github.com/evanmgoodwin/Pewlett_Hackard_Analysis/blob/master/schema.png)

As we can see from the above ERD (also known as a schema), there are several tables that contain corresponding columns in other tables. At a glance, we can tell that emp_no is the most prevalent. Since the information we need isn't arranged in a single table, we had to utilize an "inner join" to combine the employees table and titles table (see challenge_queries.sql). By joining these two tables, we were able to get the information needed for retiring employees in a single dataset. When joining tables, we can use conditional statements to specify the parameters we want for our new, joined table. In this instance, we used the "where" and subsequent "and" conditions to specify:
- birth date (between 1952 and 1955)
- hire date (between 1985 and 1988)
- to date (specified as '9999-01-01' to include current employees)

With the table built, we were able to perform a "count" on the retiring employees, grouped by job title. The result is a table that shows us the number of positions that will be vacant as people retire from the company.

For the second part of the challenge, we performed a join to combine the employees table and title table. Similar to the first table, we specified paramters to get only the data we needed. In this case, we wanted a) employees born in 1965, and b) employees with a to-date of '9999-01-01'. Including the to-date paramter allowed us to capture only employees who are still with the company, as well their most recent job title. As employees grow within the company, their job titles change. The titles table can include the same employee multiple times. The duplicate employees are a result of the table containing every title that person ever had. By specifing the to-date as paramter, we were able to git rid of the duplicates by only pulling that employee in their current position.

From the first part of our analysis, we listed all employees who are expected to retire soon (33,118 in total) and counted the total number of positions by title that will be opening. It seems that Senior Staff and Senior Engineers will be the most in-demand:

![retiring_titles.png(https://github.com/evanmgoodwin/Pewlett_Hackard_Analysis/blob/master/titles_retiring.png)

In the second part of our analysis, we created a list of employees who will be eligible to partake in the mentorship program (1549 in total).

One apparent limitation of the first table (retiring) is its size. A recommendation would be to further break down the data into smaller sizes. One way to do this would be to group the retiring employees into separate tables by birth year. If there is a mandatory retirement age, grouping by birth year would give a more comprehensive overview of the job openings going forward on a yearly basis. For example, 90% of one position could have been born in 1955, while 90% of another could have been born in 1952. This breakdown would help in determining priority. To get a more comprehensive view of employees eligible for the mentorship program, we could condense the table to only include senior positions; ie Senior Staff, Senior engineer, etc. Those in more senior roles would be a natural fit as mentors, and it would condense those eligible into a smaller pool to choose from.
