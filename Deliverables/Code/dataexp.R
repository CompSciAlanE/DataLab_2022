###################### Data Exploration #############################
# June, 21th, 2022 # 
#####################################################################

# Library EVERY day--------------------------------------------------
library(tidyverse)

# Library -----------------------------------------------------------
jh<-read_csv('jacobzip.csv')
View(jh)

# Possible help for 
# Patient_Discharge_Status : Will tell us if they have expired
# page: 46 Data Dictionary
# -------------------------
# Accident_Code : Tells us if it was covered or not!
# page: 50 Data Dictionary
# -------------------------
# Primary_Payer_ClassCd : Tell us how they payed.
# Secondary_Payer_Class_Cd : Same as top.
# Tertiary_Payer_Class_Cd : Same as top.
# Page: 71 Data Dictionary
# Page: 68 Data Dictionray
# Page: 65 Data Dictionary
# -------------------------
#  


# IMPORTANT COLUMNS
# -----------------
# Admit_Diag_Cd : The condition identified by the physician at the
# Time of the patients admission requiring hospitalization.
# -----------------
# 

# Getting rid of a useless column
jh<-jh %>% select(-...1,
                  -Type_Bill,
                  -Fed_Tax_SubID,
                  -Fed_Tax_Num,
                  -Admission_Type,
                  -Admission_Source,
                  -Do_Not_Resuscitate,
                  -Accident_St,
                  -starts_with("Units_Service"), #[1:18]
                  -Primary_Health_Plan_Id,
                  -Secondary_Health_Plan_Id,
                  -Tertiary_Health_Plan_Id,
                  -Primary_Patient_Rel_Insr,
                  -Secondary_Patient_Rel_Insr,
                  -Tertiary_Patient_Rel_Insr,
                  -Dx_Px_Qualifier,
                  -starts_with("POA"), #[1:18]
                  -starts_with("Patient_Reason_Visit"),#[1:3],
                  -Prospect_Pay_Code,
                  -starts_with("Ecode"), #[1:3]
                  -starts_with("E_POA"), #[1:3]
                  -Type_ER_Visit,
                  -Outcome_ER_Visit,
                  -Inpatient_Flag,
                  -ER_Flag,
                  -PET_Flag,
                  -ASTC_Flag,
                  -Lithotripsy_Flag,
                  -MRI_MRA_Flag,
                  -Megavolt_Rad_Flag,
                  -CT_Flag,
                  -Fatal_Error_Flag,
                  -starts_with("Record_Num"), #[1:2]
                  -Bill_End,
                  -MUL,
                  -Patient_ID,
                  -TN_Co_Res,
                  -Payer_A,
                  -Payer_B,
                  -Payer_C,
                  -Amount_Counter,
                  -Race,
                  -LOS,
                  -DRG_Rank,
                  -Inpat_Record_Flag,
                  -ER_Record_Flag,
                  -ASTC_Record_Flag,
                  -Obs_23hr_Record_Flag,
                  -CON_Flag,
                  -Cumulative_Record_Flag,
                  -Reportable_Flag,
                  -TN_Co_Unk,
                  -Processing_Period,
                  -MS_MDC,
                  -MS_DRG,
                  -MS_DRG_4digit,
                  -HAC,
                  -Admit_From_ED_Flag,
                  -Wrong_Claim
                   )

jh$Ser

