-- Step 1: Check if there are only two different types of bikes

SELECT 
      rideable_type,
      COUNT(*) AS total
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean` 
GROUP BY 
      rideable_type


-- Step 2: Check if there are only two types of bike users

SELECT
      member_casual,
      COUNT(*) AS total
FROM
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY
      member_casual
