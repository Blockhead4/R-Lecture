# 예제 3-1. 서울시 주요 구의 의원 현황을 분석하기

install.packages("plotly")
library(ggplot2)
library(dplyr)
library(stringr)
library(reshape2)

 data1<- read.csv("data/2013년_서울_주요구별_병원현황.csv")
#data1 <- read.csv("data/2013년_서울_주요구별_병원현황.csv")
data1

barplot(as.matrix(data1[1:9, 2:11]), 
        main=paste("서울시 주요 구별 과목별 병원현황-2013년", "\n", "출처[국민건강보험공단]"),
        ylab="병원수", beside=T, col=rainbow(8), ylim=c(0,350))
abline(h=seq(0,350,10), lty=3, lwd=0.2)

name <- data1$표시과목
name
legend(75, 350, name, cex=0.8, fill=rainbow(8), bg="white")


# ggplot으로 그래프 그리기

# reshape2 패키지 안의 melt함수로 데이터를 Long 형태로 재구성 
data2 <- melt(data1, id='표시과목')
head(data2)  

gg <- ggplot(data2, aes(x=variable, y=value, fill=표시과목)) + geom_bar(position = "dodge", stat="identity") +
  geom_hline(yintercept = seq(0,330,30), lty="dashed", size=0.1, color="skyblue") +
  ggtitle(paste("서울시 주요 구별 과목별 병원현황-2013년", "\n", "출처[국민건강보험공단]")) +
  theme(plot.title = element_text(face="bold", hjust=1.5, vjust=2, color = "black")) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank())
gg

library(plotly)
ggplotly(g)
