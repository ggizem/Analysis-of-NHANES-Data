library(readxl)
library(dplyr)
library(caret)
library(glmnet)
library(tidyverse)

all_Data <- read_excel("D:/allData_without_diabetic.xlsx")

all_Data <- all_Data[,-c(1,141:143 )]

# Inspect the data
sample_n(all_Data, 3)

# Split the data into training and test set
set.seed(123)
training.samples <- all_Data$classify %>% createDataPartition(p = 0.8, list = FALSE)
train.data  <- all_Data[training.samples, ]
test.data <- all_Data[-training.samples, ]

# Dummy code categorical predictor variables
x <- model.matrix(classify~., train.data)[,-1]
# Convert the outcome (class) to a numerical variable
y <- ifelse(train.data$classify == "prediabetic", 1, 0)


# Find the best lambda using cross-validation
set.seed(123) 
cv.lasso <- cv.glmnet(x, y, alpha = 1, family = "binomial")
# Fit the final model on the training data
model <- glmnet(x, y, alpha = 1, family = "binomial",
                lambda = cv.lasso$lambda.min)
# Display regression coefficients
coef(model)
# Make predictions on the test data
x.test <- model.matrix(classify ~., test.data)[,-1]
probabilities <- model %>% predict(newx = x.test)
predicted.classes <- ifelse(probabilities > 0.5, "prediabetic", "normoglycemic")
# Model accuracy
observed.classes <- test.data$classify
mean(predicted.classes == observed.classes)

set.seed(123)
cv.lasso <- cv.glmnet(x, y, alpha = 1, family = "binomial")
plot(cv.lasso)

cv.lasso$lambda.min
cv.lasso$lambda.1se

coef(cv.lasso, cv.lasso$lambda.min)
coef(cv.lasso, cv.lasso$lambda.1se)

# Final model with lambda.min
lasso.model <- glmnet(x, y, alpha = 1, family = "binomial",
                      lambda = cv.lasso$lambda.min)
# Make prediction on test data
x.test <- model.matrix(classify ~., test.data)[,-1]
probabilities <- lasso.model %>% predict(newx = x.test)
predicted.classes <- ifelse(probabilities > 0.5, "prediabetic", "normoglycemic")
# Model accuracy
observed.classes <- test.data$classify
mean(predicted.classes == observed.classes)

# Final model with lambda.1se
lasso.model <- glmnet(x, y, alpha = 1, family = "binomial",
                      lambda = cv.lasso$lambda.1se)
# Make prediction on test data
x.test <- model.matrix(classify ~., test.data)[,-1]
probabilities <- lasso.model %>% predict(newx = x.test)
predicted.classes <- ifelse(probabilities > 0.5, "prediabetic", "normoglycemic")
# Model accuracy rate
observed.classes <- test.data$classify
mean(predicted.classes == observed.classes)