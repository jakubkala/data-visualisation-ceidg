library("FactoMineR")
library("factoextra")
library("dplyr")

read.csv("../data/dataset_cleaned_csv") %>%
  na.omit %>%
  filter(DurationOfExistenceInMonths >= 0) -> ceidg

ceidg$Target <- ifelse(ceidg$Target == "True", T, F)

important_cols = c("Target",
                   "DurationOfExistenceInMonths",
                   "MainAddressVoivodeship",
                   "MainAddressCounty",
                   "MainTERCPopulation",
                   "PKDMainSection",                  
                   "PKDMainDivision",                 
                   "PKDMainGroup",                    
                   "PKDMainClass",
                   "HasLicences",
                   "NoOfLicences")

ceidg <- ceidg[, important_cols]


ceidg$PKDMainDivision <- as.factor(ceidg$PKDMainDivision)
ceidg$PKDMainGroup <- as.factor(ceidg$PKDMainGroup)
ceidg$PKDMainClass <- as.factor(ceidg$PKDMainClass)

ceidg <- sample_n(ceidg, 10000)
ceidg_active <- ceidg[1:55, 1:6]
res.mca <- MCA(ceidg_active, graph = FALSE) # need 
