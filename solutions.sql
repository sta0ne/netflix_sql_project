-- Netflix Project
DROP TABLE IF EXISTS netflix;
 CREATE TABLE netflix
   (show_id	VARCHAR(6),
   type VARCHAR(10),
   title VARCHAR(150),
   director VARCHAR(208),
   casts VARCHAR(1000),
   country VARCHAR(150),
   date_added VARCHAR(50),
   release_year INT,
   rating VARCHAR(10),
   duration VARCHAR(15),
   listed_in VARCHAR(100),
   description VARCHAR(250)
   );

   select * from netflix;


-- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows

SELECT type,COUNT(*) AS count_movies_tvshows FROM netflix
GROUP BY type;

--2. Find the most common rating for movies and TV shows
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

--3. List all movies released in a specific year (e.g., 2020)

select * from netflix
where release_year = 2020 and type = 'Movie';

--4. Find the top 5 countries with the most content on Netflix

select 
     unnest(string_to_array(country,',')) as new_country,
	 count(show_id) as total_content
from netflix
group by unnest(string_to_array(country,','))
order by total_content desc
limit 5;

--5. Identify the longest movie

select * from netflix 
where 
     type= 'Movie' 
	 and 
	 duration = (select max(duration) from netflix)
	 
--6. Find content added in the last 5 years

select 
* 
from netflix 
where to_date(date_added, 'Month DD, YYYY')>= current_date - interval '5 years'


--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix
where director ilike '%Rajiv Chilaka%'

--8. List all TV shows with more than 5 seasons
select 
    * 
from netflix 
where
     type = 'TV Show'
	 and 
	 split_part(duration,' ', 1):: numeric > 5

--9. Count the number of content items in each genre
select
      unnest(string_to_array(listed_in,',')) as genre,
	  count(show_id) as total_content
from netflix 
group by  unnest(string_to_array(listed_in,','))

	  
--10.Find each year and the average numbers of content release in India on netflix.
return top 5 year with highest avg content release!
select 
      extract(year from to_date(date_added, 'Month DD, YYYY'))  yearr,
      count(*) yearly_content,
	  round(count(*)::numeric/(select count(*) from netflix where country ='India')::numeric * 100,2)  avg_content_per_year
	  from netflix 
	  where country ='India'
	  group by  extract(year from to_date(date_added, 'Month DD, YYYY')) 


--11. List all movies that are documentaries

select * from netflix 
where type = 'Movie' and listed_in like '%Documentaries%';

--12. Find all content without a director

select 
* 
from netflix 
where director is null;


--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix 
where 
     casts like '%Salman Khan%'
	 and
	 release_year > extract( year from current_date) - 10


--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select 
     unnest(string_to_array(casts,',')) as actors,
	 count(*) as total_content
from netflix
where country ilike '%India%'
group by unnest(string_to_array(casts,','))
order by total_content desc
limit 10;

15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.


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




   