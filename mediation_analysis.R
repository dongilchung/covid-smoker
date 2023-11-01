# set.seed(1234)
# https://cran.r-project.org/web/packages/mediation/mediation.pdf

#install.packages("mediation") #uncomment this command in case you haven't installed the mediation package yet.

# mediate(model.m, model.y, sims = 1000, boot = FALSE,
#         boot.ci.type = "perc", treat = "treat.name", mediator = "med.name",
#         covariates = NULL, outcome = NULL, control = NULL,
#         conf.level = 0.95, control.value = 0, treat.value = 1,
#         long = TRUE, dropobs = FALSE, robustSE = FALSE, cluster = NULL,
#         group.out = NULL, use_speed = FALSE, ...)
# ACME: average causal mediation effect 

setwd("~/Dropbox/COVID-19_PNU_task/Drafts/Smoker/_Script/CovidSmoker_gitHub_230926")

rm(list=ls())
ls()

library(R.matlab)
library(mediation)

Mdata <- readMat('data_mediation_Sample2_additional_self.mat')
# Mdata <- readMat('data_mediation_Sample2_additional_others.mat')

IV=Mdata$Md[,1]
DV=Mdata$Md[,2]
M=Mdata$Md[,3]
Covariate=Mdata$covariates # sex, education, political orientation

############################################################################
# direct effect (IV --> DV)
############################################################################
fit.totaleffect=lm(DV~IV + Covariate)
# fit.totaleffect=lm(DV~IV)
summary(fit.totaleffect)
confint(fit.totaleffect, level=0.95)

############################################################################
# IV --> mediator
############################################################################
fit.mediator=lm(M ~ IV + Covariate)
# fit.mediator=lm(M ~ IV)
summary(fit.mediator) 
confint(fit.mediator, level=0.95)

############################################################################
# mediator --> DV 
############################################################################
fit.dv=lm(DV ~ IV + M + Covariate)
# fit.dv=lm(DV ~ IV + M)
summary(fit.dv)
confint(fit.dv, level=0.95)

############################################################################
# causal mediation analysis
############################################################################
results = mediate(fit.mediator, fit.dv, sims=5000, treat='IV', mediator='M', boot=T, covariates='Covariate')
# results = mediate(fit.mediator, fit.dv, sims=5000, treat='IV', mediator='M', boot=T)
summary(results) 
