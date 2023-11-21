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
Results_directory <- "" ###### put the results directory

################
##Chargue the functions (All the funcitons on function codes folder)
################

for (analysis in list.files(***If running localy, path of working scripts*** , pattern = ".R")) { ####Put the directory whith all functions
  source(paste0(getwd(),"/Clean_codes/",analysis)) ####Load All scripts
}


################
##Figure 1A
################

Analysis_name <- "Vaginal" ###Group analysis name


Results_list <- Diferential_function(Vaginal_virus, ### Check the name of your vaginal virus phyloseq
                                                       Taxonomy = "Species",
                                                  "bonferroni",
                                                  Adjformula,
                                                  Grup_variable,
                                                  Results_directory)

## Save the plot
#ggsave(plot = Results_list[[2]],paste0(Results_directory,"/",Analysis_name,"Virus.png"), width = 20, height = 20, units = "cm")

################
##Figure 1B
################
Analysis_name <- "Vaginal" ###Group analysis name


Results_list <- Diferential_function(Vaginal, ### Check the name of your vaginal phyloseq
                                                           Taxonomy ="Genus",
                                                           "bonferroni",
                                                           Adjformula,
                                                           Grup_variable,
                                                           Results_directory)


## Save the plot
#ggsave(plot = Species[[2]],paste0(Results_directory,"/",Analysis_name,"Bacterial_genus.png"), width = 20, height = 20, units = "cm")





################
##Figure 2A
################
  
  Analysis_name <- "Fecal" ###Group analysis name
  
  
    Results_list <- Diferential_function(Gut_virus, ### Check the name of your fecal virus phyloseq
                                                     Taxonomy = "Species",
                                                    "BH",
                                                    Adjformula,
                                                    Grup_variable,
                                                    Results_directory)
  
  
  ## Save the plot
  #ggsave(plot = Results_list[[2]],paste0(Results_directory,"/",Analysis_name,"Virus.png"), width = 20, height = 20, units = "cm")


################
##Figure 2B
################

  
  Results_list <- Diferential_function(Gut, ### Check the name of your fecal virus phyloseq
                                                           Taxonomy = "Genus",
                                                           "bonferroni",
                                                           Adjformula,
                                                           Grup_variable,
                                                           Results_directory)


## Save the plot
#ggsave(plot = Results_list[[2]],paste0(Results_directory,"/",Analysis_name,"Bacterial.png"), width = 20, height = 20, units = "cm")

