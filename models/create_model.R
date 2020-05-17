# ML & XAI
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")
library("ggplot2")
#library("ranger")

# Dataset preparation
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

# Model 
ceidg %>% sample_n(1000) -> ceidg_model

model <- ranger(Target ~ . ,
                data = ceidg_model,
                num.trees = 100,
                probability = T)
# save model to RDS file
saveRDS(model, file = "../models/randomForestModel.rds")




