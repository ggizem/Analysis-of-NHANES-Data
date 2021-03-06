library(Boruta)
library(readxl)

all_Data <- read_excel("D:/allData_without_diabetic.xlsx")
all_Data <- all_Data[,-c(1,141:143 )]

str(all_data)

set.seed(111)
boruta.all_data <- Boruta(classify~., data = all_data, doTrace = 2)
print(boruta.all_data)

plot(boruta.all_data, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.all_data$ImpHistory),function(i)
  boruta.all_data$ImpHistory[is.finite(boruta.all_data$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.all_data$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(boruta.all_data$ImpHistory), cex.axis = 0.7)

getSelectedAttributes(boruta.all_data, withTentative = F)

all_data_df <- attStats(boruta.all_data)
print(all_data_df)