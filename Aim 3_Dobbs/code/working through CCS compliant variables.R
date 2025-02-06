

### FILES NEEDED 
# BRFSS definition of compliant by age and year has 2 tables in it that's very helpful in BRFSS documentation folder 
# BRFSS 2018 2020 questions in same folder 



brfss_2020_final <- brfss_2020_final %>% 
  mutate(pap3yr = case_when(
    HADPAP2 == 2 ~ 2, 
    HADPAP2 == 1 & LASTPAP2 %in% c(1,2,3) ~ 1, 
    HADPAP2 == 1 & LASTPAP2 %in% c(4,5)   ~ 2,
    TRUE ~ NA
  ))

brfss_2020_final <- brfss_2020_final %>% 
  mutate(pap5yr = case_when(
    HADPAP2 == 2 ~ 2, 
    HADPAP2 == 1 & LASTPAP2 %in% c(1,2,3,4) ~ 1, 
    HADPAP2 == 1 & LASTPAP2 %in% c(5)       ~ 2,
    TRUE ~ NA
  ))

brfss_2020_final <- brfss_2020_final %>% 
  mutate(hpv5yr = case_when(
    HPVTEST == 2 ~ 2,
    HPVTEST == 1 & HPLSTTST %in% c(1,2,3,4) ~ 1,
    HPVTEST == 1 & HPLSTTST %in% c(5)       ~ 2,
    TRUE ~ NA
  ))

brfss_2020_final <- brfss_2020_final %>% 
  mutate(ccs_modality = case_when(
    pap3yr == 1 & (hpv5yr != 1 | is.na(hpv5yr)) ~ "Pap", 
    # hpv5yr == 1 & (pap3yr == 2 | is.na(pap3yr)) ~ "HPV",
    # hpv5yr == 1 & (pap5yr == 2 | is.na(pap5yr)) ~ "HPV",
    hpv5yr == 1 & pap3yr == 1   ~ "Cotest",
    hpv5yr == 1 & pap5yr == 1   ~ "Cotest",
    TRUE ~ NA
  ))


test3 <- brfss_2020_final %>% select(pap3yr, pap5yr, hpv5yr) %>% unique()

test4 <- brfss_2020_final %>% select(HADPAP2, LASTPAP2, HPVTEST, HPLSTTST) %>% unique()

test


-----------------------------------------------------

pap3yr<-ifelse(hadpap2==2, 2, NA) 
pap3yr<-ifelse(hadpap2==1 & lastpap2 %in% c(1,2,3), 1, pap3yr) 
pap3yr<-ifelse(hadpap2==1 & lastpap2 %in% c(4,5), 2, pap3yr) 

pap5yr<-ifelse(hadpap2==2, 2, NA) 
pap5yr<-ifelse(hadpap2==1 & lastpap2 %in% c(1,2,3,4), 1, pap5yr) 
pap5yr<-ifelse(hadpap2==1 & lastpap2==5, 2, pap5yr) 

hpv5yr<-ifelse(hpvtest==2, 2, NA) 
hpv5yr<-ifelse(hpvtest==1 & hplsttst %in% c(1,2,3,4), 1, hpv5yr) 
hpv5yr<-ifelse(hpvtest==1 & hplsttst==5, 2, hpv5yr) 

paphpv5yr<-ifelse(pap5yr==1 & hpv5yr==1, 1, NA) 
paphpv5yr<-ifelse(pap5yr==2 | hpv5yr==2, 2, paphpv5yr) 

-----------------------------------------------------

brfss_2020_final <- brfss_2020_final %>% 
  mutate(hpv_cmplnt = case_when(
    HPVTEST == 2 ~ "Noncompliant", 
    HPVTEST == 1 & HPLSTTST %in% c(1,2,3,4) ~ "Compliant",
    HPVTEST == 1 & HPLSTTST %in% c(5) ~ "Noncompliant",
    TRUE ~ NA
  ))



