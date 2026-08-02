-- Step 1: Check number of casual_riders and members

SELECT
      member_casual,
      COUNT(*) AS counted,
      ROUND(COUNT(*) *100.0 / SUM(COUNT(*))OVER (), 2) AS percent
FROM
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY
      member_casual

-- Step 2: Check who drives how much on which day

SELECT 
      FORMAT_DATE('%A', start_date) AS day_of_week,
      member_casual,
      COUNT(*) AS total_rides,
      ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY 
      day_of_week, member_casual, EXTRACT(DAYOFWEEK FROM start_date)
ORDER BY 
      EXTRACT(DAYOFWEEK FROM start_date), member_casual

-- Step 3: Check who drives how much at which time of the day

SELECT 
      EXTRACT(HOUR FROM start_time) AS hour_of_day,
      member_casual,
      COUNT(*) AS total_rides
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY 
      hour_of_day, member_casual
ORDER BY 
      hour_of_day, member_casual

-- Step 4: Check who drives how much in which month

SELECT 
      FORMAT_DATE('%B %Y', start_date) AS month,
      member_casual,
      COUNT(*) AS total_rides,
      ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY 
      month, member_casual, FORMAT_DATE('%Y-%m', start_date)
ORDER BY 
      FORMAT_DATE('%Y-%m', start_date), member_casual

-- Step 5: Check which user type uses which bike type

SELECT 
      rideable_type,
      member_casual,
      COUNT(*) AS total_rides,
      ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS
      percent_within_group
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
GROUP BY 
      rideable_type,
      member_casual
ORDER BY
      member_casual,
      rideable_type DESC

-- Step 6: Get a sample for analysis of usage lengths

SELECT
      member_casual, 
      ride_length_minutes
FROM 
      `<your_project_name>.cyclist_trip_data.last_12_months_clean`
WHERE 
      RAND() < 0.02 
