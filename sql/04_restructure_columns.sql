-- Step 1: Split up date and time

REPLACE TABLE `<your_project_name>.cyclist_trip_data.last_12_months_clean` AS
SELECT 
      *,
      DATE(started_at) AS start_date,
      TIME(started_at) AS start_time,
      DATE(ended_at) AS end_date,
      TIME(ended_at) AS end_time
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`

-- Step 2: Delete old columns (started_at, ended_at)

ALTER TABLE <your_project_name>.cyclist_trip_data.last_12_months_clean
DROP COLUMN started_at,
DROP COLUMN ended_at

-- Step 3: Reorganize columns of the new table

REPLACE TABLE <your_project_name>.cyclist_trip_data.last_12_months_clean AS

SELECT
      ride_id,
      rideable_type,
      start_date,
      start_time,
      end_date,
      end_time,
      start_station_name,
      start_station_id,
      end_station_name,
      end_station_id,
      start_lat,
      start_lng,
      end_lat,
      end_lng,
      member_casual
FROM
      <your_project_name>.cyclist_trip_data.last_12_months_clean
