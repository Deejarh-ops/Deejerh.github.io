-- exploratory data analysis

Select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT MIN(DATE), MAX(DATE)
From layoffs_staging2;

select industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


select *
From layoffs_staging2;

select country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


select year(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY year(date)
ORDER BY 1 DESC;


select stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


select company, avg(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

Select substring(date, 6, 2) as 'month', sum(total_laid_off)
From layoffs_staging2
where substring(date, 6, 2)
group by month
order by 1 asc;


with rolling_total as
(
Select substring(date, 1, 7) as month, sum(total_laid_off) as total_off
From layoffs_staging2
where substring(date, 6, 2)
group by month
order by 1 asc
)
select month, total_off,
 sum(total_off) over(order by month) as rolling_total
from rolling_total;

select company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


select company, year(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(date)
order by 3 desc;

with company_year (company, years, total_laid_off) as 
(select company, year(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(date)
), company_year_rank as
(select *,dense_rank() over (partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select *
from company_year_rank
where ranking <=5;