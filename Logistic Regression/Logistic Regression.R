library(readxl)
library(caret)
rfData <- read_excel("rfData.xlsx")

glm.fit <- glm(classify ~ ., data = rfData, family = binomial)

summary(glm.fit)
glm.probs <- predict(glm.fit,type = "response")
glm.probs[1:33]

glm.pred <- ifelse(glm.probs > 0.5, 1, 0)

attach(rfData)
table(glm.pred,classify)
table(drop$DMDHREDU, classify)

mean(glm.pred == classify)

smp_size <- floor(0.70 * nrow(rfData))
set.seed(123)
train_ind <- sample(seq_len(nrow(rfData)), size = smp_size)

train <- rfData[train_ind, ]
test <- rfData[-train_ind, ]

glm.fit.train <- glm(classify ~ ., 
                     data = train, 
                     family = binomial)

glm.probs <- predict(glm.fit.train, 
                     newdata = test, 
                     type = "response")

glm.pred <- ifelse(glm.probs > 0.5, 1, 0)

classify2 = test$classify
table(glm.pred, classify2)

mean(glm.pred == classify2)

drop <- subset(rfData, select=-c(LBXHGB_LBXRBCSI, LBXSATSI_LBXSGTSI, IMQ020, DMDHHSIZ, LBXSCR, MCQ160A, BPQ020, LBXSTR, DMQMILIZ, LBXSLDSI, LBDHEG, BPQ059, MCQ365A, MCQ365B, MCQ370C, KIQ480))

glm.fit.after.drop <- glm(classify ~ ., data = drop, family = binomial)
summary(glm.fit.after.drop)

drop.probs <- predict(glm.fit.after.drop,type = "response")
drop.probs[1:17]

drop.pred <- ifelse(drop.probs > 0.5, 1, 0)

attach(rfData)
table(drop.pred,classify)

summary(drop)

table(drop$DMDHREDU, classify)
unknownOrg <- read.table("educationlevel.txt", header=TRUE, sep=",", dec=".")
predict(glm.fit.after.drop, unknownOrg, type = "response")

table(drop$BPQ080, classify)
unknownOrg2 <- read.table("cholesterol.txt", header=TRUE, sep=",", dec=".")
predict(glm.fit.after.drop, unknownOrg2, type = "response")

unknownOrg3 <- read.table("potassiumlevel.txt", header=TRUE, sep=",", dec=".")
predict(glm.fit.after.drop, unknownOrg3, type = "response")