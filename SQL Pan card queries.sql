create database pancard;
use pancard;
create table ind_pan_number_dataset
(
 pan_numbers text
 );
 select * from ind_pan_number_dataset;
 SHOW VARIABLES LIKE 'local_infile';
 SET GLOBAL local_infile = 1;
 USE pancard;
 #loading data in database...
LOAD DATA LOCAL INFILE 
'C:/Users/dell/Desktop/PAN Card Validation in SQL - Scripts/data.csv'
INTO TABLE pan_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
#----------------------------------------------------DATA CLEANING----------------------------------------------------------------------

#1)check and correct for duplicate record
select distinct pan_numbers from ind_pan_number_dataset where pan_numbers is not null;

#2)How to handle spaces?
select * from ind_pan_number_dataset where pan_numbers <> trim(pan_numbers);

#3)DO case correction in letters
select distinct upper(trim(pan_numbers)) as pan_number 
from ind_pan_number_dataset where pan_numbers is not null and trim(pan_numbers) <> '';

#4)General expression to validate pattern/structure of patterns of pan numbers

SELECT *
FROM ind_pan_number_dataset
WHERE pan_numbers REGEXP '^[A-Z]{5}[0-9]{4}[A-Z]$';

#5)How can we perform data cleaning and normalization on PAN numbers using SQL CTE?

with cte_cleaned_pan as
(select distinct upper (trim(pan_numbers)) as pan_number
from  ind_pan_number_dataset
where pan_numbers is not null
and trim(pan_numbers)<>'')
select * from cte_cleaned_pan;

#5)How can we extract only valid PAN numbers from the dataset?

SELECT *FROM ind_pan_number_dataset
WHERE pan_numbers REGEXP '^[A-Z]{5}[0-9]{4}[A-Z]$';

#6)How can we find PAN numbers that are not exactly 10 characters long?
SELECT * FROM ind_pan_number_dataset
WHERE CHAR_LENGTH(TRIM(pan_numbers)) <> 10;

#7)How can we check PAN numbers containing special characters?
SELECT * from ind_pan_number_dataset
WHERE pan_numbers regexp '[^A-Z0-9]';


