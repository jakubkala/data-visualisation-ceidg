library("FactoMineR")
library("factoextra")
library("dplyr")

read.csv("data/dataset_cleaned_csv") %>%
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



n <- 10000
ceidg <- sample_n(ceidg, n)
ceidg_active <- ceidg[seq(1,n), seq(2, 5)]
# ceidg_active$Target <- as.factor(ceidg_active$Target)
ceidg_active <- unique(ceidg_active)



res.famd <- FAMD(ceidg_active, ncp = 3,  graph = FALSE)

fviz_screeplot(res.famd)



# Plot of variables
fviz_famd_var(res.famd, repel = TRUE)
# Contribution to the first dimension
fviz_contrib(res.famd, "var", axes = 1)
# Contribution to the second dimension
fviz_contrib(res.famd, "var", axes = 2)


fviz_famd_var(res.famd)

fviz_famd_var(res.famd, "quanti.var", repel = TRUE, col.var = "black")

fviz_famd_var(res.famd, "quali.var", col.var = "black")


fviz_famd_var(res.famd, "quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)



fviz_mfa_ind(res.famd, 
             habillage = "HasLicenses", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, ellipse.type = "confidence", 
             repel = TRUE # Avoid text overlapping
            ) 










data(wine)
df <- wine[,c(1,2, 16, 22, 29, 28, 30,31)]
eig.val <- get_eigenvalue(res.famd)
head(eig.val)
res.famd <- FAMD(df, graph = FALSE)

fviz_screeplot(res.famd)

