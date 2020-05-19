library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")
library("ggplot2")
#library("ranger")
library("caret")


# Dataset preparation
read.csv("data/dataset_cleaned_csv") %>%
  na.omit %>%
  filter(DurationOfExistenceInMonths >= 0) -> ceidg

ceidg$Target <- ifelse(ceidg$Target == "True", F, T)

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
# ceidg_model <- ceidg %>% sample_n(1000) 
# model <- ranger(Target ~ . ,
#                 data = train(),
#                 num.trees = 100,
#                 probability = T)
ceidg <- sample_n(ceidg, 100000)
n <- nrow(ceidg)
# in_train <- sample(1:n, size = floor(1 * n / 4)) 
in_train <- sample(1:n, size = floor(3 * n / 4)) 
ceidg_train <- ceidg[in_train, ]
ceidg_test <- ceidg[-in_train, ]

rf_fit <- train(as.factor(Target) ~ ., 
                data = ceidg_train, 
                method = "ranger")

rf_fit

# predict the outcome on a test set
abalone_rf_pred <- predict(rf_fit, abalone_test)
# compare predicted outcome and true outcome
confusionMatrix(abalone_rf_pred, as.factor(abalone_test$old))
# final_predictions <- predict(model, sample_n(test, 1000))
# final_predictions <- ifelse(final_predictions$predictions>0.5, 1, 0)
# final_predictions <- as.factor(final_predictions)


# confusionMatrix(final_predictions, as.factor(test$Target))

