# ML & XAI
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")
library("ranger")
library("ggplot2")

# Dataset preparation
read.csv("../data/dataset_cleaned_csv") %>% na.omit -> ceidg
ceidg <- ceidg[, c("Target",
                   "DurationOfExistenceInMonths",
                   "PKDMainClass",
                   "MainAddressVoivodeship",
                   "MainAddressCounty",
                   "MainAddressTERC",
                   "MainTERCPopulation",
                   "PKDMainGroup",
                   "PKDMainSection")
               ]


# Dropdown lists data
DurationOfExistenceInMonths_unique <- unique(ceidg$DurationOfExistenceInMonths)
PKDMainClass_unique <- unique(ceidg$PKDMainClass)
MainAddressVoivodeship_unique <- unique(ceidg$MainAddressVoivodeship)
MainAddressCounty_unique <- unique(ceidg$MainAddressCounty)
MainAddressTERC_unique <- unique(ceidg$MainAddressTERC)
MainTERCPopulation_unique <- unique(ceidg$MainTERCPopulation)
PKDMainGroup_unique <- unique(ceidg$PKDMainGroup)
PKDMainSection_unique <- unique(ceidg$PKDMainSection)

# Model 
ceidg %>% sample_n(10000) -> ceidg

model <- ranger(Target ~ . ,
                data = ceidg,
                probability = TRUE, 
                importance = 'impurity',
                write.forest=TRUE,
                num.trees = 500)

#x = predict(object = model, data = test)

# explaination <- explain.default(model, data = ceidg[, -1], y = ceidg$Target)
# new_observation <- ceidg[12,]
# bd_rf <- break_down(explaination,
#                     new_observation,
#                     keep_distributions = TRUE)
# bd_rf