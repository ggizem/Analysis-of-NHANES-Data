library(readxl)
library(tidyverse)
library(REdaS)
library(factoextra)

####################################################### PRINCIPAL COMPONENT ANALYSIS
#### EXAMINATION DATA
eData <- read_excel("D:/Users/suuser/Desktop/Bitirme Projesi/Predicting Factors Affecting Prediabetes/4. First PCA/exam_continuous.xlsx")
e_data <- subset(eData, select = -c(SEQN))
colnames(e_data)
str(e_data)

z_e_data <- e_data %>% 
  psycho::standardize() 

summary(z_e_data)
apply(z_e_data, 2, sd)

KMOS(z_e_data) #0.8227562 meritorious

exam_pca <- prcomp(e_data, scale= T)
names(exam_pca)

#std and variance
std_dev <- exam_pca$sdev
pr_var <- std_dev^2
pr_var

#proportion of variance
prop_varex <- pr_var/sum(pr_var)
prop_varex

#show the percentage of variances explained by each principal component
#scree plot
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")

#cumulative scree plot
plot(cumsum(prop_varex), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")


# Graph of variables. Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
fviz_pca_var(exam_pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)
#Graph of variables and data points
biplot(exam_pca, scale = 0)

# Eigenvalues
eig.val <- get_eigenvalue(exam_pca)
eig.val

# Results for Variables
exam.var <- get_pca_var(exam_pca)
exam.var$coord          # Coordinates
exam.var$contrib        # Contributions to the PCs
exam.var$cos2           # Quality of representation 

### NEWLY CREATED DATA
cData <- read_excel("D:/Users/suuser/Desktop/Bitirme Projesi/Predicting Factors Affecting Prediabetes/4. First PCA/created_continuous.xlsx")

c_data <- subset(cData, select = -c(SEQN))
colnames(c_data)
str(c_data)

z_c_data <- c_data %>% 
  psycho::standardize() 

summary(z_c_data)
apply(z_c_data, 2, sd)

KMOS(z_c_data) #0.4974348 meritorious

c_pca <- prcomp(c_data, scale= T)

#std and variance
std_dev <- c_pca$sdev
pr_var <- std_dev^2
pr_var

#proportion of variance
prop_varex <- pr_var/sum(pr_var)
prop_varex

#show the percentage of variances explained by each principal component
#scree plot
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")

#cumulative scree plot
plot(cumsum(prop_varex), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")


# Graph of variables. Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
fviz_pca_var(c_pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)
#Graph of variables and data points
biplot(c_pca, scale = 0)

# Eigenvalues
eig.val <- get_eigenvalue(c_pca)
eig.val

# Results for Variables
c.var <- get_pca_var(c_pca)
c.var$coord          # Coordinates
c.var$contrib        # Contributions to the PCs
c.var$cos2           # Quality of representation 

### LAB DATA
lData <- read_excel("D:/Users/suuser/Desktop/Bitirme Projesi/Predicting Factors Affecting Prediabetes/4. First PCA/lab_continuous.xlsx")

l_data <- subset(lData, select = -c(SEQN))
colnames(l_data)
str(l_data)

z_l_data <- l_data %>% 
  psycho::standardize() 

summary(z_l_data)
apply(z_l_data, 2, sd)

KMOS(z_l_data) #0.4744802
