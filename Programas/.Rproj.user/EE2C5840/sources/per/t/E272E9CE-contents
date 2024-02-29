library(tidyverse)
library(dummy)
library(caret)
library(ROCR)


set.seed(89) 
#save.image(file = "Models_CDR.Rdata")
load("Models_CDR.Rdata")
#Importación--------------------------------------
CDR <- read.csv("../CDR Prediction Dataset.csv") %>% tibble

CDR %>% str

#Preparación de data------------------------------------------------
HEART <- CDR %>%
  select(Heart_Disease,Sex,Diabetes,General_Health,Checkup,Age_Category,where(is.numeric),everything()) %>% 
  mutate(Diabetes = str_remove_all(Diabetes,"[,-]"),
    Diabetes = str_replace_all(Diabetes," ","_"))

HEART[,c(14:19)] <- HEART[,c(14:19)] %>% apply(2,function(x){ifelse(x=="Yes",1,0)})

HEART <- HEART %>% 
  mutate(across(where(is.character),as.factor),
         Heart_Disease = as.factor(Heart_Disease))

HEART$General_Health <- factor(HEART$General_Health,levels = c("Poor","Fair","Good","Very Good","Excellent")) %>% as.numeric()
HEART$Checkup <- factor(HEART$Checkup,levels = c("Never","5 or more years ago","Within the past 5 years","Within the past 2 years","Within the past year")) %>% as.numeric()  
HEART$Age_Category <- factor(HEART$Age_Category,levels = c("18-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75-79","80+")) %>% as.numeric()  

HEART <- HEART[,c("Sex","Diabetes")] %>% dummy() %>% 
  select(-Diabetes_No) %>% 
  apply(2,as.numeric) %>% 
  data.frame %>% 
  bind_cols(HEART[,-c(2,3)]) %>% 
  select(Heart_Disease, everything()) %>% 
  tibble()
  

#Datos de etnrenamiento--------------------
#Debido a que los registros con Heart_Disease== Yes corresponden cerca del 10% se genera una
#nueva data a partir de smote, también se escala y se centra
HEART.smote <- DMwR::SMOTE(Heart_Disease ~ .,data.frame(HEART))
smote.scaled <- HEART.smote[,-1] %>% scale()

#Parametros de escalado
HEART_center <- attr(smote.scaled, "scaled:center")
HEART_scale <- attr(smote.scaled, "scaled:scale")

HEART.smote <- bind_cols("Heart_Disease" = HEART.smote[,1],smote.scaled)

train.id <- createDataPartition(HEART.smote$Heart_Disease, p = 0.85, list = FALSE)

train.set <- HEART.smote[train.id,]
test.set <- HEART.smote[-train.id,]

#Generación de modelos--------------------
#Modelos a ocupar: nearest nighborg,regresion logistica,randomforest,xgboost


#k-Nearest Neighbour Classification----------------------------

#Análisis de hiperparametros (número de vecinos, k)


ks <- seq(5,200, by = 5)

ACCUARY.knn <- tibble("k" = ks,accuary = NA)
for (i in seq_along(ks)) {
  K <- knn3(Heart_Disease ~ ., train.set, k = ACCUARY.knn$k[i])  
  K2 <- predict(K,train.set, type = "class")
  K3 <- tibble("real" = train.set$Heart_Disease, "model" = K2) %>% table
  accuary <- (K3[1,1] + K3[2,2]) / sum(K3) * 100
  ACCUARY.knn[i,2] = accuary
  cat(i, " ---> ", accuary, "\n")
}
K <- ACCUARY.knn[ACCUARY.knn$accuary == max(ACCUARY.knn$accuary),"k"] #k optimo


#Ajuste de función de costo
model.knn <- knn3(Heart_Disease ~ ., train.set, k = K$k)  
predict.knn <- predict(model.knn,train.set, type = "prob")
prediction.knn <- ROCR::prediction(data.frame(predict.knn)$Yes,data.frame(train.set$Heart_Disease)) 
perf.knn <- performance(prediction.knn,"cost")

plot(perf.knn)
#Pto de corte sin sacrificar la presisicón (el objetivo es predecir la cardiopatia)
y.knn <- tibble("Pto Corte" = perf.knn@x.values[[1]], "Costo" = perf.knn@y.values[[1]]) %>% 
  filter(`Pto Corte`<0.5)
