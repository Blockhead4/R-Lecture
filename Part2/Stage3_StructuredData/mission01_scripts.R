# 미션 3-1. 프로 야구 선수들이 밥값 하나요?

library(ggplot2)
library(dplyr)
library(reshape2)

data1 <- read.csv("data/야구성적.csv", stringsAsFactor=F)
data1
mean <- mean(data1$연봉대비출루율)
hlabel <- paste(mean, " % (평균출루율)")
hlabel

ggplot(data1, aes(x=선수명, y=연봉대비출루율, fill=선수명, color=선수명)) + 
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

data2 <- select(data1, 선수명, 득점, 안타, 홈런, 타점, 도루, 볼넷, 타율, 출루율)
head(data2)
data3 <- select(data1, 득점, 안타, 홈런, 타점, 도루, 볼넷, 타율, 출루율)

par(mfrow=c(5,5), mar=c(1,1,1,1))
for(i in 1:nrow(data2)) {
  pie(as.numeric(data2[i,-1]), radius = 1, main=data2[i,1], cex=1, init.angle = 90, col=rainbow(length(data2)-1), labels=NA)
}

par(mfrow=c(1,1), mar=c(5,5,5,5))
stars(data3, flip.labels=T, labels=data2[,1], draw.segments=T, frame.plot=T, full=T, main='야구 선수별 주요 성적 분석-2013년')

label=names(data2[,-1])
value <- table(label)
stars(data2, labels=data2[,1], draw.segments=T, col.segments=rainbow(length(data2)-1),
      frame.plot=T, full=T, main='야구 선수별 주요 성적 분석-2013년')
legend(5, 1, pie(c(1,1,1,1,1,1,1,1), radius=0.1, labels=colnames(data2[,-1]), col=rainbow(length(data2)-1)))

dimnames(data3)

colnames(data2[-1])
stars(data2, flip.labels=F, labels=colnames(data2[,-1]),
      draw.segments=T, frame.plot=T, full=T, main='야구 선수별 주요 성적 분석-2013년')

