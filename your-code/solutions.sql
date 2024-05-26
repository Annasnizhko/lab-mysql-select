-- Challenge 1 - Who Have Published What At Where?


WITH tab1 as ( SELECT au_lname, au_fname, title_id
FROM authors INNER JOIN titleauthor 
ON authors.au_id = titleauthor.au_id ),
tab2 as ( SELECT au_lname, au_fname, title, pub_id
FROM tab1 INNER JOIN titles 
ON tab1.title_id = titles.title_id ),
tab3 as (SELECT au_lname as "LAST NAME", au_fname as "FIRST NAME", title as "TITLE", pub_name as "PUBLISHER"
FROM tab2 INNER JOIN publishers 
ON  tab2.pub_id = publishers.pub_id)
SELECT *
from tab3;

SELECT count(*)
from titleauthor;

-- Challenge 2 - Who Have Published How Many At Where?

WITH tab1 as ( SELECT authors.au_id, au_lname, au_fname, title_id
FROM authors INNER JOIN titleauthor 
ON authors.au_id = titleauthor.au_id ),
tab2 as ( SELECT au_id, au_lname, au_fname, title, pub_id
FROM tab1 INNER JOIN titles 
ON tab1.title_id = titles.title_id ),
tab3 as (SELECT au_id as "AUTHOR ID ", au_lname as "LAST NAME", au_fname as "FIRST NAME", count(title) as "TITLE COUNT", pub_name as "PUBLISHER"
FROM tab2 INNER JOIN publishers 
ON  tab2.pub_id = publishers.pub_id
GROUP BY au_id, au_lname, au_fname, pub_name)
SELECT *
from tab3;

-- Challenge 3 - Best Selling Authors

WITH tab1 as ( SELECT authors.au_id, au_lname, au_fname, title_id
FROM authors INNER JOIN titleauthor 
ON authors.au_id = titleauthor.au_id ),
tab2 as ( SELECT au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", SUM(qty) as "TOTAL"
FROM tab1 INNER JOIN sales 
ON tab1.title_id = sales.title_id 
GROUP BY au_id, au_lname, au_fname
ORDER BY SUM(qty) desc
LIMIT 3)
SELECT *
from tab2;

-- Challenge 4 - Best Selling Authors Ranking

WITH tab1 as ( SELECT authors.au_id, au_lname, au_fname, title_id
FROM authors INNER JOIN titleauthor 
ON authors.au_id = titleauthor.au_id ),
tab2 as ( SELECT au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", SUM(qty) as "TOTAL"
FROM tab1 LEFT JOIN sales 
ON tab1.title_id = sales.title_id 
GROUP BY au_id, au_lname, au_fname
ORDER BY SUM(qty) desc)
SELECT *
from tab2;

