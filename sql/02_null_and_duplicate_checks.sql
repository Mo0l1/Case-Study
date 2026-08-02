-- Step 1: Checking for Null values
SELECT 
      COUNT(*) AS total_rows,
      COUNTIF(ride_id IS NULL) AS null_ride_id,
      COUNTIF(rideable_type IS NULL) AS null_rideable_type,
      COUNTIF(started_at IS NULL) AS null_started_at,
      COUNTIF(ended_at IS NULL) AS null_ended_at,
      COUNTIF(start_station_name IS NULL) AS null_start_station_name,
      COUNTIF(start_station_id IS NULL) AS null_start_station_id,
      COUNTIF(end_station_name IS NULL) AS null_end_station_name,
      COUNTIF(end_station_id IS NULL) AS null_end_station_id,
      COUNTIF(start_lat is NULL) AS null_start_lat,
      COUNTIF(start_lng is NULL) AS null_start_lng, 
      COUNTIF(end_lat is NULL) AS null_end_lat,
      COUNTIF(end_lng is NULL) AS null_end_lng, 
      COUNTIF(member_casual IS NULL) AS null_member_casual
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months` 

-- Step 2: Count distinct ride_ids

SELECT 
      COUNT(DISTINCT ride_id) AS disitinct_ride_id
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`

-- Step 3: find duplicate rows

SELECT 
      *
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`
WHERE 
      ride_id IN (
      SELECT 
            ride_id
      FROM 
            `<your_project_name>.cyclist_trip_data.last_12_months`
      GROUP BY 
            ride_id
      HAVING 
      COUNT(*) > 1
      )
ORDER BY 
ride_id

-- Step 4: Remove exact duplicates, create cleaned table

CREATE OR REPLACE TABLE `<your_project_name>.cyclist_trip_data.last_12_months_clean` AS
SELECT DISTINCT 
      *
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`
