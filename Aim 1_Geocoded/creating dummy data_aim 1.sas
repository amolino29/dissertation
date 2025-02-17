/* 02/14/2025
- This script is to create the "dummy" dataset for Andrea Molino's dissertation Aim 1, also known as the "geocoded effect modifier" 
  analysis/aim. 
- A "dummy" dataset is needed because I am wanting to account for clustering at the census tract level, which I would not be able to do 
  while still obtaining "real" data due to data suppression <5 cells restrictions around STEP data. 
- Thus, I will be simulating dummy data based on my variables of interest and the values John Lin provided in the codebook, and then will 
  be sending the dummy data to Hongyuan at KPWHRI to run the actual analysis on real STEP data. 
- The data produced by Hongyuan will be the "real" data, which I will then turn into my dissertation Aim 1 results.
*/ 


*** Read in empty dataset from John; 
libname mylib 'C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\data';
data work.step_andrea_blank;
   set mylib.step_andrea_blank;
run;

*** Only keep necessary variables; 
data work.step_andrea_blank;
	set work.step_andrea_blank;
	keep history screenarm group group_analytic rand_date completion agegroup race ethnicity total_traveltime bmi enrollbfrand_m;
RUN;

proc contents data=work.step_andrea_blank; run; 


*** VARIABLES THAT NEED TO BE SIMULATED: 
* history - 1,2,3
* screenarm
* group
* group_analytic
* rand_date
* completion
* agegroup
* race
* ethnicity
* total_traveltime
* bmi
* enrollbfrand_m;
