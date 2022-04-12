# Binary Tree Nodes

- [Description of the problem](#description-of-the-problem)
- [Solutions](#solutions)
  - [MySQL](#mysql)
    - [Process](#process)
    - [Answer](#answer)

## Description of the problem
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Column | Type 
--- | ---
N | Integer
P | Integer

Write a query to find the node type of Binary Tree ordered by the value of the node. Output of the following for each node: 
- **Root**: If node is root node 
- **Leaf**: If node is leaf node
- **Inner**: If node is neither root nor leaf node

**Sample Input**

N | P 
--- | ---
1 | 3
3 | 2
6 | 8
9 | 8
2 | 5
8 | 5
5 | null

**Sample output**
1 Leaf
2 Inner
3 Leaf
5 Root 
6 Leaf
8 Inner
9 Leaf

## Solutions

### MySQL

#### Process

1. First, we have to find the root node. That is, the node that does not have a parent node. 
We can implement it with MySQL as follows:

```sql
SELECT 
  CASE 
    WHEN P IS NULL THEN CONCAT(N, " Root")
  END
FROM BST;
```

2. Then we have to find the Inner nodes. These nodes are characterized by have child nodes. That means that the identifier of these nodes must be in the P column.

```sql
SELECT
  CASE
    WHEN P IS NULL THEN CONCAT(N, " Root")
    WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, " Inner")
  END
FROM BST;
```

3. We can identify the Leaf nodes because they do not accomplish the prior conditions.
```sql
SELECT
  CASE
    WHEN P IS NULL THEN CONCAT(N, " Root")
    WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, " Inner")
    ELSE CONCAT(N, " Leaf")
  END
FROM BST;
```

4. The last step is to order the values by the N column.

```sql
SELECT
  CASE
    WHEN P IS NULL THEN CONCAT(N, " Root")
    WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, " Inner")
    ELSE CONCAT(N, " Leaf")
  END
FROM BST
ORDER BY N ASC;
```


#### Answer

```sql
SELECT
  CASE
    WHEN P IS NULL THEN CONCAT(N, " Root")
    WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, " Inner")
    ELSE CONCAT(N, " Leaf")
  END
FROM BST
ORDER BY N ASC;
```
