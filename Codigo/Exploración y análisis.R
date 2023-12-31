library(tidyverse)
options(scipen=999)

#Importación--------------------------------------
CDR <- read.csv("../CDR Prediction Dataset.csv") %>% tibble


#Explorqación--------------------------------------
CDR <- CDR %>%
  mutate(across(where(is.character), as.factor)) %>% 
  select(Heart_Disease,everything())

#Estructura y resumen
CDR %>% 
  str()
summary(CDR)
anyNA(CDR) #Sin ningún dato nullo

#Registros con y sin enfermedades del corazón
CDR$Heart_Disease %>% table #8.79%


#Variables numéricas
CDR %>% select(where(is.numeric)) %>% names()

CDR$Height_.cm. %>% hist #Normal
CDR$Height_.cm. %>% boxplot #Outplots

CDR$Weight_.kg. %>% hist #Normal sin los outliers
CDR$Weight_.kg. %>% boxplot #Outplots

CDR$BMI %>% hist #Normal sin los outliers
CDR$BMI %>% boxplot #Outplots

col<-colorRampPalette(c("#BB4444","#EE9988","#FFFFFF","#77AADD","#4477AA"))
CDR %>% 
  mutate(Heart_Disease2 = ifelse(Heart_Disease == "Yes", 1,0)) %>% 
  select(where(is.numeric)) %>% 
  scale(center = TRUE, scale = TRUE) %>% 
  cor %>% 
  corrplot::corrplot(method = "circle",tl.col = "black",tl.srt = 45,number.cex = 1,
                     addCoef.col = "black",order = "FPC",type="upper",
                     diag=F,addshade = "all",
                     col = col(200))

#Respuesta respeto a las variables
names(CDR)

ggplot(data = CDR) +
  geom_bar(aes(factor(General_Health,levels = c("Poor","Fair","Good","Very Good", "Excellent")),fill = Heart_Disease )) +
  labs(y = "N de Registros", x = "General_Health")

ggplot(data = CDR) +
  geom_bar(aes(factor(Checkup,levels = c("Never","5 or more years ago","Within the past 5 years","Within the past 2 years","Within the past year")),fill = Heart_Disease )) +
  labs(y = "N de Registros", x = "Checkup")

ggplot(data = CDR) +
  geom_bar(aes(Exercise,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Exercise")

ggplot(data = CDR) +
  geom_bar(aes(Skin_Cancer,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Skin_Cancer")

ggplot(data = CDR) +
  geom_bar(aes(Other_Cancer,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Other_Cancer")

ggplot(data = CDR) +
  geom_bar(aes(Depression,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Depression")

ggplot(data = CDR) +
  geom_bar(aes(Diabetes,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Diabetes")

ggplot(data = CDR) +
  geom_bar(aes(Arthritis,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Artritis")#Artritis

ggplot(data = CDR) +
  geom_bar(aes(Sex,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Sex") #Sexo

ggplot(data = CDR) +
  geom_bar(aes(Age_Category,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Edad")#Edad

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,Height_.cm., fill = Heart_Disease)) +
  labs(y = "Altura (cm.)", x = "Height_.cm.")

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,Weight_.kg., fill = Heart_Disease)) +
  labs(y = "Peso (Kg.)", x = "Weight_.kg.")

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,BMI, fill = Heart_Disease)) +
  labs(y = "índice de masa corporal")

ggplot(data = CDR) +
  geom_bar(aes(Smoking_History,fill = Heart_Disease)) +
  labs(y = "N de Registros", x = "Fumador")#Fuma

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,Alcohol_Consumption, fill = Heart_Disease)) +
  labs(y = "Consumo de copas (último mes)", x = "Alcohol_Consumption")

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,Fruit_Consumption, fill = Heart_Disease)) +
  labs(y = "Consumo de fruta (último mes)", x = "Fruit_Consumption")

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,Green_Vegetables_Consumption, fill = Heart_Disease)) +
  labs(y = "Consumo de verduras (último mes)", x = "Green_Vegetables_Consumption")

ggplot(data = CDR) +
  geom_violin(aes(Heart_Disease,FriedPotato_Consumption, fill = Heart_Disease)) +
  labs(y = "Consumo de papas fritas (último mes)", x = "FriedPotato_Consumption")



CDR %>% 
  ggplot()+
  geom_bar(aes(Heart_Disease),fill = c("#00CDCD","#EE3B3B")) +
  labs(y = "N de Registros", x = "Problema Cardiovascular")+
  scale_y_continuous(breaks = seq(0,300000, by = 50000))



#Prueba de diferencia de medias para conocer si el BMI difiere entre el padecimiento---------------

BMI.yes <- CDR[CDR$Heart_Disease=="Yes","BMI"]$BMI
BMI.no <- CDR[CDR$Heart_Disease=="No","BMI"]$BMI


tseries::jarque.bera.test(BMI.no)#No normal
tseries::jarque.bera.test(BMI.yes)#No normal

#Prueba de diferencias wilcox (U de Mann)
wilcox.test(BMI.no,BMI.yes) #Existe diferencia entre las medias de los valores











