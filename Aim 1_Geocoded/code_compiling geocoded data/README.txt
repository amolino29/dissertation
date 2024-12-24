This is a README for Andrea's "code_geocoded data compiling" GitHub folder. 

The purposes of this folder is to create the dataset that includes all geocoded variables of interest for my Aim 1 (geocoded effect modifiers aim). The Rmarkdown file is very comprehensive and includes information needed to understand how this dataset was created. 

Of note, the actual raw data being used to create these datasets are NOT in this GitHub folder, as some of them are too large to be stored in Git without special considerations. 

The final geocoded dataset pulls information from 3 data sources on 8 census tract-level variables of interest. They are: 

- State-based Social Vulnerability Index (SVI) from CDC ATSDR
- Neighborhood affluence from the University of Michigan National Neighborhood Data Archive (NaNDA)
- Housing cost burden from the 2020 5-year American Community Survey (ACS) 
- Renter-occupied household status from the 2020 5-year ACS
- Poverty status from the 2020 5-year ACS
- Median income from the 2020 5-year ACS
- Unemployment status from the 2020 5-year ACS
- Vehicle access from the 2020 5-year ACS

The Rmarkdown file pulls all of the necessary datasets, does formatting and manipulation, and then merges all variables by GEOID, which is the census tract identifier, for all tracts in Washington State. This code also determines what quartile the census tract is in based on its Washington State distribution, and does the same thing for King County. These quartiles are what I will be ultimately using in my Aim 1 analysis as levels of my effect modifier. 

The final datasets produced, where all 8 effect modifiers have their values attached to a single WA State 2020 Census Tract, are in the "final geocoded data" folder. The quartiles data was also turned into a SAS dataset for Hongyuan. 