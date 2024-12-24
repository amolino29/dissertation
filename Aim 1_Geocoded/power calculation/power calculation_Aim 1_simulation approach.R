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




#--------------------------------------------------------------------------------


### 7/9/2024
# This first power calculation will be seeing is we're powered to detect a 10% higher risk difference in the worst 25% of census tracts compared to the best 75% of census tracts
# This power calculation is for the OVERDUE group 
# In the worst 25% stratum, there are 354 in the direct mail arm and 352 in the usual care arm (1415*0.25 and 1408*0.25)
# In the best 75% stratum, there are 1061 in the direct mail arm and 1056 in the usual care arm (1415*0.75 and 1408*0.75)


### POWER CALCULATION 1 --> risk difference is *10%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this first power calculation, for the WORST 25%, we will assume a 40% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 30% effectiveness in the direct mail arm and an 18% effectiveness in the education arm 
# This represents 22% effectiveness in the worst 25% group, and 12% effectiveness in the best 75% group, representing a difference between stratum that is considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.40, p2=0.18, alpha=0.05,
               kappa=(354/352), n2=352, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.30, p2=0.18, alpha=0.05, 
               kappa=(1061/1056), n2=1056, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)



### POWER CALCULATION 2 --> risk difference is *7.5%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this second power calculation, for the WORST 25%, we will assume a 38.75% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 31.25% effectiveness in the direct mail arm and an 18% effectiveness in the education arm 
# This represents 20.75% effectiveness in the worst 25% group, and 13.25% effectiveness in the best 75% group, representing a difference between stratum that is considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.3875, p2=0.18, alpha=0.05, 
               kappa=(354/352), n2=352, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.3125, p2=0.18, alpha=0.05, 
               kappa=(1061/1056), n2=1056, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)


### POWER CALCULATION 3 --> risk difference is *5%* higher in the 25% worst census tracts compared to the 75% best census tracts
# In this third power calculation, for the WORST 25%, we will assume a 37.5% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# In the BEST 75%, we will assume a 32.5% effectiveness in the direct mail arm and an 18% effectiveness in the education arm
# This represents 19.5% effectiveness in the worst 25% group, and 14.5% effectiveness in the best 75% group, representing a difference between stratum that is STILL considered clinically significant 

# Calculate the power for the worst 25% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.375, p2=0.18, alpha=0.05, 
               kappa=(354/352), n2=352, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)

# Calculate the power for the best 75% of census tracts (direct mail=group 1, education=group 2)
pwrss.z.2props(p1=0.325, p2=0.18, alpha=0.05, 
               kappa=(1061/1056), n2=1056, 
               alternative="greater", power=NULL, 
               arcsin.trans = FALSE)





#--------------------------------------------------------------------------------


### START OF SIMULATION APPROACH
# For this power calculation, I took a simulation approach to estimate the power for the interaction term in the model
# Andrea Molino 

# Clear environment and load libraries
rm(list=ls())

# install.packages('lme4')
# install.packages('simr')
# install.packages('Matrix')
# install.packages('Rcpp')
# install.packages('RcppEigen')

library('lme4')
library('simr')
library('Matrix')
library('Rcpp')
library('RcppEigen')

# Set seed for entire script 
set.seed(626)


### FOR DUE GROUP 
# Define group sizes and known outcome distributions for STEP trial arms
n_edu          <- 3960  # Total number of participants for educational arm (reference)
n_direct       <- 1482  # Total number of participants for direct mail arm (comparator)
n_edu_event    <- 1885  # Number of events for educational arm (reference)
n_direct_event <- 919   # Number of events for direct mail arm (comparator)

# Total sample size
n_total <- n_edu + n_direct

# Proportion of tract distribution in each group
tract_prob_50 <- 0.5  
tract_prob_25 <- 0.25  

# Generate data
set.seed(626)
arm   <- c(rep(0, n_edu), rep(1, n_direct))  # Group sizes for STEP trial arm
tract <- rbinom(n_total, 1, tract_prob_25)   # Randomly generate distribution based on assumed proportion

