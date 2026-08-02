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

![Member vs Casual](<img width="1050" height="600" alt="casual_member" src="https://github.com/user-attachments/assets/2ad58948-1e45-4f01-8282-8a194293b3f9" />)

