# ML & XAI
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")
library("ranger")
library("ggplot2")

# Dataset preparation
read.csv("../data/dataset_cleaned_csv") %>%
  na.omit %>%
  filter(DurationOfExistenceInMonths >= 0) -> ceidg

ceidg <- ceidg[, c("Target",
                   "DurationOfExistenceInMonths",
                   "MainAddressVoivodeship",
                   "MainAddressCounty",
                   "MainTERCPopulation",
                   "PKDMainSection",                  
                   "PKDMainDivision",                 
                   "PKDMainGroup",                    
                   "PKDMainClass",
                   "HasLicences",
                   "NoofLicences")
               ]

ceidg$PKDMainDivision <- as.factor(ceidg$PKDMainDivision)
ceidg$PKDMainGroup <- as.factor(ceidg$PKDMainGroup)
ceidg$PKDMainClass <- as.factor(ceidg$PKDMainClass)

# Model 
ceidg %>% sample_n(100000) -> ceidg_model

model <- ranger(Target ~ . ,
                data = ceidg_model,
                probability = TRUE, 
                importance = 'impurity',
                write.forest=TRUE,
                num.trees = 1000)
# save model to RDS file
saveRDS(model, file = "../models/randomForestModel.rds")
