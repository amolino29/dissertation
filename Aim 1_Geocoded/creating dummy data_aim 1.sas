/* 02/14/2025
- This script is to create the "dummy" dataset for Andrea Molino's dissertation Aim 1, also known as the "geocoded effect modifier" 
  analysis/aim. 
- A "dummy" dataset is needed because I am wanting to account for clustering at the census tract level, which I would not be able to do 
  while still obtaining "real" data due to data suppression <5 cells restrictions around STEP data. 
- Thus, I will be simulating dummy data based on my variables of interest and the values John Lin provided in the codebook, and then will 
  be sending the dummy data to Hongyuan at KPWHRI to run the actual analysis on real STEP data. 
- Once all of the variables of interest were simulated, their levels and ranges were checked to make sure they represent the real 
  data (generally, distributions did not need to be perfect). Variable logic was also cross checked with other variables as needed. For 
  example, those in the overdue history=2 group were not randomized to receive the opt-in intervention, and that has been coded accordingly. Or 
  those in the unknown history=3 group all had been enrolled at Kaiser for <39 months (<3.25 years). 
- The data produced by Hongyuan will be the "real" data, which I will then turn into my dissertation Aim 1 results.
- This data should NOT DO ANY DATA CLEANING OR RECODING/COLLAPSING. It should solely produce a dataset that would look EXACTLY like what
  Hongyuan's will look like when she opens up SAS with the STEP data. For example, I created "enrollbfrand_m", and while I will actually 
  be using a categorized version of this variable, I will not be doing that procedure in this code. This is the same situation as 
  formatting, that will be done in the "analytic" file. 
*/ 


*** Read in empty dataset from John; 
libname mylib 'C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\data';
data work.step_andrea_blank;
   set mylib.step_andrea_blank;
run;

*** Only keep necessary variables; 
data work.step_andrea_blank;
	set work.step_andrea_blank;
	keep history screenarm group_analytic rand_date agegroup race ethnicity total_traveltime_c bmigroup enrollbfrand_m;
RUN;

proc contents data=work.step_andrea_blank; run; 

*** Retain fully blank dataset but create "step_andrea_data" that will store the simulated data; 
data work.step_andrea_data; set work.step_andrea_blank; run; 


*** Create simulated STEP data for dummy analysis; 
data work.step_andrea_data;
    if 0 then set work.step_andrea_data;            								 /* Load variable structure but no data since there are no observations */
    call streaminit(6874);															 /* Set random seed */
    do _n_ = 1 to 31000;						        							 /* Generate 31,000 observations */

		*** screenarm: randomization assignment with history incorporated;
		array p_screenarm[10] (0.12 0.13 0.13 0.05 0.17 0.04 0.05 0.09 0.11 0.11);   /* Array of probabilities for each level */
		array l_screenarm[10] (1    2    3    4    11   12   14   21   22   23);     /* Array of levels that we want for the variable */ 
		screenarm = l_screenarm[rand("Table", of p_screenarm[*])];    				 /* Generate random value for the history column */

		*** history: prior CC screening history type, created based off of screenarm above;
		if screenarm in (1,2,3,4)  then history=1; 
		if screenarm in (11,12,14) then history=2; 
		if screenarm in (21,22,23) then history=3; 

		*** group_analytic: sequence of home HPV kit return and Pap/HPV, collapsed to kit, pap, none;
		* There needs to be a different distribution for each screenarm, as only some of these arms were able to use the kit, and the distributions also vary by screening history;
		array l_group_analytic_49[2]   (4 9);
		array l_group_analytic_1469[4] (1 4 6 9);

		* ADHERENT;
		array p_group_analytic_49_auc[2] (0.47 0.53); 
		array p_group_analytic_49_aedu[2] (0.48 0.52); 
		array p_group_analytic_1469_aopt[4] (0.10 0.402 0.008 0.49); 
		array p_group_analytic_1469_adm[4] (0.37 0.22 0.03 0.38); 

	    if screenarm = 1 then do; 
	      	group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_auc[*])]; 
		end;

	    if screenarm = 2 then do; 
	      	group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_aedu[*])]; 
		end;

	    if screenarm = 3 then do; 
			group_analytic = l_group_analytic_1469[rand("Table", of p_group_analytic_1469_aopt[*])]; 
		end;

	    if screenarm = 4 then do; 
			group_analytic = l_group_analytic_1469[rand("Table", of p_group_analytic_1469_adm[*])]; 
		end;

		* OVERDUE; 
		array p_group_analytic_49_ouc[2] (0.19 0.81);
      	array p_group_analytic_49_oedu[2] (0.19 0.81); 
      	array p_group_analytic_1469_odm[4] (0.21 0.135 0.01 0.645); 

		if screenarm = 11 then do;  
      		group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_ouc[*])]; 
        end;

    	if screenarm = 12 then do
      		group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_oedu[*])]; 
        end;

    	if screenarm = 14 then do; 
      		group_analytic = l_group_analytic_1469[rand("Table", of p_group_analytic_1469_odm[*])]; 
        end;

		* UNKNOWN;
	    array p_group_analytic_49_uuc[2] (0.18 0.82);
	    array p_group_analytic_49_uedu[2] (0.16 0.84); 
	    array p_group_analytic_1469_uopt[4] (0.03 0.15 0.002 0.818); 

   		if screenarm = 21 then do;  
			group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_uuc[*])]; 
        end;

		if screenarm = 22 then do
			group_analytic = l_group_analytic_49[rand("Table", of p_group_analytic_49_uedu[*])]; 
        end;

		if screenarm = 23 then do; 
			group_analytic = l_group_analytic_1469[rand("Table", of p_group_analytic_1469_uopt[*])]; 
        end;

		*** rand_date: randomization date;
		* Floor round so each integer represents 1 calendar day; 
		do until (22239 <= rand_date <= 22673); 
			rand_date = rand('NORMAL', 22450, 127);
		end; 
		rand_date = floor(rand_date); 

		*** agegroup: Age group at randomization date;
		array p_agegroup[7] (0.16 0.15 0.14 0.14 0.14 0.14 0.13); 
		array l_agegroup[7] (1    2    3    4    5    6    7); 
		agegroup = l_agegroup[rand("Table", of p_agegroup[*])]; 

		*** race;
		array p_race[8] (0.58 0.11 0.04 0.01 0.01 0.03 0.03 0.19); 
		array l_race[8] (1    2    3    4    5    6    7    9); 
		race = l_race[rand("Table", of p_race[*])]; 

		*** ethnicity;  
		array p_ethnicity[3] (0.64 0.06 0.30); 
		array l_ethnicity[3] (0    1    9); 
		ethnicity = l_ethnicity[rand("Table", of p_ethnicity[*])]; 

		*** total_traveltime_c: Travel time from women's home to primary care clinic;
		array p_total_traveltime_c[5] (0.33 0.3498 0.16 0.1598 0.0004); 
		array l_total_traveltime_c[5] (2    4      6    7    9); 
		total_traveltime_c = l_total_traveltime_c[rand("Table", of p_total_traveltime_c[*])]; 		

		*** bmigroup: BMI;
		array l_bmigroup[7] (1 2 3 4 5 6 9);

		if history = 1 then do; 
			array p_bmigroup1[7] (0.01 0.32 0.28 0.18 0.11 0.10 0); 
			bmigroup = l_bmigroup[rand("Table", of p_bmigroup1[*])]; 
        end;

		if history = 2 then do; 
			array p_bmigroup2[7] (0.008 0.17 0.17 0.14 0.09 0.092 0.33); 
			bmigroup = l_bmigroup[rand("Table", of p_bmigroup2[*])]; 
        end;

		if history = 3 then do; 
			array p_bmigroup3[7] (0.005 0.12 0.11 0.085 0.05 0.06 0.57); 
			bmigroup = l_bmigroup[rand("Table", of p_bmigroup3[*])]; 
        end;	

		*** enrollbfrand_m: Number of months enrolled BEFORE randomization; 
		* Those with unknown history only had <3.25 years of enrollment, but full range allowed for due and overdue;
		* Then floor round so each integer represents 1 month;
		if history in (1,2) then do; 
			do until (0 <= enrollbfrand_m <= 408);
            	enrollbfrand_m = rand('NORMAL', 69.4, 85.6);
			end; 
		end; 

		if history in (3) then do; 
			do until (0 <= enrollbfrand_m < 39);
            	enrollbfrand_m = rand('NORMAL', 20, 10);
			end; 
        end;
		enrollbfrand_m = floor(enrollbfrand_m); 

        output;
    end;
