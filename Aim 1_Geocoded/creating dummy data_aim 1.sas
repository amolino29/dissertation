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

*** Retain fully blank dataset but create "step_andrea_data" that will store the simulated data; 
data work.step_andrea_data; set work.step_andrea_blank; run; 


*** Create simulated data for dummy analysis; 
data work.step_andrea_data;
    if 0 then set work.step_andrea_data;            /* Load variable structure but no data since there are no observations */
    call streaminit(6874);							/* Set random seed */
    do _n_ = 1 to 31000;						    /* Generate 31,000 observations */
        array p[3] (0.4 0.3 0.3);				    /* Array of probabilities for each level */
        history = rand("Table", of p[*]);	 		/* Generate random value for the history column */
        output;
    end;
run;

/* Create format for the history variable */
proc format;
    value history_fmt
        1 = 'Adherent'
        2 = 'Overdue'
        3 = 'Unknown';
run;

/* Check the distribution */
proc freq data=work.step_andrea_data;
    format history history_fmt.;
    tables history / nocum;
run;

proc contents data=work.step_andrea_data; run;




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


data Table(keep=x); 
call streaminit(4321); 
p1=0.5; p2=0.2; p3=0.3; 
do i = 1 to 100; 
	x=rand("Table", p1, p2, p3);
	output; 
end; 
run; 

proc freq data=Table; 
	tables x / nocum; 
run; 




