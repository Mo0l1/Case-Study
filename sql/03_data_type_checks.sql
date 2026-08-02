-- Step 1: Check for different character counts in started_at or ended_at

SELECT 
      LENGTH(CAST(ended_at AS STRING)) AS character_count,
      COUNT(*) AS total
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`
GROUP BY 
      character_count;

-- Step 2: Check why character counts differ

SELECT 
      *
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`
WHERE 
      LENGTH(CAST(ended_at AS STRING)) = 22

-- Step 3: Check for different character counts in ride_id

SELECT 
      LENGTH(ride_id) AS character_count,
      COUNT(*) AS total
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months`
GROUP BY 
      character_count
