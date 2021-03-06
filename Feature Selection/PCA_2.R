library(readxl)

continuousData  <- read_excel("PCA_2.xlsx")
continuous_data <- subset(continuousData , select = -c(SEQN, classify))

pca <- prcomp(continuous_data, center = TRUE, scale= TRUE)
pca

#means of variables
pca$center
#sd of variables
pca$scale
#principal component loading vector
pca$rotation

biplot(pca, scale = 0)
#std and variance - Adopt the one with eigen value greater than 1 
std_dev <- pca$sdev
pr_var <- std_dev^2
pr_var

#proportion of variance
prop_varex <- pr_var/sum(pr_var)
prop_varex

#variance y�zde halinde
variance <- pr_var*100/sum(pr_var)
variance

#cumulative variance
cumvar <- cumsum(variance)
cumvar

my.var <- varimax(pca$rotation)
my.var

#scree plot
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")

#cumulative scree plot
plot(cumsum(prop_varex), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")

###########KMO

z_c_data <- continuous_data %>% 
  psycho::standardize() 
summary(z_c_data)
apply(z_c_data, 2, sd)

KMOS(z_c_data) #0.61 mediocre