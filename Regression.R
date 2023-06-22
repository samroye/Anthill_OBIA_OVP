# Load required packages
#install.packages("readxl")
#install.packages("dplyr")
#install.packages("glmnet")
#library(readxl)     
#library(dplyr)      
#library(glmnet)  
install.packages("vctrs")
library(vctrs)
library(randomForest)   
library(readxl) 
library(caret)
# Load in the data for the model
data2 <- read_excel("Metrics_all.xls")

data2$Anthill = as.factor(data2$Anthill)

#Random forest model
set.seed(50)
rf <-randomForest(Anthill~.,data=data2, ntree=500) 

predictions <- predict(rf, newdata = data2)

accuracy <- sum(predictions == data2$Anthill) / length(predictions)

print(accuracy)
#Calculate metric importance
importance(rf)
varImpPlot(rf, col = c("black", "black", "black", "black", "red"), pch = c(16), main = "Variable Importance Plot")

#calculating metric weight by normalizing on a 1-100 scale
220.7859+281.1064+823.9315+262.8192+282.8748
(220.7859/1871.518)*100 #aspect = 12
(281.1064/1871.518)*100 #curvprof = 15
(823.9315/1871.518)*100 #Hmax = 44
(262.8192/1871.518)*100 #meanslope = 14
(282.8748/1871.518)*100 #SRI = 15
15*15
