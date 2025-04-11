-- Data Cleaning 
	-- Remove duplicate
    -- Standardize data
    -- Null and Blank Values
    -- Remove empty columns
    
    Create table mobiles_staging
    like mobiles;
    
    Select *
    From mobiles_staging;
    
    Insert mobiles_staging
    Select *
    From mobiles; 
    
    -- Remove duplicate
    
     Select *,
     Row_Number() Over(
     Partition by mobile_name, price, rating, specs_score, connectivity, processor, 'storage', battery, display, camera, extra_storage, os) As Row_Num
    From mobiles_staging;
    
    With Duplicate_cte As
    (
    Select *,
     Row_Number() Over(
     Partition by mobile_name, price, rating, specs_score, connectivity, processor, 'storage', battery, display, camera, extra_storage, os) As Row_Num
    From mobiles_staging
    )    
    Select * 
    From Duplicate_cte
    where Row_Num > 1;
    
    -- Checking to comfirm duplicate
	Select *
    From mobiles_staging 
    Where mobile_name = 'Apple iPhone 11';
    
With Duplicate_cte As
    (
    Select *,
     Row_Number() Over(
     Partition by mobile_name, price, rating, specs_score, connectivity, processor, 'storage', battery, display, camera, extra_storage, os) As Row_Num
    From mobiles_staging
    )    
    Select *  
    From Duplicate_cte
    where Row_Num > 1;
     
     
CREATE TABLE `mobiles_staging2` (
  `mobile_name` text,
  `price` text,
  `rating` double DEFAULT NULL,
  `specs_score` int DEFAULT NULL,
  `connectivity` text,
  `processor` text,
  `storage` text,
  `battery` text,
  `display` text,
  `camera` text,
  `extra_storage` text,
  `os` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
Select *
From mobiles_staging2;

	Insert Into mobiles_staging2
     Select *,
     Row_Number() Over(
     Partition by mobile_name, price, rating, specs_score, connectivity, processor, 
     'storage', battery, display, camera, extra_storage, os) As Row_Num
    From mobiles_staging;

Select *
From mobiles_staging2
where row_num > 1; 

Delete
From mobiles_staging2
where row_num > 1; 


-- Standardizing Data

Select mobile_name, trim(mobile_name)
From mobiles_staging2;

Update mobiles_staging2
Set mobile_name = trim(mobile_name);

Select trim(connectivity)
From mobiles_staging2;

Update mobiles_staging2
Set connectivity = trim(connectivity);

Select Distinct battery
From mobiles_staging2
order by 1;

Select battery, replace (battery, 'â€‰', ' ' )
From mobiles_staging2;

Update mobiles_staging2
Set battery = replace (battery, 'â€‰', ' ' );

Select processor
From mobiles_staging2;

Select processor, replace (processor, 'â€‰', '' )
From mobiles_staging2;

Update mobiles_staging2
Set processor = replace (processor, 'â€‰', '' );

Select *
From mobiles_staging2;

Select camera
From mobiles_staging2;

Select camera, replace (camera, 'â€‰', '' )
From mobiles_staging2;

Update mobiles_staging2
Set camera = replace (camera, 'â€‰', '' );

Select *
From mobiles_staging2;

Select display
From mobiles_staging2;

Select display, replace (display, 'â€‰', '' )
From mobiles_staging2;

Update mobiles_staging2
Set display = replace (display, 'â€‰', '' );

Select *
From mobiles_staging2;

Select storage
From mobiles_staging2;

Select storage, replace (storage, 'â€‰', '' )
From mobiles_staging2;

Update mobiles_staging2
Set storage = replace (storage, 'â€‰', '' );

Select *
From mobiles_staging2;

Select price
From mobiles_staging2;

Select price, replace (price, 'â‚¹', '' )
From mobiles_staging2;

Update mobiles_staging2
Set price = replace (price, 'â‚¹', '' );

Select *
From mobiles_staging2;

-- Null and blank values

Select *
From mobiles_staging2
where mobile_name is null
and specs_score = '';

select *
From mobiles_staging3;

Update mobiles_staging3
Set extra_storage = os,
camera  = '12MP + 12MP Dual Rear & 12MP Front Camera',
display = '6.1 inches, 1170 x 2532 px Display with Large Notch'
where os = 'No FM Radio';

Update mobiles_staging3
Set os  = 'iOS v14',
extra_storage = 'memory card not supported'
where os = 'No FM Radio';

-- Remove Empty Columns

Alter Table mobiles_staging2
Drop Column row_num;

Alter table mobiles_staging3
Drop column price;

Select *
From mobiles_staging3;