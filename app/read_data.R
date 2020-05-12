library(dplyr)

# Dataset preparation
ceidg <- list()
read.csv("data/dataset_cleaned_csv") %>% na.omit %>% sample_n(10000) -> ceidg

# Dropdown lists data
MainAddressVoivodeship_unique <- unique(ceidg$MainAddressVoivodeship)
HasPolishCitizenship_unique <- unique(ceidg$HasPolishCitizenship)
Sex_unique <- unique(ceidg$Sex)
NoOfLicences_unique <- unique(ceidg$NoOfLicences)

DurationOfExistenceInMonths_unique <- unique(ceidg$DurationOfExistenceInMonths)
