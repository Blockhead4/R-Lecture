# 그래픽 기초

setwd('d:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part4')

# plot() 함수
# plot( y축 데이터, 옵션 )
# plot( x축 데이터, y축 데이터, 옵션 )

var1 <- 1:5
plot(var1)
var2 <- c(2, 2, 2)
plot(var2)

x <- 1:3
y <- 4:2
plot(x, y)
plot(x, y, xlim = c(0, 4), ylim = c(0, 5))
plot(x, y, xlim = c(0, 4), ylim = c(0, 5), 
     xlab = 'x축 값', ylab = 'y축 값', main = 'Plot Test')

v1 <- c(100, 130, 120, 160, 150)
plot(v1, type = 'o', col = 'red', ylim = c(0, 200), axes = F, ann = F)     # ann = F : x, y축 제목을 지정하지 않음
                                                                           # axes = F : x, y축을 표시하지 않음
axis(1, at = 1:5, lab = c('MON', 'TUE', 'WED', 'THU', 'FRI'))              # axis : x, y축을 사용자 지정 값으로 표시
axis(2, ylim = c(0, 200))                                                  # 1 : x축 / 2: y축

title(main = 'FRUIT', col.main = 'red', font.main = 4)
title(xlab = 'DAY', col.lab = 'black')
title(ylab = 'PRICE', col.lab = 'blue')

par(mfrow = c(1, 3))    # mfrow() : 그래프의 배치 조정
plot(v1, type = 'o')
plot(v1, type = 's')
plot(v1, type = 'l')

par(mfrow = c(1, 3))
pie(v1)
plot(v1, type = 'b')
barplot(v1)

par(mfrow = c(1, 1))
a <- c(1, 2, 3)
plot(a, xlab = 'aaa')
par(mgp = c(0, 1, 0))     # mgp = c(제목 위치, 지표값 위치, 지표선 위치)
plot(a, xlab = 'aaa')
par(mgp = c(3, 1, 0)); plot(a, xlab = 'aaa')
par(mgp = c(3, 2, 0)); plot(a, xlab = 'aaa')
par(mgp = c(3, 2, 1)); plot(a, xlab = 'aaa')

par(oma = c(2, 1, 0, 0)); plot(a, xlab = 'aaa')     # oma = c(bottom , left, top, right) : 그래프 전체의 여백 조정
par(oma = c(0, 2, 0, 0)); plot(a, xlab = 'aaa')

?par()    # par 옵션 도움말

# 여러 개의 그래프 중첩해서 그리기
v1 <- c(1, 2, 3, 4, 5)
v2 <- c(5, 4, 3, 2, 1)
v3 <- c(3, 4, 5, 6, 7)
plot(v1, type = 's', col = 'red', ylim = c(1, 7))
par(new = T)   # 이 부분이 중복 허용 부분입니다
plot(v2, type = 'o', col = 'blue', ylim = c(1, 7))
par(new = T)
plot(v3, type = 'l', col = 'green', ylim = c(1, 7))

# lines() 를 사용하여 보다 쉽게 그리기
plot(v1, type = 's', col = 'red', ylim = c(1, 10))
lines(v2, type = 'o', col = 'blue', ylim = c(1, 5))
lines(v3, type = 'l', col = 'green', ylim = c(1, 15))

# 그래프에 범례 추가하기 : legend()
# legend( x축 위치, y축 위치, 내용, cex = 글자크기, col = 색상, pch = 점의 모양, lty = 선 모양 ) 
plot(v1, type = 's', col = 'red', ylim = c(1, 10))
lines(v2, type = 'o', col = 'blue', ylim = c(1, 5))
lines(v3, type = 'l', col = 'green', ylim = c(1, 15))

legend(4, 9, c('v1', 'v2', 'v3'), cex = 1.2, col = c('red', 'blue', 'green'), lty = 1)



# barplot() : 막대 그래프 그리기

x <- c(1, 2, 3, 4, 5);
barplot(x)
barplot(x, horiz = T)     # 그래프를 가로로 출력

# beside = T : 그룹으로 묶어서 출력
x <- matrix(c(5, 4, 3, 2), 2, 2)
x <- matrix(c(5, 4, 3, 2), nrow = 2); x
barplot(x, names = c(5, 3), col = c('green', 'yellow'))
barplot(x, beside = T, names = c(5, 3), col = c('green', 'yellow'))
barplot(x, beside = T, names = c(5, 3), col = c('green', 'yellow'), ylim = c(0, 12))
par(oma = c(1, 0.5, 1, 0.5))
barplot(x, beside = T, names = c(5, 3), col = c('green', 'yellow'), horiz = T)
barplot(x, names = c(5, 3), col = c('green', 'yellow'), xlim = c(0, 12), horiz = T)

