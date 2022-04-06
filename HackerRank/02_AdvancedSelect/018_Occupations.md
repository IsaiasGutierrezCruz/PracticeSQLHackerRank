# Occupations

- [Description of the problem](#description-of-the-problem)
- [Solutions](#solutions)
  - [MySQL](#mysql)
    - [Process](#process)
    - [Answer](#answer)

## Description of the problem
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:
Column | Type 
--- | ---
Name | String
Occupation | String

Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor

**Sample input**
Name | Occupation
--- | ---
Samantha | Doctor 
Julia | Actor 
Maria | Actor 
Meera | Singer 
Ashely | Professor
Ketty | Professor
Christeen | Professor
Jane | Actor 
Jenny | Doctor 
Priya | Singer

**Sample output**

```
Jenny Asshley Meera Jane 
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria
```

**Explanation**

The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.

---

## Solutions

### MySQL

#### Process

1. The first step is create a column for each occupation. We have to evaluate in each row of the original table what column corresponds with the current person and put his/her name in it. In the rest of the columns, we assign NULL. 

```sql
SELECT 
  IF(Occupation="Doctor", Name, NULL) AS Doctor,
  IF(Occupation="Professor", Name, NULL) AS Professor,
  IF(Occupation="Singer", Name, NULL) AS Singer,
  IF(Occupation="Actor", Name, NULL) AS Actor
FROM OCCUPATIONS;
```

The result of this query is the following:


Doctor | Professor | Singer | Actor 
--- | --- | --- | --- 
NULL | Ashley | NULL | NULL
NULL |NULL| NULL | Samantha
Julia |NULL |NULL| NULL
NULL |Britney| NULL |NULL
NULL |Maria| NULL| NULL
NULL |Meera| NULL| NULL
Priya |NULL| NULL |NULL
NULL| Priyanka |NULL |NULL


2. The next step is to select the values which will belong to each row. That is, we have to assign the value "1" to the first capable rows to form a new row without NULL values.
In the following example, we can see that the rows in positions number 1, 2, 3, and 5 can form a full new row with the people's names.

RowsNumber | Doctor | Professor | Singer | Actor 
--- | --- | --- | --- | --- 
1 | NULL |Ashley |NULL |NULL
1 |NULL |NULL |NULL |Samantha
1 |Julia| NULL| NULL| NULL
2 |NULL |Britney| NULL| NULL
1 |NULL |NULL |Jane| NULL
3 |NULL |Maria |NULL |NULL


We can achieve this by using variables in MySQL with the following syntax: `SET @name_variable := <value>`. Specifically, we have to create a variable for each column in order to assign the position where we want to put each person. These new numbers will be stored in a new column called RowsNames. One of the requirements is that we have to sort alphabetically the data. We can use the "order by" statement. 

The query until now looks like this:

```sql
SET @rows_doctor:=0, @rows_professor:=0, @rows_singer:=0, @rows_actor:=0; 
SELECT 
  CASE
    WHEN Occupation="Doctor" THEN (@rows_doctor := @rows_doctor + 1)
    WHEN Occupation="Professor" THEN (@rows_professor := @rows_professor + 1)
    WHEN Occupation="Singer" THEN (@rows_singer := @rows_singer + 1)
    WHEN Occupation="Actor" THEN (@rows_actor:=@rows_actor + 1)
  END AS RowsNumber, 
  IF(Occupation="Doctor", Name, NULL) AS Doctor,
  IF(Occupation="Professor", Name, NULL) AS Professor,
  IF(Occupation="Singer", Name, NULL) AS Singer,
  IF(Occupation="Actor", Name, NULL) AS Actor
FROM OCCUPATIONS
ORDER BY Name;
```

3. The last step is to use the data generated in the temporary table, called temp_table in this example, in a new query. First, we have to group the data using the RowsNumber column. Then, use the SELECT and MIN statements in each column in order to select the people's names from each new row given the values from the RowsNumber column. 

```sql
SET @rows_doctor:=0, @rows_professor:=0, @rows_singer:=0, @rows_actor:=0; 
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM(
  SELECT 
    CASE
      WHEN Occupation="Doctor" THEN (@rows_doctor := @rows_doctor + 1)
      WHEN Occupation="Professor" THEN (@rows_professor := @rows_professor + 1)
      WHEN Occupation="Singer" THEN (@rows_singer := @rows_singer + 1)
      WHEN Occupation="Actor" THEN (@rows_actor:=@rows_actor + 1)
    END AS RowsNumber, 
    IF(Occupation="Doctor", Name, NULL) AS Doctor,
    IF(Occupation="Professor", Name, NULL) AS Professor,
    IF(Occupation="Singer", Name, NULL) AS Singer,
    IF(Occupation="Actor", Name, NULL) AS Actor
  FROM OCCUPATIONS
  ORDER BY Name
    ) temp_table
GROUP BY RowsNumber;
```

The result looks like this:

Doctor | Professor | Singer | Actor 
--- | --- | --- | --- 
Aamina | Ashley |Christeen| Eve
Julia| Belvet |Jane| Jennifer
Priya |Britney| Jenny| Ketty
NULL |Maria |Kristeen |Samantha
NULL |Meera| NULL |NULL
NULL |Naomi| NULL |NULL

We can see that in the rows where the table does not have any name is shown a NULL value.

#### Answer

```sql
SET @rows_doctor:=0, @rows_professor:=0, @rows_singer:=0, @rows_actor:=0; 
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM(
  SELECT 
    CASE
      WHEN Occupation="Doctor" THEN (@rows_doctor := @rows_doctor + 1)
      WHEN Occupation="Professor" THEN (@rows_professor := @rows_professor + 1)
      WHEN Occupation="Singer" THEN (@rows_singer := @rows_singer + 1)
      WHEN Occupation="Actor" THEN (@rows_actor:=@rows_actor + 1)
    END AS RowsNumber, 
    IF(Occupation="Doctor", Name, NULL) AS Doctor,
    IF(Occupation="Professor", Name, NULL) AS Professor,
    IF(Occupation="Singer", Name, NULL) AS Singer,
    IF(Occupation="Actor", Name, NULL) AS Actor
  FROM OCCUPATIONS
  ORDER BY Name
    ) temp_table
GROUP BY RowsNumber;
```


