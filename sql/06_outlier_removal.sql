-- Step 1: Creating new column ride_length_minutes

REPLACE TABLE `<your_project_name>.cyclist_trip_data.last_12_months_clean`AS
SELECT 
      *,
      TIMESTAMP_DIFF(
      TIMESTAMP(end_date || ' ' || end_time), 
      TIMESTAMP(start_date || ' ' || start_time), 
      MINUTE
      ) AS ride_length_minutes
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`

-- Step 2: Checking the ride lengths minutes 

SELECT 
      MIN(ride_length_minutes) AS min_ride_length_minutes,
      MAX(ride_length_minutes) AS max_ride_length_minutes,
      AVG(ride_length_minutes) AS avg_ride_length_minutes,
      COUNTIF(ride_length_minutes < 0) AS negeative_ride_length,
      COUNTIF(ride_length_minutes >= 1440) AS more_than_a_day_ride_length
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean` 

-- Step 3: Keeping data with ride_length_minutes >=0 and < 1440

REPLACE TABLE `<your_project_name>..cyclist_trip_data.last_12_months_clean` AS

SELECT
      *
FROM
      `<your_project_name>.cyclist_trip_data.last_12_months_clean` 
WHERE
      ride_length_minutes >= 0 AND
      ride_length_minutes < 1440
