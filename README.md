# Case_Study
This case study is part of the Google Data Analyst Professional Course. The Data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement). The case study is structured into the Ask, Prepare, Process, Analyze, Share and Act Phases.

The primary goal is to answer the question how annual members and casual riders use Cyclistic bikes differently.

## Table of Contents
- [Ask Phase](#ask-phase)
- [Prepare Phase](#prepare-phase)
- [Process Phase](#process-phase)

## Ask Phase:
The finance analyst team has stated that annual members are much more profitable than casual riders. Moreno wants to set the focus on conversion from casual riders to members rather than non users to casual riders. Focus is set on a marketing campaign addressing casual riders.
The question to answer is how annual members and casual riders use Cyclistic bikes differently. Therefore I need to analyze the last 12 months of the bike sharing usage to identify trends. Key stakeholders are Moreno as the director of marketing and my manager who is responsible for marketing. The marketing analytics team as my team which needs to be constantly updated and worked together with and the executive team as they are making the final decision on wether or not going with the recommended marketing program.

## Prepare Phase:
All the data is provided by this data data analytics program and available to download via the Case Study 1 document. Data provided by Lyft Bikes and Scooters, LLC (operator of Divvy), data owned by the City of Chicago, under this [license](https://divvybikes.com/data-license-agreement). Data was gathered but personal data was deleted. The data used for this project covers the last 12 months so that it is current. Looking through the tables I noticed that there is a large number of missing start and end station data as well as the lat lng start and end data. I would assume it is because people did not start with or park the bikes from or at a station directly but in a range where it didn’t recognize the station. I have the ride_id where you could also count how many people use the Service how often and if they are members or not. I have the rideable_type. I have the started_at and ended_at data to determine the time span. I checked that there are no NULL values in this category which is positive. I have start and end station names and ids as well as their lat and lng.  checked and especially in the station names and ids categorie around 20% is NULL values. I will check if this will be a disadvantage during the cleaning phase
I have the documentation how many users are casual riders and members. Any problems with the data will be sorted through during the cleaning process. I downloaded the data from 2025.07 to 2026.06.

## Process Phase

### Data Cleaning in BigQuery (SQL)

**All monthly trip tables (July 2025 – June 2026) were merged into a single 
table containing ~5.93M rows. See [01.merge_tables.sql](sql/01.merge_tables.sql)

**Checking for NULL-values. See [02.null_and_duplicate_checks.sql](sql/02.null_and_duplicate_checks.sql)
