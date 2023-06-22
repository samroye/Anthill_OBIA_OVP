# Install the "car" package if not already installed
#install.packages("car")
#install.packages("caret")
library(caret)

# Load the required library
library(car)
data <- read_excel("Table_All.xls")

# Fit a linear regression model
model2 <- lm(anthill ~ aspect + curvplan + curvprof + Hmax + meanslope + slopeSD + SRI + TPI, data = data)

# Perform multicollinearity analysis using VIF
vif_results <- vif(model2)

# Print the VIF results
print(vif_results)

cor_matrix <- cor(data[, c("aspect", "curvplan", "curvprof", "Hmax", "meanslope", "slopeSD", "SRI", "TPI")])

# Print the correlation matrix
print(cor_matrix)

library(knitr)

# Compute the correlation matrix
cor_matrix <- cor(data[, c("aspect", "curvplan", "curvprof", "Hmax", "meanslope", "slopeSD", "SRI", "TPI")])

# Convert the correlation matrix into a table using kable
cor_table <- kable(cor_matrix, format = "markdown", digits = 2)

# Print the correlation table
print(cor_table)


#Metrics that dont correlate will be used in the RF model:
#aspect,curvprof, Hmax, meanslope, SRI

