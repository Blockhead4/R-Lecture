# Treemap() 활용하기

install.packages('treemap')
library(treemap)

total <- read.csv('data/학생시험결과_전체점수.csv', header=T, sep=',')
total

treemap(total, vSize='점수', index=c('점수','이름'))           # 같은 점수를 가진 이름들을 기준으로 treemap 생성
treemap(total, vSize='점수', index=c('조','이름'))             # 같은 점수를 가진 조를 기준으로 treemap 생성
treemap(total, vSize='점수', index=c('점수','조','이름'))      # 같은 점수를 가진 이름, 조를 기준으로 treemap 생성



# stars() 함수로 비교 분석하기

total2<- read.table('data/학생별전체성적_new.txt', header=T, sep=','); total2
row.names(total2) <- total2$이름; total2
total2 <- total2[,2:7]; 
total2

stars(total2, flip.labels=F, draw.segments=F, frame.plot=T, full=T, main='학생별 과목별 성적분석 - STAR Chart')

# 범례 만들기
lab <- names(total2)
value <- table(lab); value
pie(value, labels=lab, radius=0.1, cex=0.6, col=NA)     # 파이 그래프를 만들고 PPT등을 이용해 스타차트와 합성해 범례를 생성

# 나이팅게일 차트
stars(total2, flip.labels=F, draw.segments=T, frame.plot=T, full=T, main='학생별 과목별 성적분석 - 나이팅게일 차트')

label <- names(total2)               # 파이차트로 범례만들어 합치기
label
value <- table(label); value
color <- c('black','red','green','blue','cyan','violet')
pie(value, labels=label, col=color, radius=0.1, cex=0.6)


# radarchart() 함수로 멋진 레이더차트 출력하기 : 레이더 차트

install.packages('fmsb')
library(fmsb)

layout <- data.frame(
  분석력=c(5,1),
  창의력=c(15,3),
  판단력=c(3,0),
  리더쉽=c(5,1),
  사교성=c(5,1));
layout

set.seed(123)     # 랜덤 데이터 생성(생성 후 계속 같은 값으로 고정하는 함수)

data1 <- data.frame(
  분석력=runif(3,1,5),      # runif( 생성할 0 ~ 1 사이의 값의 개수, 초기값, 끝값 ) 
  창의력=rnorm(3,10,2),     # rnom( 생성할 정규분포 값의 개수, 평균, 표준편차 ) : random normal distribution(정규 분포)
  판단력=c(0.5,NA,3),       
  리더쉽=runif(3,1,5),
  사교성=c(5,2.5,4))
data1

data2 <- rbind(layout,data1)
data2

par(mar=c(1,0.5,3,1),mfrow=c(2,2))     # 여백과 배치를 조정
radarchart(data2, axistype=1, seg=5, plty=1, title="첫번째 타입")
radarchart(data2, axistype=2, pcol=topo.colors(3), plty=1,title="두번째 타입")
radarchart(data2, axistype=3, pty=32, plty=1, axislabcol="grey", na.itp=FALSE, title="세번째 타입)")
radarchart(data2, axistype=0, plwd=1:5, pcol=1, title="네번째 타입")

par(mar=c(0,0,0,0),mfrow=c(1,1))
