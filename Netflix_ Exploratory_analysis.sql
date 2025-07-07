-- Exploratory Analysis

--  1. View structure of the table
Select *
From netflix_titles_cleaned;

DESCRIBE netflix_titles_cleaned;

-- 2. Preview the first 10 records
SELECT * 
FROM netflix_titles_cleaned
LIMIT 10;

-- 3. Total number of titles in the dataset
SELECT COUNT(*) AS total_titles
FROM netflix_titles_cleaned;

-- 4. Distribution of content type (Movies vs TV Shows)
SELECT type, COUNT(*) AS count
FROM netflix_titles_cleaned
GROUP BY type
ORDER BY count DESC;

-- 5. Top 10 countries producing the most content
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles_cleaned
WHERE country != 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- 6. Number of titles released by year
SELECT release_year, COUNT(*) AS total_released
FROM netflix_titles_cleaned
WHERE release_year != 0
GROUP BY release_year
ORDER BY release_year desc;

-- 7. Number of titles added to Netflix by year
SELECT year_added, COUNT(*) AS added_count
FROM netflix_titles_cleaned
WHERE year_added != 0
GROUP BY year_added
ORDER BY year_added;

-- 8. Monthly distribution of content added
SELECT month_added, COUNT(*) AS total
FROM netflix_titles_cleaned
WHERE month_added != 'Unknown'
GROUP BY month_added
ORDER BY FIELD(month_added, 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

-- 9. Most frequent content ratings (e.g., TV-MA, PG, etc.)
SELECT rating, COUNT(*) AS total
FROM netflix_titles_cleaned
WHERE rating != 'Unknown'
GROUP BY rating
ORDER BY total DESC;

-- 10. Top 10 most common genres or categories
SELECT listed_in, COUNT(*) AS total
FROM netflix_titles_cleaned
GROUP BY listed_in
ORDER BY total DESC
LIMIT 10;

-- 11. Top 10 directors with the most titles
SELECT director, COUNT(*) AS total
FROM netflix_titles_cleaned
WHERE director != 'Unknown'
GROUP BY director
ORDER BY total DESC
LIMIT 10;

-- 12. Number of titles per country and type
SELECT country, type, COUNT(*) AS total
FROM netflix_titles_cleaned
WHERE country != 'Unknown'
GROUP BY country, type
ORDER BY total DESC
LIMIT 20;

--  13. Year with the most new Netflix content added
SELECT year_added, COUNT(*) AS new_titles
FROM netflix_titles_cleaned
WHERE year_added != 0
GROUP BY year_added
ORDER BY new_titles DESC
LIMIT 1;

-- 14. Most popular genres by type
SELECT type, listed_in, COUNT(*) AS total
FROM netflix_titles_cleaned
GROUP BY type, listed_in
ORDER BY type, total DESC;