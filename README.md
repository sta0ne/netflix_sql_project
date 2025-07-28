# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/sta0ne/netflix_sql_project/blob/main/netflix%20logo.jpg)

## Overview

This project involves performing exploratory data analysis on a Netflix dataset using SQL. The goal is to uncover patterns, trends, and insights about the content available on Netflix.

## Objective

To analyze the Netflix catalog using SQL to answer important business and user-related questions such as:

- What kind of content is most common on Netflix?
- Which countries produce the most content?
- How has content distribution changed over the years?
- Which actors and directors appear most frequently?




## Dataset

The dataset used in this project was sourced from Kaggle:
[Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```
## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT type,COUNT(*) AS count_movies_tvshows FROM netflix
GROUP BY type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
select 
     type,
	 rating
from(
     select 
         type,
 	     rating,
	     count(*),
	     rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by type,rating) as t1
  where ranking=1
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
select * from netflix
where release_year = 2020 and type = 'Movie';
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
select 
     unnest(string_to_array(country,',')) as new_country,
	 count(show_id) as total_content
from netflix
group by unnest(string_to_array(country,','))
order by total_content desc
limit 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
select * from netflix 
where 
     type= 'Movie' 
	 and 
	 duration = (select max(duration) from netflix)
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
select 
* 
from netflix 
where to_date(date_added, 'Month DD, YYYY')>= current_date - interval '5 years'
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
select * from netflix
where director ilike '%Rajiv Chilaka%'
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
select 
    * 
from netflix 
where
     type = 'TV Show'
	 and 
	 split_part(duration,' ', 1):: numeric > 5
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
select
      unnest(string_to_array(listed_in,',')) as genre,
	  count(show_id) as total_content
from netflix 
group by  unnest(string_to_array(listed_in,','))
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
return top 5 year with highest avg content release!
select 
      extract(year from to_date(date_added, 'Month DD, YYYY'))  yearr,
      count(*) yearly_content,
	  round(count(*)::numeric/(select count(*) from netflix where country ='India')::numeric * 100,2)  avg_content_per_year
	  from netflix 
	  where country ='India'
	  group by  extract(year from to_date(date_added, 'Month DD, YYYY')) 
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
select * from netflix 
where type = 'Movie' and listed_in like '%Documentaries%';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
select 
* 
from netflix 
where director is null;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
select * from netflix 
where 
     casts like '%Salman Khan%'
	 and
	 release_year > extract( year from current_date) - 10
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
select 
     unnest(string_to_array(casts,',')) as actors,
	 count(*) as total_content
from netflix
where country ilike '%India%'
group by unnest(string_to_array(casts,','))
order by total_content desc
limit 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
with new_table as
(select 
     *,
	 case 
	 when 
	     description ilike '%kill%' or
		 description ilike '%violence%' then 'Bad_content'
		 else 'Good content'
		 end category
from netflix
)
select category,
       count(*) as total_content
from new_table
group by 1
```
**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Contact

Feel free to reach out to me:

- LinkedIn: [linkedin.com/in/yourusername](https://www.linkedin.com/in/stavan-mohod-3817a7331?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
  




