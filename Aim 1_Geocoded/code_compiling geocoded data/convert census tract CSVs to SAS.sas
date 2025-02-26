/* 02/26/2025
- This code takes the CSV file with all the census tract level modifiers from the "final geocoded data" folder and converts it into
  a SAS dataset that can be easily merged into my Aim 1 analytic code. 
- This CSV files was created and compiled in November 2024 using an RMarkdown file that is in the same folder (geocoded_data_compiling).
- I'm only converting the "STEP_geocoded_data" CSV file (i.e., not doing the one with only the quartiles) because the STEP_geocoded_data
  has all the information I would need. No need to duplicate efforts and add confusion with two datasets. 
*/ 


*** Read in both CSV files; 
%let path=C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\code_compiling geocoded data\final geocoded data; 
options validvarname=v7;

proc import datafile="&path\STEP_geocoded_data.csv"
	out=work.STEP_geocoded_data 
	dbms=csv
	replace;
	guessingrows=max; 
	getnames=yes; 
	datarow=2; 
run; 


*** Because SAS reads CSV files in with incorrect formats, I'm going to set my own formats and make 
    sure ALL variables besides GEOID are set to be numeric;
data work.STEP_geocoded_data_num; 
	set work.STEP_geocoded_data; 
		RPL_THEMES_n 					= input(RPL_THEMES, best32.);
		RPL_THEMES_USA_n 				= input(RPL_THEMES_USA, best32.);
		RPL_THEMES_QUARTILE_WA_n 		= input(RPL_THEMES_QUARTILE_WA, best32.);
		RPL_THEMES_QUARTILE_KC_n 		= input(RPL_THEMES_QUARTILE_KC, best32.);
		AFFLUENCE16_20_n 				= input(AFFLUENCE16_20, best32.);
		PED3_16_20_n 					= input(PED3_16_20, best32.);
		PFAMINCGE125K16_20_n 			= input(PFAMINCGE125K16_20, best32.);
		PPROF16_20_n 					= input(PPROF16_20, best32.);
		AFFLUENCE16_20_armcreate_n 		= input(AFFLUENCE16_20_armcreate, best32.);
		affluence_quartile_WA_n 		= input(affluence_quartile_WA, best32.);
		affluence_quartile_KC_n 		= input(affluence_quartile_KC, best32.);
		perc_burden_gte30_n 			= input(perc_burden_gte30, best32.);
		perc_burden_gte30_quartile_WA_n = input(perc_burden_gte30_quartile_WA, best32.);
		perc_burden_gte30_quartile_KC_n = input(perc_burden_gte30_quartile_KC, best32.);
		perc_renter_n 					= input(perc_renter, best32.);
		perc_renter_quartile_WA_n 		= input(perc_renter_quartile_WA, best32.);
		perc_renter_quartile_KC_n 		= input(perc_renter_quartile_KC, best32.);
		perc_lt150poverty_n 			= input(perc_lt150poverty, best32.);
		perc_lt150poverty_quartile_WA_n = input(perc_lt150poverty_quartile_WA, best32.);
		perc_lt150poverty_quartile_KC_n = input(perc_lt150poverty_quartile_KC, best32.);
		medianincome_n 					= input(medianincome, best32.);
		medianincome_quartile_WA_n 		= input(medianincome_quartile_WA, best32.);
		medianincome_quartile_KC_n 		= input(medianincome_quartile_KC, best32.);
		perc_unemployed_n 				= input(perc_unemployed, best32.);
		perc_unemployed_quartile_WA_n 	= input(perc_unemployed_quartile_WA, best32.);
		perc_unemployed_quartile_KC_n 	= input(perc_unemployed_quartile_KC, best32.);
		perc_novehicle_n 				= input(perc_novehicle, best32.);
		perc_novehicle_quartile_WA_n 	= input(perc_novehicle_quartile_WA, best32.);
		perc_novehicle_quartile_KC_n 	= input(perc_novehicle_quartile_KC, best32.);
run; 


*** Double check some of the variables and data; 
data work.check; 
set work.STEP_geocoded_data_num;
keep    GEOID king_county
		medianincome_n medianincome
		medianincome_quartile_WA_n medianincome_quartile_WA
		medianincome_quartile_KC_n medianincome_quartile_KC
		RPL_THEMES_n RPL_THEMES
		RPL_THEMES_QUARTILE_WA_n RPL_THEMES_QUARTILE_WA
		RPL_THEMES_QUARTILE_KC_n RPL_THEMES_QUARTILE_KC
		perc_burden_gte30_n perc_burden_gte30
		perc_burden_gte30_quartile_WA_n perc_burden_gte30_quartile_WA
		perc_burden_gte30_quartile_KC_n perc_burden_gte30_quartile_KC;  