# 여러 막대 그래프를 그룹으로 묶어서 한번에 출력하기
par(oma = c(0, 0, 0, 0))
v1 <- c(100, 120, 140, 160, 180)
v2 <- c(120, 130, 150, 140, 170)
v3 <- c(140, 170, 120, 110, 160)
qty <- data.frame(BANANA = v1, CHERRY = v2, ORANGE = v3); qty

barplot(as.matrix(qty), main = 'Fruit\'s Sales qty', beside = T, col = rainbow(nrow(qty)), ylim = c(0, 400))
legend(14, 400, c('MON', 'TUE', 'WED', 'THU', 'FRI'), cex = 0.8, fill = rainbow(nrow(qty)))

# 하나의 막대 그래프에 여러 가지 내용을 한꺼번에 출력하기
qty
t(qty)     # t : transform : 행과 열을 바꾸어줌
barplot(t(qty), main = 'Fruits Sales qty', ylim = c(0, 900), col = rainbow(length(qty)),   
        space = 0.1, cex.axis = 0.8, las = 1, names.arg = c('MON', 'TUE', 'WED', 'THU', 'FRI'), cex = 0.8)
legend(0.2, 800, names(qty), cex = 0.7, fill = rainbow(length(qty)))

# 조건을 주고 그래프 그리기
peach <- c(180, 200, 250, 198, 170)
colors <- c()
for (i in 1:length(peach)) {
  if (peach[i] >= 200) {
    colors <- c(colors, 'red')
  } else if (peach[i] >= 180) {
    colors <- c(colors, 'yellow')
  } else {
    colors <- c(colors, 'green')
  }
}
barplot(peach, main = 'Peach Sales QTY', names.arg = c('MON', 'TUE', 'WED', 'THU', 'FRI'), col = colors)



# hist() : 히스토그램 그래프 그리기

height <- c(182, 175, 167, 172, 163, 178, 181, 166, 159, 155)
hist(height, main = 'Histogram of height')

par(mfrow = c(1, 2), oma = c(2, 2, 0.1, 0.1))
barplot(height, main = 'Barplot of height', ylim = c(0, 200))
hist(height, main = 'Histogram of height')



# pie() : 파이(pie) 차트 그리기

par(mfrow = c(1, 1), oma = c(0.5, 0.5, 0.1, 0.1))
p1 <- c(10, 20, 30, 40)
pie(p1, radius = 1)      # radius : 반지름(크기) / defalt 값 : 0.8
pie(p1, init.angle = 90)
pie(p1, radius = 0.8, init.angle = 90)     # init.angle = 각도 : 시작 각도 지정
pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)))
pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), label = c('Week 1', 'Week 2', 'Week 3', 'Week 4'))

# 수치 값을 함께 출력하기
pct <- round(p1/sum(p1)*100, 1); pct
lab <- paste(pct, '%'); lab
pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), label = lab, cex = 2)
legend(1, 1, c('Week 1', 'Week 2', 'Week 3', 'Week 4'), cex = 0.7, fill = rainbow(length(p1)))

# 범례를 생략하고 그래프에 바로 출력하기
lab1 <- c('Week 1', 'Week 2', 'Week 3', 'Week 4')
lab2 <- paste(lab1, '\n', pct, '%'); lab2
pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), label = lab2, cex = 2)



# pie3D() 함수
install.packages('plotrix')
library(plotrix)

p1 <- seq(10, 50, 10)
f_day <- round(p1/sum(p1)*100, 1)
f_label <- paste(f_day, '%')
pie3D(p1, main = '3D Pie Chart', col = rainbow(length(p1)), cex = 0.5, labels = f_label, explode = 0.05)
legend(0.5, 1, c('MON', 'TUE', 'WED', 'THU', 'FRI'), cex = 0.6, fill = rainbow(length(p1)))



# boxplot() : 상자 차트

v1 <- c(10, 12, 15, 11, 20)
v2 <- c(5, 7, 15, 8, 9)
v3 <- c(11, 20, 15, 18, 13)
boxplot(v1, v2, v3)
boxplot(v1, v2, v3, col = c('blue', 'yellow', 'pink'), names = c('Blue', 'Yellow', 'Pink'), horizontal = T)



# igraph() : 관계도 그리기

install.packages('igraph')
library(igraph)

g1 <- graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6)); g1
plot(g1)
str(g1)     # str(data)(structure) : 데이터의 구조 파악

