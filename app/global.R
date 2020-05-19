# ML & XAI
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")
library("ranger")
library("ggplot2")
library("plotly")
library("shinythemes")


# Dataset preparation
read.csv("../data/dataset_cleaned_csv") %>%
  na.omit %>%
  filter(DurationOfExistenceInMonths >= 0) -> ceidg

# True = company survived
ceidg$Target <- ifelse(ceidg$Target == "True", F, T)

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
                   "NoOfLicences")
               ]

ceidg$PKDMainDivision <- as.factor(ceidg$PKDMainDivision)
ceidg$PKDMainGroup <- as.factor(ceidg$PKDMainGroup)
ceidg$PKDMainClass <- as.factor(ceidg$PKDMainClass)

# Dropdown lists data
DurationOfExistenceInMonths_unique <- unique(ceidg$DurationOfExistenceInMonths)

MainAddressVoivodeship_unique <- unique(ceidg$MainAddressVoivodeship)
MainAddressCounty_unique <- unique(ceidg$MainAddressCounty)
MainTERCPopulation_unique <- unique(ceidg$MainTERCPopulation)

PKDMainSection_unique <- unique(ceidg$PKDMainSection)
PKDMainDivision_unique <- unique(ceidg$PKDMainDivision)
PKDMainGroup_unique <- unique(ceidg$PKDMainGroup)
PKDMainClass_unique <- unique(ceidg$PKDMainClass)

HasLicences_unique <- unique(ceidg$HasLicences)
NoOfLicences_unique <- unique(ceidg$NoOfLicences)

### Prepare data for plots
# DurationOfExistenceInMonths
ceidg %>%
  group_by(DurationOfExistenceInMonths) %>%
  summarise(Mean = mean(Target)) -> DurationOfExistenceInMonths_TargetMean

ma <- function(x, n = 10){stats::filter(x, rep(1 / n, n), sides = 2)}
DurationOfExistenceInMonths_TargetMean$Mean <- ma(DurationOfExistenceInMonths_TargetMean$Mean)

# MainAddressVoivodeship
ceidg %>%
  group_by(MainAddressVoivodeship) %>%
  summarise(Mean = mean(Target)) -> MainAddressVoivodeship_TargetMean

# PKD Section
ceidg %>%
  group_by(PKDMainSection) %>%
  summarise(Mean = mean(Target)) -> PKDMainSection_TargetMean

# Model read 
model <- readRDS("../models/randomForestModel.rds")

#x = predict(object = model, data = test)

# explaination <- explain.default(model, data = ceidg[, -1], y = ceidg$Target)
# new_observation <- ceidg[12,]
# bd_rf <- break_down(explaination,
#                     new_observation,
#                     keep_distributions = TRUE)
# bd_rf

ceidg %>% sample_n(500) -> ceidg