run; 


*** Drop non-numeric variables and rename the newly created numeric variables;
data work.STEP_geocoded_data_num; 
	set work.STEP_geocoded_data_num; 
		drop RPL_THEMES RPL_THEMES_USA RPL_THEMES_QUARTILE_WA RPL_THEMES_QUARTILE_KC AFFLUENCE16_20 
             PED3_16_20 PFAMINCGE125K16_20 PPROF16_20 AFFLUENCE16_20_armcreate affluence_quartile_WA 
             affluence_quartile_KC perc_burden_gte30 perc_burden_gte30_quartile_WA perc_burden_gte30_quartile_KC 
             perc_renter perc_renter_quartile_WA perc_renter_quartile_KC perc_lt150poverty perc_lt150poverty_quartile_WA 
             perc_lt150poverty_quartile_KC medianincome medianincome_quartile_WA medianincome_quartile_KC 
             perc_unemployed perc_unemployed_quartile_WA perc_unemployed_quartile_KC perc_novehicle 
             perc_novehicle_quartile_WA perc_novehicle_quartile_KC; 

		rename  RPL_THEMES_n 					= RPL_THEMES;
				RPL_THEMES_USA_n 				= RPL_THEMES_USA;
				RPL_THEMES_QUARTILE_WA_n 		= RPL_THEMES_QUARTILE_WA;
				RPL_THEMES_QUARTILE_KC_n 		= RPL_THEMES_QUARTILE_KC;
				AFFLUENCE16_20_n 				= AFFLUENCE16_20;
				PED3_16_20_n 					= PED3_16_20;
				PFAMINCGE125K16_20_n 			= PFAMINCGE125K16_20;
				PPROF16_20_n 					= PPROF16_20;
				AFFLUENCE16_20_armcreate_n 		= AFFLUENCE16_20_armcreate;
				affluence_quartile_WA_n 		= affluence_quartile_WA;
				affluence_quartile_KC_n 		= affluence_quartile_KC;
				perc_burden_gte30_n 			= perc_burden_gte30;
				perc_burden_gte30_quartile_WA_n = perc_burden_gte30_quartile_WA;
				perc_burden_gte30_quartile_KC_n = perc_burden_gte30_quartile_KC;
				perc_renter_n 					= perc_renter;
				perc_renter_quartile_WA_n 		= perc_renter_quartile_WA;
				perc_renter_quartile_KC_n 		= perc_renter_quartile_KC;
				perc_lt150poverty_n 			= perc_lt150poverty;
				perc_lt150poverty_quartile_WA_n = perc_lt150poverty_quartile_WA;
				perc_lt150poverty_quartile_KC_n = perc_lt150poverty_quartile_KC;
				medianincome_n 					= medianincome;
				medianincome_quartile_WA_n 		= medianincome_quartile_WA;
				medianincome_quartile_KC_n 		= medianincome_quartile_KC;
				perc_unemployed_n 				= perc_unemployed;
				perc_unemployed_quartile_WA_n 	= perc_unemployed_quartile_WA;
				perc_unemployed_quartile_KC_n 	= perc_unemployed_quartile_KC;
				perc_novehicle_n 				= perc_novehicle;
				perc_novehicle_quartile_WA_n 	= perc_novehicle_quartile_WA;
				perc_novehicle_quartile_KC_n 	= perc_novehicle_quartile_KC;
run; 

proc contents data=work.STEP_geocoded_data_num varnum; run; 


*** Reformat GEOID variable; 
data work.STEP_geocoded_data_num; 
	set work.STEP_geocoded_data_num; 
	GEOID_char = put(GEOID, 11.); 
	format GEOID_char $11.;
	label GEOID_char = "2020 Census Tract FIPS code"; 
	drop GEOID; 
run; 

proc contents data=work.STEP_geocoded_data_num; run;


*** Export as a SAS dataset; 
libname aim1 "C:\Users\amolino\Documents\GitHub\dissertation\Aim 1_Geocoded\code_compiling geocoded data\final geocoded data";
data aim1.STEP_geocoded_data;
    set work.STEP_geocoded_data_num;
run;