name <- c('서진수 대표이사', '일지매 부장', '김유신 과장', '손흥민 대리', '노정호 대리', '이순신 부장',
          '유관순 과장', '신사임당 대리', '강감찬 부장', '광개토 과장', '정몽주 대리')
pemp <- c('서진수 대표이사', '서진수 대표이사', '일지매 부장', '김유신 과장', '김유신 과장', '서진수 대표이사',
          '이순신 부장', '유관순 과장', '서진수 대표이사', '강감찬 부장', '광개토 과장')
emp <- data.frame(이름 = name, 상사이름 = pemp); emp

g <- graph.data.frame(emp, directed = T); g
png('graph/network_1.png', 600, 600)      # 그림으로 그래프 저장
plot(g, layout = layout.fruchterman.reingold, vertax.size = 8, edge.arrow.size = 0.5)
dev.off()

savePlot('graph/network_1.png', type = 'png')     # 실행 안됨

png('graph/network_2.png', width = 600, height = 600)
plot(g, layout = layout.fruchterman.reingold, vertax.size = 8, edge.arrow.size = 0.5)
dev.off()

g3 <- graph.data.frame(emp, directed = F); g3
plot(g3, layout = layout.fruchterman.reingold, vertex.size = 8, edge.arrow.size = 0.5, vertex.label = NA)
plot(g3, layout = layout.kamada.kawai, vertex.size = 8, edge.arrow.size = 0.5, vertex.label = NA)



# d3Network() 패키지를 이용하여 다른 관계도 그래프 그리기

install.packages('devtools')
install.packages('d3Network')
install.packages('RCurl')
library(devtools)
library(d3Network)

name <- c('Angela Bassett','Jessica Lange','Winona Ryder','Michelle Pfeiffer',
          'Whoopi Goldberg','Emma Thompson','Julia Roberts','Sharon Stone','Meryl Streep',
          'Susan Sarandon','Nicole Kidman')
pemp <- c('Angela Bassett','Angela Bassett','Jessica Lange','Winona Ryder','Winona Ryder',
          'Angela Bassett','Emma Thompson', 'Julia Roberts','Angela Bassettlibrary(RCurl)',
          'Meryl Streep','Susan Sarandon')
emp <- data.frame(이름=name,상사이름=pemp)
d3SimpleNetwork(emp,width=600,height=600,file="c:\\temp\\d3.html")

# 군집 분석

g <- read.csv("d:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part3/data/군집분석.csv", head=T)
str(g)
graph <- data.frame(학생=g$학생, 교수=g$교수); head(graph, 10)
g <- graph.data.frame(graph, directed=T)
plot(g, layout=layout.fruchterman.reingold, vertex.size=2, edge.arrow.size=0.5,
     vertex.color="green", vertex.label=NA)

# 모양 바꾸어서 출력하기
plot(g, layout=layout.kamada.kawai, vertex.size=2, edge.arrow.size=0.5, vertex.label=NA)

# 학생과 교수의 색상과 크기를 구분해서 출력하기
library(stringr)
V(g)$name
gubun1 <- V(g)$name; gubun1
gubun <- str_sub(gubun1, start=1, end=1); gubun

colors <- c()
sizes <- c()
for (i in 1:length(gubun)) {
  if (gubun[i] == 'S') {
    colors <- c(colors, 'red')
    sizes <- c(sizes, 2)
  } else {
    colors <- c(colors, 'green')
    sizes <- c(sizes, 6)
  }
}
plot(g, layout=layout.fruchterman.reingold, vertex.size=sizes, edge.arrow.size=0.5,
     vertex.color=colors)
plot(g, layout=layout.fruchterman.reingold, vertex.size=sizes, edge.arrow.size=0.5,
     vertex.color=colors, vertex.label=NA)
plot(g, layout=layout.fruchterman.reingold, vertex.size=sizes, edge.arrow.size=0,
     vertex.color=colors, vertex.label=NA)
plot(g, layout=layout.kamada.kawai, vertex.size=sizes, edge.arrow.size=0,
     vertex.color=colors, vertex.label=NA)

shapes <- c()
for (i in 1:length(gubun)) {
  if (gubun[i] == 'S') {
    shapes <- c(shapes, 'circle')
  } else {
    shapes <- c(shapes, 'square')
  }
}
plot(g, layout=layout.kamada.kawai, vertex.size=sizes, edge.arrow.size=0,
     vertex.color=colors, vertex.label=NA, vertex.shape=shapes)

# d3Network() 패키지로 메르스 환자 표시
library(devtools)
library(RCurl)
library(d3Network)
virus1 <- read.csv('d:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part3/data/메르스전염현황.csv', header=T)
d3SimpleNetwork(virus1, width = 600, height = 600, file = 'c:/temp/mers.html')
