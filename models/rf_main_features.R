# Create a model for classification
library("DALEX")
library("randomForest")
library("dplyr")
library("breakDown")

set.seed(123)

#####################################
ceidg <- read.csv("data/dataset_cleaned_csv")
# ceidg <- sample_n(ceidg, 500000) # this dataset is too large...
ceidg <- na.omit(ceidg) # drop n


# ceidg <- ceidg[, c("Target", "DurationOfExistenceInMonths", "X", "MainAddressTERC", "CorrespondenceAddressTERC",
#                    "PKDMainClass", "CorrespondenceTERCPopulation", "MainTERCPopulation", "NoOfUniquePKDClasses",
#                    "Sex")] # less important features line


n <- nrow(ceidg)
in_train <- sample(1:n, size = floor(1 * n / 5))
train <- ceidg[in_train, ]
test <- ceidg[-in_train, ]


model <- randomForest(Target ~ . , data = ceidg)
