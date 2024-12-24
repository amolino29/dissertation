### DISSERTATION AIM #1
# Andrea Molino 
# STEP census tract effect modification - sample size calculation 
# Doing a stratified power calculation, i.e., one power calculation for each stratum of the effect modifier
# Will select a clinically meaningful difference between the groups and make sure I have enough power to do each 

rm(list=ls())
library(dplyr)
library(tidyverse)
library(ggplot2)
library(data.table)
library(pwr)
library(pwrss)


### 7/9/2024
# SLIGHTLY redoing power calculations below after talking to Kyra and Kieran. Basically thinking it's better to assume 80% power, 5% alpha, effect sizes, and THEN calculate the sample sizes you'd need for it
# Then check that you do indeed have the appropriate sample sizes 


### POWER CALCULATION 1 --> risk difference is *10%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this first power calculation, for the WORST 25%, we will assume a 40% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 30% effectiveness in the direct mail arm and an 18% effectiveness in the education arm 
# This represents 22% effectiveness in the worst 25% group, and 12% effectiveness in the best 75% group, representing a difference between stratum that is considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.40, p2=0.18, alpha=0.05,
               kappa=(354/352),  
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.30, p2=0.18, alpha=0.05, 
               kappa=(1061/1056),  
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)



### POWER CALCULATION 2 --> risk difference is *7.5%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this second power calculation, for the WORST 25%, we will assume a 38.75% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 31.25% effectiveness in the direct mail arm and an 18% effectiveness in the education arm 
# This represents 20.75% effectiveness in the worst 25% group, and 13.25% effectiveness in the best 75% group, representing a difference between stratum that is considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.3875, p2=0.18, alpha=0.05, 
               kappa=(354/352), 
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.3125, p2=0.18, alpha=0.05, 
               kappa=(1061/1056), 
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)



### POWER CALCULATION 3 --> risk difference is *5%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this third power calculation, for the WORST 25%, we will assume a 37.5% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 32.5% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# This represents 19.5% effectiveness in the worst 25% group, and 14.5% effectiveness in the best 75% group, representing a difference between stratum that is STILL considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.375, p2=0.18, alpha=0.05, 
               kappa=(354/352),
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.325, p2=0.18, alpha=0.05, 
               kappa=(1061/1056),  
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)


### POWER CALCULATION 4 --> risk difference is *3%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this fourth power calculation, for the WORST 25%, we will assume a 35% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 32% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# This represents 17% effectiveness in the worst 25% group, and 14% effectiveness in the best 75% group, representing a difference between stratum that is STILL considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.35, p2=0.18, alpha=0.05, 
               kappa=(354/352),
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.32, p2=0.18, alpha=0.05, 
               kappa=(1061/1056),  
               alternative="greater", power=0.80, 
               arcsin.trans = FALSE)