y.knn <- y.knn[y.knn$Costo == min(y.knn$Costo),"Pto Corte"]

#Evaluación
predict.test.knn <- predict(model.knn,test.set, type = "prob") %>% 
  data.frame() %>% 
  transmute(pred.knn = ifelse(Yes>=y.knn$`Pto Corte`,"Yes","No"), #y.knn
            pred.knn = as.factor(pred.knn)) %>% #
  bind_cols("Heart_Disease" = test.set$Heart_Disease) %>% 
  tibble() 

predict.test.knn %>% 
  table
  
(9799+11291) / (9799+1437+11291+3691) #80.44% Eficiencia
9799 / (9799+1437) #87.2% Presición


prediction.test.knn <- prediction(ifelse(predict.test.knn$pred.knn == "Yes",1,0),
                                  ifelse(predict.test.knn$Heart_Disease == "Yes",1,0)) %>% 
  #performance("auc") #AUC 0.8128
  performance("tpr","fpr")

prediction.test.knn@y.values

prediction.test.knn %>% plot
abline(c(0,0),c(1,1),col="red")


train.set$Heart_Disease %>% table
#Regresión logística-------------------

model.rlog <-  glm(Heart_Disease ~., data = train.set, family = "binomial")
summary(model.rlog)
model.rlog$residuals %>% plot

#Ajuste de función de costo
predict.rlog <- predict(model.rlog,train.set, type = "response")
prediction.rlog <- ROCR::prediction(predict.rlog,data.frame(train.set$Heart_Disease)) 
perf.rlog <- performance(prediction.rlog,"cost")

plot(perf.rlog)

y.rlog <- prediction.rlog@cutoffs[[1]][which.min(perf.rlog@y.values[[1]])]

#Evaluación
predict.test.rlog <- predict(model.rlog,test.set, type = "response") %>% 
  data.frame() %>% 
  transmute(pred.rlog = ifelse(`.`>=y.rlog,"Yes","No"),
            pred.rlog = as.factor(pred.rlog)) %>% 
  bind_cols("Heart_Disease" = test.set$Heart_Disease) %>% 
  tibble() 

predict.test.rlog %>% 
  table

(8457+11558) / (8457+11558+2779+3424)  #0.7634068 DE de accuary final para regresión logistica 
8457 / (8457+2779) #75.26% Presisión

prediction.test.reg <- prediction(ifelse(predict.test.rlog$pred.rlog == "Yes",1,0),
                                  ifelse(predict.test.rlog$Heart_Disease == "Yes",1,0)) %>% 
  #performance("auc") #AUC 0.7620645
  performance("tpr","fpr")

prediction.test.reg %>% plot
abline(c(0,0),c(1,1),col="red")


#Randomforest--------------
rf.control <- trainControl(method = "repeatedcv", number = 10, repeats = 2) #Validación cruzada repetida
grid <- expand.grid(mtry = c(20, 100,300)) #Ajuste de hiperparametros

weights <- c(Yes = 2, No = 1)
model.rf <- train(Heart_Disease ~ . ,data = train.set, method = "rf",type = "Classification",
      trControl = rf.control,
      tuneGrid = grid,
      classwt = weights)

#Evaluación
predict.test.rf <- predict(model.rf,test.set, type = "raw") %>% 
  data.frame() %>% 
  bind_cols("Heart_Disease" = test.set$Heart_Disease) %>% 
  tibble() 

predict.test.rf %>% 
  table

8974 / (8974+2262)#79.86%%
(8974+13920) / (13920+2262+1062+8974)#87.32%

prediction.test.rf <- prediction(ifelse(predict.test.rf$`.` == "Yes",1,0),
                                  ifelse(predict.test.rf$Heart_Disease == "Yes",1,0)) %>% 
  #performance("auc") #AUC 0.8638989
  performance("tpr","fpr")

#prediction.test.rf@y.values

prediction.test.rf %>% plot
abline(c(0,0),c(1,1),col="red")


#XGBoost--------
model.xg <- train(Heart_Disease ~ . ,data = train.set, method = "xgbTree")

predict(model.xg,test.set) %>% 
  data.frame() %>% 
  bind_cols("Heart_Disease" = test.set$Heart_Disease) %>% 
  tibble() %>% 
  table

(14084+8794) / (14084+8794+2442+898) #0.8726
8794 / (8794+2442)  #78.26