run;

/* Drop all l_ and p_ array variables from dataset */ 
data work.step_andrea_data;
	set work.step_andrea_data (drop=p_: l_:);
run; 

/* Compare formats and such between the simulated dataset and the blank dataset */ 
proc contents data=work.step_andrea_data; run;
proc contents data=work.step_andrea_blank; run;

/* Create FIPS variable by pulling in GEOID census tracts from an existing SAS dataset that I created (1784 in total) */ 
libname mylib 'C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\code_compiling geocoded data\final geocoded data';
data work.fips_data;
	set mylib.step_geocoded_data;
	keep GEOID_char king_county;
run; 

proc contents data=work.fips_data; run;

* Dataset with FIPS code in 11. string format has now been created;  
* The next step is to create a dummy variable for GEOID for the 31,000 fake participants we have. I will do this by creating a 
* dataset with 31,000 GEOID_char observations with real GEOIDs so I can merge on variables in the analytic dataset;
* The approach below does the following - it first creates a dataset called "unique_geoids" that only has our 1784 FIPS codes of
* interest in the variable "GEOID_char". I then create a value "num_geoids" that is 1784, which we use to divide by 31,000 which 
* is our number of observations to create the number of "reps" that are needed. We then use this "reps" value to create our 
* "simulated_fips" dataset. However, the original dataset has 32,112 observations (which is 1784 * 18, which makes sense, so all 
* FIPS codes are guaranteed to be represented). However, we need our dataset to be exactly 31,000 observations to be able to merge 
* with step_andrea_data, which is what I do in the final dataset;
proc sort data=work.fips_data out=work.unique_geoids NODUPKEY;
	by GEOID_char;
run; 

data work.unique_geoids; set work.unique_geoids; keep GEOID_char; run;

proc sql;  
	SELECT count(*) INTO :num_geoids FROM unique_geoids; /* Should be 1784 */
quit; 

data _NULL_; replications = ceil(31000 / &num_geoids); CALL symput('reps', replications); run;

data work.simulated_fips;
	set work.unique_geoids;
		do rep = 1 to &reps;
			output;
		end;
	drop rep;
run; 

data work.simulated_fips; set work.simulated_fips(obs=31000); run;

data work.step_andrea_data; 
	merge work.step_andrea_data work.simulated_fips; 
run; 

/* Export fully simulated data as a SAS dataset */ 
libname aim1 "C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\data";
data aim1.step_andrea_data_aim1_sim;
    set work.step_andrea_data;
run;

