# Create a model for classification
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")


#####################################
ceidg <- read.csv("data/dataset_cleaned_csv")
ceidg <- sample_n(ceidg, 500000) # this dataset is too large...
ceidg <- na.omit(ceidg) # drop nans for rf

# Too many levels of factors in below columns - need to test other models
drops <- c("MainAddressCounty","CorrespondenceAddressCounty")
ceidg <- ceidg[ , !(names(ceidg) %in% drops)]


# Define model
model <- randomForest(Target ~ . , data = ceidg)

# Create a DALEX explainer
explainer_rf_fired <- explain(model,
                              data = ceidg,  y = ceidg$Target == "True",
                              predict_function = function(m,x) predict(m,x, type = "prob")[,1])


# Calculate variable attributions
new_observation <- ceidg[12,]
bd_rf <- break_down(explainer_rf_fired,
                    new_observation,
                    keep_distributions = TRUE)

bd_rf

# Plot inference explaination 
plot(bd_rf)

# Plot wild graph (not sure what it is)
plot(bd_rf, plot_distributions = TRUE)

