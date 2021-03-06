library(readxl)
library(caret)

data <- read_excel("D:/allData_without_diabetic.xlsx")
data <- data[,-c(1,141:143 )]

# split into training and validation datasets
set.seed(1234)
ind <- sample(2, nrow(data), replace=TRUE, prob=c(0.7, 0.3))
trainData <- data[ind==1,]
validationData <- data[ind==2,]
trainData <- trainData[complete.cases(trainData),]
validationData <- validationData[complete.cases(validationData),]

# define the control using a random forest selection function
control <- rfeControl(functions=nbFuncs, method="cv", number=10)

trainData$classify <- ifelse(trainData$classify == "prediabetic", 1, 2)

trainData$classify <- as.factor(trainData$classify)
str(trainData$classify)

# run the RFE algorithm
results <- rfe(trainData[ ,1:139], trainData[[140]], sizes=c(1:139), rfeControl=control)
print(results)

predictors(results)
plot(results, type=c("g", "o"))