# 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기

# 대한민국 시도별 인구 단계 구분도 만들기
install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(tibble)
library(maps)
library(ggiraphExtra)

korpop1

names(korpop1)
korpop1 <- rename(korpop1, pop=총인구_명, name=행정구역별_읍면동)   # 컬럼명 바꾸기
head(korpop1)

ggChoropleth(data = korpop1,
             aes(fill=총인구_명, map_id=code), 
             map = kormap1,
             interactive=T)

