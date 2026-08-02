# Case_Study
This case study is part of the Google Data Analyst Professional Course. The Data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement). The case study is structured into the Ask, Prepare, Process, Analyze, Share and Act Phases.

The primary goal is to answer the question how annual members and casual riders use Cyclistic bikes differently.

## Table of Contents
- [Ask Phase](#ask-phase)
- [Prepare Phase](#prepare-phase)
- [Process Phase](#process-phase)
- [Analyze and Share Phase](#analyze-and-share-phase)

## Ask Phase

### Business Task
- How do annual members and casual riders use Cyclistic bikes differently? 
- This analysis aims to uncover behavioral patterns that can inform a 
- marketing strategy focused on converting casual riders into annual members.

### Background
Cyclistic's finance team has determined that annual members are significantly more profitable than casual riders. Based on this insight, Director of Marketing has decided to focus future marketing efforts on converting existing casual riders into members, rather than acquiring entirely new customers — since riders who already use the service are considered a more efficient and cost-effective target group.

This analysis will directly inform the design of a marketing campaign aimed at casual riders.

### Key Stakeholders

| Director of Marketing | sets strategic direction |
| Marketing Manager | Oversees campaign execution and marketing decisions |
| Marketing Analytics Team | Collaborates on and reviews this analysis |
| Executive Team | Approves or rejects the final marketing recommendation |

### Guiding Question
> How do annual members and casual riders use Cyclistic bikes differently, 
> and what does that reveal about how to convert casual riders into members?

## Prepare Phase

### Data Source
This analysis uses Cyclistic's historical trip data, provided by Lyft Bikes and Scooters, LLC (operator of Divvy), with data owned by the City of Chicago. The dataset is made publicly available under Divvy's [Data License Agreement](https://divvybikes.com/data-license-agreement). All personally identifiable information has been removed by Divvy prior to publication, in line with their data privacy practices.

### Scope
The analysis covers the most recent 12 months of ride data available (July 2025 – June 2026), ensuring the findings reflect current rider behavior.

### Data Structure
Each row represents a single bike ride and includes:
- `ride_id` – unique identifier for each trip
- `rideable_type` – type of bike used (classic or electric)
- `started_at` / `ended_at` – trip start and end timestamps
- `start_station_name` / `id`, `end_station_name` / `id` – station details
- `start_lat` / `lng`, `end_lat` / `lng` – geographic coordinates
- `member_casual` – rider type (member or casual)

### Initial Data Quality Observations
- No missing values were found in `started_at` or `ended_at`.
- Approximately [exact %]% of station name/ID fields and coordinate 
  fields contained missing values — likely because trips did not begin 
  or end at a fixed docking station but within a broader zone not tied 
  to a specific station name.
- These and other data quality issues (duplicates, invalid entries, 
  outliers) were addressed in detail during the Data Cleaning phase.

### Data Credibility (ROCCC)
- **Reliable:** Collected systematically through Divvy's official system
- **Original:** First-party data provided directly by the operator
- **Comprehensive:** Includes trip-level detail across time, location, 
  user type, and vehicle type
- **Current:** Covers the most recent available 12-month period
- **Cited:** Publicly licensed and clearly sourced from Divvy/City of Chicago

## Process Phase

### All data cleaning and transformation was performed in **BigQuery (SQL)**. 
The 12 monthly trip tables (July 2025 – June 2026, ~5.93M rows) were 
merged, validated, and cleaned before analysis. Full queries for each 
step are linked below.

### **1. Merging monthly tables** 
- All monthly trip tables (July 2025 – June 2026) were loaded into BigQuery and merged into a single table (~5.93M rows).
- See [01.merge_tables.sql](sql/01_merge_tables.sql)

### **2. Null and duplicate checks**
- Checked all columns for NULL values (none found except expected station-related NULLs for dockless bikes). Identified 35 exact duplicate rows and removed them via `SELECT DISTINCT`, while retaining 8 rows with an invalid `ride_id` of `0`, as they represented distinct valid trips.
- See [02.null_and_duplicate_checks.sql](sql/02_null_and_duplicate_checks.sql)

### **3. Data type consistency checks** 
- Verified that timestamp and ride_id character lengths were consistent; minor formatting differences (missing milliseconds, incomplete ride_ids) were found but did not affect data validity.
- See [03_data_type_checks.sql](sql/03_data_type_checks.sql)

### **4. Restructuring columns** 
- Split `started_at`/`ended_at` into separate date/time columns and reordered the table for readability.
- See [04_restructure_columns.sql](sql/04_restructure_columns.sql)

### **5. Category validation**
- Confirmed only two valid values exist for `rideable_type` and `member_casual`.
- See [05_category_validation.sql](sql/05_category_validation.sql)

### **6. Outlier removal** 
- Calculated ride duration in minutes and excluded 29 rides with negative duration and 5,532 rides exceeding 24 hours (likely lost/stolen bikes), removing 5,561 rows total.
- See [06_outlier_removal.sql](sql/06_outlier_removal.sql)

### **7. Date range and station name checks** 
- Verified the full date range was within scope and identified minor station name inconsistencies (irrelevant to the core analysis, as it groups by `station_id`).
- See [07_date_range_station_checks.sql](sql/07_date_range_station_checks.sql)

## Analyze and Share Phase

All statistical analysis and visualization were performed in **Python** using aggregated results exported from BigQuery [08_aggregations_for_analysis](sql/08_aggregations_for_analysis.sql). Full code and visualizations are available in the analysis notebook. [Cycling.ipynb](notebook/Cycling.ipynb)

### 1. Member vs. Casual Rider Distribution

Members account for the majority of total rides (64.36%), compared to 
35.64% for casual riders.

<img width="500" alt="casual_member" src="https://github.com/user-attachments/assets/2ad58948-1e45-4f01-8282-8a194293b3f9" />

### 2. Rides by Weekday

A clear difference between the two groups:

- **Members** ride consistently more on weekdays (Tuesday–Thursday peak around 600–618K rides), with a noticeable drop on weekends.
- **Casual riders** ride less during the week and peak sharply on Saturday (445K rides), suggesting leisure or recreational usage.


<img width="500" alt="rides_by_weekday" src="https://github.com/user-attachments/assets/c1069d62-054c-4341-93a2-015cb080093f" />

A Chi-Square test of independence confirmed a statistically significant association between `member_casual` and `day_of_week` (χ² = 156,443.80, p < 0.001, df = 6), with a **moderate** effect size (Cramér's V = 0.163) — the strongest association found among all categorical variables tested, supporting a clear commuter (member) vs. leisure (casual) usage pattern.

### 3. Rides by Hour of Day

Members show a **bimodal pattern** with peaks around 8 AM and a sharper peak at 5–6 PM, consistent with commute times. Casual riders show a **broader, single peak** in the afternoon (peaking around 5 PM), consistent with leisure activity.

<img width="500" alt="rides_by_time_of_day" src="https://github.com/user-attachments/assets/83c2c4c6-a773-4e55-8be6-e31c3791177f" />

This association is also statistically significant and moderate in strength (Cramér's V = 0.159, p < 0.001), reinforcing the commuter vs. leisure hypothesis from a second angle.

### 4. Rides by Month

Ride volume is highest in summer months (July–September 2025) and lowest in winter (December–February), consistent with typical seasonal cycling behavior. Casual ridership drops more sharply in winter relative to members, who maintain more stable usage the whole year.

<img width="500" alt="rides_by_month" src="https://github.com/user-attachments/assets/2b8b050e-5a73-4cda-ac2f-3beee9a94762" />

The association between month and user type is significant with a moderate effect size (Cramér's V = 0.144, p < 0.001).

### 5. Bike Type Preference

Both rider groups predominantly choose electric bikes over classic bikes, with casual riders showing a slightly stronger preference (70.15%) compared to members (66.34%).

<img width="500" alt="user_type_bike_type" src="https://github.com/user-attachments/assets/2f3a7ecc-497a-4bb8-b11a-b74c4a94105e" />

While this difference is statistically significant (χ² = 9,023.46, p < 0.001), the effect size is very small (Cramér's V = 0.039), indicating that bike type preference is **not** a meaningful differentiator between member and casual riders — both groups behave similarly in this respect.

### 6. Ride Duration by User Type

Casual riders take substantially longer trips on average (mean: 17.9 
minutes, median: 11.0 minutes) compared to members (mean: 11.5 minutes, 
median: 8.0 minutes).

<img width="500" alt="duration_type" src="https://github.com/user-attachments/assets/1403f919-f2d7-48ef-9253-c90fe2e46c3d" />

A Welch's t-test confirmed this difference is highly statistically significant (t = 34.66, p < 0.001). Combined with the weekday and time-of-day patterns, this supports the interpretation that casual riders use bikes for longer, more leisurely trips, while members take shorter, more purposeful (likely commute-related) trips.

### Key Findings Summary

| Weekday usage pattern (commuter vs. leisure) | Significant | Moderate (V = 0.163) |
| Time-of-day usage pattern | Significant | Moderate (V = 0.159) |
| Monthly/seasonal usage pattern | Significant | Moderate (V = 0.144) |
| Bike type preference (electric vs. classic) | Significant | Very small (V = 0.039) |
| Ride duration (casual vs. member) | Significant | Large practical difference (~6 min avg.) |

### Interpretation
The most actionable insights come from **weekday, time-of-day, and ride-duration patterns**, which consistently point to the same conclusion: members exhibit commuter-like behavior — shorter trips concentrated on weekdays, with a distinct bimodal peak around typical commute hours (approx. 7–9 AM and 5–6 PM) — consistent with riding to and from work. Casual riders, by contrast, exhibit leisure-like behavior: longer trips concentrated on weekend afternoons, with usage peaking in the early evening rather than around fixed commute times. Bike type preference, while statistically significant due to the large sample size, shows a very small effect and is **not** a meaningful behavioral differentiator between the two groups.
