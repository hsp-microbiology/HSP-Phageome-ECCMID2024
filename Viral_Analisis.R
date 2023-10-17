###################################################################
###################################################################
###################################################################
###     Functions Main file exam -> Created by Adrià         ######
###  Linkedin: https://www.linkedin.com/in/adria-cruells/    ######
###  ORCID: https://orcid.org/0000-0002-1179-7997            ######
###  Github:    Working on it                                ######
###################################################################
###################################################################

rm(list=ls()) ## Clean workspace

######## Enter the phyloseq object, set working directory and chargue libraries


setwd("Working directory") ###### put the directory were you work
Vaginal <- readRDS(file = "Vaginal_virus.rds")  #Enter directory of a created phytloseq( *:RData)
Gut <- readRDS(file = "Gut_virus.rds")  #Enter directory of a created phytloseq( *:RData)

################
##Analysis parameters
################

Adjformula <- ("Pacient+Age+BMI+Menopause") ##### Formula used on models
Grup_variable <- "Pacient" #### Name of group variable
Analysis_name <- "Fecal" ###Group analysis name
Results_directory <- "" ###### put the results directory
Normalitzation <- "TMM"

################
##Chargue the functions
################

for (analysis in list.files(***If running localy, path of working scripts*** , pattern = ".R")) { ####Put the directory whith all functions
  source(paste0(getwd(),"/Clean_codes/",analysis)) ####Load All scripts
}





