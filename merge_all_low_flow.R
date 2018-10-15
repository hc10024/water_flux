#install(dplyr)
library(dplyr)
library(tidyr)
library(tidyverse)

# read file and transform the file

for (i in 1993:2016){
  #year=2005
  name=sprintf("all_%d_mean_lowflow.csv", i)
  IDW = read.csv(name)
  IDW1=t(IDW)
  #zonal(IDW, PO, 'mean')
  ras2_name = sprintf("all_%d_mean_lowflowt.csv", i)
  write.csv(IDW1,ras2_name)
  
}

# filter value
for (i in 1993:2016){
  #year=2005
  name = sprintf("prob_%d_ok.csv",i,header=T)
  IDW=read.csv(name)
  IDW[IDW[1:S,]<0.9]<-NA
  #zonal(IDW, PO, 'mean')
  ras2_name = sprintf("prob_%d_f.csv", i)
  write.csv(IDW,ras2_name)
  
}

# merge file

A=read.csv("test_2007_t1ok.csv",header=T)
B=read.csv("prob_2007_dry.csv",header=T)
#B=B[-c(1),] # remove one col
colnames(B)<-colnames(A)

A1=bind_rows(A,B)
A1ok=A1[order(A1$S_ID),]
A1ok=t(A1ok)

write.csv(A1ok, file="all_fok_2007.csv")
# indexing the dataframe 

Test=read.csv('all_fok_2007.csv',header=T)
Test=Test[,-c(1)]

# give index to create a odd or even sequecne
start <- seq(1, by = 2, length = ncol(Test) / 2)
#split the big dataframe into a list of dataframe
sdf <- lapply(start, function(i, Test) Test[i:(i+1)], Test = Test)
# sort the list by prob col and delete the rows with NA and calculate the mean of first column in subdataframe
sorted_sdf=lapply(sdf, function(df){df[order(df[,2]),]; df[complete.cases(df), ]})
mean_sdf=lapply(sorted_sdf, function(df){meanl=mean(df[,1]);return(meanl)})
mean_df=as.data.frame(mean_sdf)
mean_df=t(mean_df)
write.csv(mean_df,file="all_2007_mean_lowflow.csv")



