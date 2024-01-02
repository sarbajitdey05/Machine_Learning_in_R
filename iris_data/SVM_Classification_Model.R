### Importing libraries
library(datasets)
library(caret) # Package for machine learning algorithms

data(iris)

# Check whether data set contains missing values
sum(is.na(iris))

set.seed(100) # Reproducibility of the model

# Stratified random split of the data
TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE)

TrainingSet <- iris[TrainingIndex,] # Training set
TestingSet <- iris[-TrainingIndex,] # Testing set

# Scatter plot of training vs testing subset
plot(TrainingSet, TestingSet)

### Support Vector Machine Model (Polynomial Model)

# Build training model

Model <- train(Species ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess=c("scale","center"),
               trControl= trainControl(method="none"),
               tuneGrid = data.frame(degree=1,scale=1,C=1))

# Build a cross validation model

Model.cv <- train(Species ~ ., data = TrainingSet,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess=c("scale","center"),
                  trControl= trainControl(method="cv", number=10),
                  tuneGrid = data.frame(degree=1,scale=1,C=1))

# Apply model for prediction

Model.training <- predict(Model, TrainingSet) # Make prediction on training set
Model.testing <- predict(Model, TestingSet) # Make prediction on testing set
Model.cv <- predict(Model.cv, TrainingSet) # Performs cross validation

# Model performance (Confusion matrix & Statistics)

Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Species)
Model.testing.confusion <- confusionMatrix(Model.testing, TestingSet$Species)
Model.cv.confusion <- confusionMatrix(Model.cv, TrainingSet$Species)

print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)

# Feature importance
Importance <- varImp(Model)
plot(Importance)
plot(Importance, col = "red")
