library(randomForest)
library(DMwR)

HEART %>% str
HEART2 <- HEART
HEART2[,-1] <- HEART2[,-1] %>% scale

HEART2 <- HEART2 %>% 
  mutate(Heart_Disease = ifelse(Heart_Disease == "Yes",1,0))
  
HEART2 %>% str

smoting <- DMwR::SMOTE(Heart_Disease ~ .,data.frame(HEART2))

smoting$Heart_Disease %>% table


weights <- c(Yes = 3, No = 1)

smoting[,-1] <- smoting[,-1] %>% scale

smoting %>% str

model <- randomForest(Heart_Disease ~ .,smoting,ntree = 200,classwt = weights)
plot(model)

model


65675 / (65675 + 11218)

(65675+88666) / (65675+88666+11218+9238)










