CREATE TABLE `<your_project_name>.cyclist_trip_data.last_12_months` AS 
SELECT * FROM `<your_project_name>.cyclist_trip_data.202507_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202507_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202508_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202508_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202509_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202509_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202510_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202510_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202511_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202511_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202512`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202601`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202602`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202603`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202604`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202605_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202605_part_2`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202606_part_1`
UNION ALL
SELECT * FROM `<your_project_name>.cyclist_trip_data.202606_part_2`
