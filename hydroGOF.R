library(zoo)
library(hydroGOF)

A=read.csv("SJ_R1_RO_2.csv",header=T)
gof(sim=A$TO_RU_1,obs=A$R_observed)

ggof(sim=A$TO_RU_1,obs=A$R_observed,ftype="dm",FUN=mean)
data(EgaEnEstellaQts)
obs <- EgaEnEstellaQts

obs <- window(obs, end=as.Date("1961-12-31"))

lband <- obs - 5
uband <- obs + 5

plotbands(obs, lband, uband)

sim <- obs + rnorm(length(obs), mean=3)
plotbands(obs, lband, uband, sim)
