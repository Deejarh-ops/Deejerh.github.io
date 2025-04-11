Select *
From layoffs

-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
 -- 4. Remove uncessary column

CREATE TABLE layoffs_staging
Like layoffs;

SELECT *
fROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

Select *,
ROW_NUMBER() OVER(
Partition by company, industry, total_laid_off, Percentage_laid_off, 'date') as row_num
From layoffs_staging;

WITH DUPLICATE_CTE AS
(Select *,
ROW_NUMBER() OVER(
Partition by company, location, 
industry, total_laid_off, Percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
From layoffs_staging
)
SELECT *
fROM DUPLICATE_CTE
WHERE ROW_NUM > 1;

SELECT *
fROM layoff s_staging
WHERE COMPANY = 'Casper';



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
    row_num int
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
from layoffs_staging2
WHERE ROW_NUM > 1;


INSERT INTO layoffs_staging2
Select *,
ROW_NUMBER() OVER(
Partition by company, location, 
industry, total_laid_off, Percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
From layoffs_staging;

-- STANDARING DATA
SELECT company, (trim(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = trim(company);

SELECT DISTINCT industry
from layoffs_staging2;

select *
from layoffs_staging2
where industry like 'crypto%';

UPDATE layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

select *
from layoffs_staging2
where country like 'united states%'
order by 1;

Select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'united state%';

select *
from layoffs_staging2;

select date
from layoffs_staging2;


update layoffs_staging2
set date = str_to_date(date, '%m/%d/%Y');

alter table layoffs_staging2
modify column datedate date;



select *
from layoffs_staging2
WHERE total_laid_off is NULL
And percentage_laid_off is null;

update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2 
where industry is Null
or industry = '' ;


select *
from layoffs_staging2 
where company like 'Bally%';

Select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
And t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
And t2.industry is not null;

select *
from layoffs_staging2;


delete
from layoffs_staging2
WHERE total_laid_off is NULL
And percentage_laid_off is null;


alter table layoffs_staging2
drop column row_num;

Select *
From layoffs_staging2;