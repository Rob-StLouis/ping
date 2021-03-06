library(dplyr)
library(ggplot2)
library(magrittr)
library(gmodels)
library(arm)

DAD2Data <- read.csv("Data/DAD2Data.csv",stringsAsFactors=T)
COMTData <- read.csv("Data/COMT_RS4680.csv",stringsAsFactors=F)
BehaveData <- read.csv("Data/PING_Behavior.csv",stringsAsFactors=FALSE)

Data <- DAD2Data %>%
  left_join(BehaveData,by=c("SubjID")) %>%
  left_join(COMTData,by=c("SubjID")) 

#We are filtering out peopel w/ no scores


Data %<>%
  filter( is.na(FDH_27_Ever_Diag_ADHD)==F,
          FDH_27_Ever_Diag_ADHD =="Yes"||FDH_27_Ever_Diag_ADHD =="No",
          is.na(FDH_3_Household_Income)==F
          )%>%
  mutate(dADHD =ifelse(FDH_27_Ever_Diag_ADHD=="Yes",1,0),
         SES = as.numeric(FDH_3_Household_Income))

Data %<>%
  filter(is.)


#linear regressions with various behavioral data
glm0 <- glm(dADHD~Gender+Age_At_NPExam,data=Data,family=binomial)
glm1 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_flanker_score+SES,data=Data,family=binomial)
glm2 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_flanker_score*SES,data=Data,family=binomial)
glm3 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_flanker_score*SES,data=Data,family=binomial)

summary(glm3)

glm0 <- glm(dADHD~Gender+Age_At_NPExam,data=Data,family=binomial)
glmr1 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_reading_score+SES,data=Data,family=binomial)
glmr2 <- glm(dADHD~Gender+log(Age_At_NPExam)*TBX_reading_score+SES,data=Data,family=binomial)
glmr3 <- glm(dADHD~Gender+log(Age_At_NPExam)*TBX_reading_score*SES,data=Data,family=binomial)

glma0 <- glm(dADHD~Gender+log(Age_At_NPExam),data=Data,family=binomial)
glma1 <- glm(dADHD~log(Age_At_NPExam)+TBX_attention_score,data=Data,family=binomial)
glma2 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_attention_score*SES,data=Data,family=binomial)
glma3 <- glm(dADHD~Gender+log(Age_At_NPExam)+TBX_attention_score*SES,data=Data,family=binomial)

summary(glma3)

qplot(log(Age_At_NPExam),TBX_attention_score,group=dADHD,color=dADHD,geom=c("smooth","point"),size=dADHD,data=Data)


anova(glma1,glma2,glma3,test="Chisq")




qplot(Data$TBX_flanker_score+Data,Data$DTI_fiber_FA-L_pSCS )





#Simulation
Data$SES <- as nu
x = runif(100,.25,.75)
x1 = .25*(.01+rbinom(100,1,.5))
y= rbinom(100,1,x*x1)
lm <- glm(y~x,family=binomial)

qplot(x,lm$fitted.values,facets=.~x1)


Genetic = round(rnorm(10000,0,4))
SES = rbinom(10000,1,.5)
logodds = Genetic*0.5 +SES
logistic = function(z){1/(1+exp(-z))}
prob = logistic(logodds)
Diagnosed = rbinom(10000, 1, prob)
qplot(Genetic,prob,color=SES)

Genetic = rnorm(10000,0,4)
SES = rnorm(10000,40,5)
logodds = Genetic*0.5 +SES*Genetic*0.01+SES*.01+ rnorm(10000,0,.5)
logistic = function(z){1/(1+exp(-z))}
prob = logistic(logodds)
Diagnosed = rbinom(10000, 1, prob)
qplot(Genetic,Diagnosed,color=SES)

summary(glm(Diagnosed~SES*Genetic,family=binomial))

summary(glm(Diagnosed~SES*Genetic))






 


