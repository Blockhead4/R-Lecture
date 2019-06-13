# 미션 3-1. 프로 야구 선수들이 밥값 하나요?

library(ggplot2)
library(dplyr)
library(reshape2)

data1 <- read.csv("data/야구성적.csv", stringsAsFactor=F)
data1

data2 <- select(data1, 선수명, 연봉대비출루율)
data2

mean <- mean(data2$연봉대비출루율)
hlabel <- paste(mean, " % (평균출루율)")
hlabel


ggplot(data2, aes(x=선수명, y=연봉대비출루율, fill=선수명, color=선수명)) + 
  geom_bar(width=0.9, stat="identity") +
  geom_text(aes(y=연봉대비출루율*1.05, label=연봉대비출루율), color="black", size=3) +
  geom_hline(yintercept = mean) +
  annotate("text", x=3, y=mean+1, label=hlabel, size=3) +
  theme_light() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  ggtitle(paste("야구 선수별 연봉 대비 출루율 분석", "\n", "(밥값여부계산^^;;)")) +
  theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=10)) +
  theme(axis.title.y = element_text(color="red"))

