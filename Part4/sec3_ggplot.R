# 저 수준 작도 함수

var1 <- 1:5
plot(var1)
segments(2,2, 3,3)          # 좌표로 선 긋기
arrows(5,5, 4,4)            # 화살표 그리기
text(2,4, 'tables')         # 글자 쓰기
text(3,2,'테스트',srt=45)   # srt=값 : 텍스트 기울임
rect(1,4, 2,5)              # 사각형 그리기
title('This is TEST','SUB') # 제목 표시하기기



# ggplot()

install.packages('ggplot2')
library(ggplot2)

korean <- read.table('data/학생별국어성적_new.txt', header = T, sep = ',')
korean

# ggplot(dataframe, aes(x = x축 데이터, y = y축 데이터)) + geom 함수 ...
ggplot(korean, aes(x=이름, y=점수)) + geom_point()        # positional argument
ggplot(mapping = aes(x=이름, y=점수), data = korean) + geom_point()       # keyword argument (인자의 순서가 바뀌어도 상관 없음)

# geom_bar() 함수
ggplot(korean, aes(x=이름, y=점수)) + geom_bar(stat='identity')
ggplot(korean, aes(x=이름, y=점수)) + geom_bar(stat='identity', fill='green', color='red')

gg<- ggplot(korean, aes(x=이름, y=점수)) + geom_bar(stat='identity', fill='green', color='red')
gg + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, color = 'blue', size = 8))

score_kem <- read.csv('data/학생별과목별성적_국영수_new.csv', header = T)
score_kem

library(plyr)
library(dplyr)
sort_kem <- arrange(score_kem, 이름, 과목); sort_kem     # 이름순 > 과목순으로 정렬

# plyr 패키지 이용
sort_kem2 <- ddply(sort_kem, '이름', 
                   transform, 누적합계 = cumsum(점수))     # 이름을 기준으로 점수 누적합계를 구해 새로운 데이터 프레임을 만듬
sort_kem2

sort_kem3 <- ddply(sort_kem2, '이름', transform, 누적합계 = cumsum(점수), label = cumsum(점수)-0.5*점수)
sort_kem3

# dplyr 패키지 이용
sort_kem2 <- sort_kem %>%
  group_by(이름) %>%
  mutate(누적합계 = cumsum(점수))
sort_kem2

sort_kem3 <- sort_kem2 %>%
  group_by(이름) %>%
  mutate(label = cumsum(점수)-0.5*점수)
sort_kem3

sort_kem4 <- sort_kem %>%
  group_by(이름) %>%
  mutate(누적합계 = cumsum(점수), label = cumsum(점수)-0.5*점수)
sort_kem4

ggplot(sort_kem4, aes(x=이름, y=점수, fill=과목)) + geom_bar(stat='identity') +
  geom_text(aes(y=label, label=paste(점수,'점')), color='black', size=4)

gg2 <- ggplot(sort_kem4, aes(x=이름, y=점수, fill=과목)) + geom_bar(stat='identity') +
  geom_text(aes(y=label, label=paste(점수,'점')), color='black', size=4) +
  guides(fill=guide_legend(reverse = T))
gg2 + theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, color='black', size=8))

# geom_segment() 함수
score <- read.table('data/학생별전체성적_new.txt', header=T, sep=',')
score
score[,c('이름','영어')]

ggplot(score, aes(x=영어, y=reorder(이름,영어))) + 
  geom_segment(aes(yend=이름), xend=0, color='blue') +
  geom_point(size=6, color='green') +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color='red', linetype = 'dashed'))

ggplot(score, aes(x=영어, y=reorder(이름,영어))) + 
  geom_segment(aes(yend=이름), xend=0, color='blue') +
  geom_point(size=6, color='green') +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank())

# geom_point() 함수와 scatterplots
install.packages('gridExtra')
library(gridExtra)

mtcars
str(mtcars)

v_mt <- mtcars
graph1 <- ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point()
graph1
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point()
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(color='blue')
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(aes(color=factor(am), size=7))
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(aes(color=factor(am), size=wt))
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(aes(shape=factor(am), size=wt))
ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(aes(shape=factor(am), color=wt))
# 종류별로 크기, 모양, 색상 지정하기
ggplot(v_mt, aes(x=hp, y=mpg)) +         
  geom_point(aes(shape=factor(am), color=factor(am), size=wt)) +
  scale_color_manual(values=c('red','green'))     

ggplot(v_mt, aes(x=hp, y=mpg)) + geom_point(color='red') + geom_line(color='pink')

ggplot(v_mt, aes(x=hp, y=mpg)) +         
  geom_point(aes(shape=factor(am), color=factor(am), size=wt)) +
  scale_color_manual(values=c('red','green')) +
  labs(x='마력', y='연비(mile/gallon)')       # x축과 y축 이름 바꾸기

# geom_line() 함수
three <- read.csv('data/학생별과목별성적_3기_3명.csv')
three
sort_score <- arrange(three, 이름, 과목)
sort_score

ggplot(sort_score, aes(x=과목, y=점수, color=이름, group=이름)) + geom_line()
ggplot(sort_score, aes(x=과목, y=점수, color=이름, group=이름)) + geom_line() + geom_point()
ggplot(sort_score, aes(x=과목, y=점수, color=이름, group=이름)) + geom_line() + geom_point(size=6, shape=22)
ggplot(sort_score, aes(x=과목, y=점수, color=이름, group=이름, fill=이름)) + geom_line() + geom_point(size=6, shape=18)
ggplot(sort_score, aes(x=과목, y=점수, color=이름, group=이름, fill=이름)) + geom_line() + geom_point(size=6, shape=18) +
  ggtitle('학생별 과목별 성적') + theme(plot.title=element_text(hjust=0.5))

# geom_area() 함수
dis <- read.csv('data/1군전염병발병현황_년도별.csv', stringsAsFactors=F)
dis
str(dis)

ggplot(dis, aes(x=년도별, y=장티푸스, group=1)) + geom_line()
ggplot(dis, aes(x=년도별, y=장티푸스, group=1)) + geom_area()
ggplot(dis, aes(x=년도별, y=장티푸스, group=1)) + geom_area() + geom_point()
ggplot(dis, aes(x=년도별, y=장티푸스, group=1)) + 
  geom_area(fill='cyan', color='red', alpha=0.3) +  geom_line(color='blue')   # alpha : 투명도
