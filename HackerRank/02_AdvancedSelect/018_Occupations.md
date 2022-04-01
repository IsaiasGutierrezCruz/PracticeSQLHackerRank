# Occupations

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

Explanation

The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.

---

## Solutions

### MySQL

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
