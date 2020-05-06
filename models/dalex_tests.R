# Create a model for classification
library("DALEX")
library("randomForest")
library("dplyr")

model <- randomForest(status ~ . , data = HR)

#
# Create a DALEX explainer
explainer_rf_fired <- explain(model,
                              data = HR,  y = HR$status == "fired",
                              predict_function = function(m,x) predict(m,x, type = "prob")[,1])

#
# Calculate variable attributions
new_observation <- HRTest[12,]
library("breakDown")
bd_rf <- break_down(explainer_rf_fired,
                    new_observation,
                    keep_distributions = TRUE)

bd_rf


plot(bd_rf)


plot(bd_rf, plot_distributions = TRUE)



#####################################

ceidg <- read.csv("data/dataset_cleaned_csv")
# ceidg <- ceidg[c(1:50000), ]
ceidg <- sample_n(ceidg, 10000)

ceidg <- na.omit(ceidg)

# Too many levels of factors in below columns - need to test other models
drops <- c("MainAddressCounty","CorrespondenceAddressCounty")
ceidg <- ceidg[ , !(names(ceidg) %in% drops)]

model <- randomForest(Target ~ . , data = ceidg)

# Create a DALEX explainer
explainer_rf_fired <- explain(model,
                              data = ceidg,  y = ceidg$Target == "True",
                              predict_function = function(m,x) predict(m,x, type = "prob")[,1])

#
# Calculate variable attributions
new_observation <- ceidg[12,]
library("breakDown")
bd_rf <- break_down(explainer_rf_fired,
                    new_observation,
                    keep_distributions = TRUE)

bd_rf


plot(bd_rf)