# Define outcome based on the known distribution for STEP trial arm
outcome <- 
  c(rep(1, n_edu_event),    rep(0, n_edu - n_edu_event), 
    rep(1, n_direct_event), rep(0, n_direct - n_direct_event))

# Pull together into a dataframe 
data_aim1sim <- data.frame(outcome, arm, tract)

# Check the data distributions 
table(data_aim1sim$arm, deparse.level = 2)
table(data_aim1sim$tract, deparse.level = 2)
table(data_aim1sim$outcome, data_aim1sim$arm, deparse.level = 2)


# Now that we've simulated our STEP dataset, we can fit our main log-binomial model of interest 
model_1 <- glmer(outcome ~ arm * tract + (1 | arm:tract), data = data_aim1sim, family = binomial(link = "log"))

# Run power simulation
power_sim <- powerSim(model_1, nsim = 100, test = fixed("arm:tract"))
power_sim


### FOR OVERDUE GROUP 
# Define group sizes and known outcome distributions for STEP trial arms
n_uc           <- 1408  # Total number of participants for educational arm (reference)
n_direct       <- 1415  # Total number of participants for direct mail arm (comparator)
n_uc_event     <- 264   # Number of events for educational arm (reference)
n_direct_event <- 507   # Number of events for direct mail arm (comparator)

# Total sample size
n_total <- n_uc + n_direct

# Proportion of tract distribution in each group
tract_prob_50 <- 0.50 
tract_prob_25 <- 0.25
tract_prob_10 <- 0.10

# Generate data
arm   <- c(rep(0, n_uc), rep(1, n_direct))  # Group sizes for STEP trial arm
tract <- rbinom(n_total, 1, tract_prob_10)  # Randomly generate distribution based on assumed proportion

# Define outcome based on the known distribution for STEP trial arm
outcome <- 
  c(rep(1, n_uc_event),     rep(0, n_uc - n_uc_event), 
    rep(1, n_direct_event), rep(0, n_direct - n_direct_event))

# Pull together into a dataframe 
data_aim1sim_overdue <- data.frame(outcome, arm, tract)

# Check the data distributions 
table(data_aim1sim_overdue$arm, deparse.level = 2)
table(data_aim1sim_overdue$tract, deparse.level = 2)
table(data_aim1sim_overdue$outcome, data_aim1sim_overdue$arm, deparse.level = 2)


# Now that we've simulated our STEP dataset, we can fit our main log-binomial model of interest 
model_2 <- glmer(outcome ~ arm * tract + (1 | arm:tract), data = data_aim1sim_overdue, family = binomial(link = "log"))

# Run power simulation
power_sim <- powerSim(model_2, nsim = 100, test = fixed("arm:tract"))
power_sim





# Fit the initial model
model_1 <- glm(outcome ~ arm * tract, data = data_aim1sim_overdue, family = binomial(link = "log"))

# Define the custom power simulation function
power_sim_custom <- function(model, nsim, effect_name) {
  p_values <- replicate(nsim, {
    # Simulate a new dataset based on the fitted model
    simulated_data <- data_aim1sim_overdue
    simulated_data$outcome <- rbinom(nrow(data_aim1sim_overdue), 1, predict(model, type = "response"))
    
    # Fit the model to the simulated dataset
    sim_model <- glm(outcome ~ arm * tract, data = simulated_data, family = binomial(link = "log"))
    
    # Extract the p-value of the interaction term
    summary(sim_model)$coefficients[effect_name, "Pr(>|z|)"]
  })
  
  # Calculate the proportion of significant p-values
  power <- mean(p_values < 0.05)
  return(power)
}

# Perform the power simulation
nsim <- 100  # Number of simulations
effect_name <- "arm:tract"  # The name of the interaction term
power <- power_sim_custom(model_1, nsim, effect_name)

# Print the estimated power
print(power)














