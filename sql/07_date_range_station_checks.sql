-- Step 1: Check when the first ride started and the last ride ended

SELECT
      MIN(start_date) AS min_start_date,
      MAX(start_date) AS max_start_date,
      MIN(end_date) AS min_end_date,
      MAX(end_date) AS max_end_date

FROM
     `<your_project_name>.cyclist_trip_data.last_12_months_clean`

-- Step 2: Check if rides from 2025-06-30 reach into 2025-07-01

SELECT
      *
FROM
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
WHERE 
      start_date = '2025-06-30'

-- Step 3: Look for station_ids havin more than one station_name

SELECT 
      start_station_id, 
      COUNT(DISTINCT start_station_name) AS name_variants
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY 
      start_station_id
HAVING 
      name_variants > 1

-- Step 4: Check the name variants if they are reasonable

SELECT DISTINCT 
      start_station_id, 
      start_station_name
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
WHERE 
      start_station_id = 'CHI01665'
