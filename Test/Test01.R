# Test 1
library(dplyr)
library(ggplot2)

# 1. 다음의 문장을 좀더 효율적으로 개선하시오.

# 1) vec1 <- c(1, 2, 3, 4, 5, 6)
vec1 <- c(1:6); vec1

# 2) vec2 <- c(10, 9, 8, 7, 6, 5)
vec2 <- c(10:5); vec2

# 3) vec3 <- c(1, 1, 2, 2, 3, 3)
vec3 <- rep(1:3, each=2); vec3

# 4) vec4 <- c(1, 2, 3, 1, 2, 3)
vec4 <- rep(1:3, 2); vec4

# 5) vec5 <- c(1, 3, 5, 7, 9, 11)
vec5 <- seq(1, 11, 2); vec5


# 2. 다음과 같이 네 명의 학생이 중간 시험과 기말 시험을 봤다.

# 1) 위 자료를 데이터 프레임으로 만들어 df_score 라는 변수에 할당하시오.

v1 <- c("강경학", "김태균", "이성열", "정은원")
v2 <- c(90, 78, 94, 70)
v3 <- c(50, 60, 90, 92)
df_score <- data.frame(이름=v1, 중간=v2, 기말=v3)
df_score

# 2) 위 자료에 평균이라는 필드를 추가하고 중간과 기말 시험의 평균을 구해서 평균이라는 필드에 할당하시오.

df_score$평균 <- NA
for(i in 1:nrow(df_score)) {df_score$평균[i] <- mean(c(df_score$중간[i], df_score$기말[i]))}
df_score

df_score <- df_score %>% mutate(평균=(df_score$중간+df_score$기말)/2)
df_score

# 3. 2번 문제에 학점이라는 필드를 만들고, 평균 성적에 따라 학점을 부여하시오.
df_score$학점 <- ""
for(i in 1:nrow(df_score)) {
  if(df_score$평균[i] >= 90){
    df_score$학점[i] <- "A"
  } else if(df_score$평균[i] >= 80){
    df_score$학점[i] <- "B"
  } else if(df_score$평균[i] >= 70){
    df_score$학점[i] <- "C"
  } else if(df_score$평균[i] >= 60){
    df_score$학점[i] <- "D"
  } else {
    df_score$학점[i] <- "F"
  }
}

df_score %>%
  mutate(학점 = ifelse(df_score$평균 >= 90, "A",
                ifelse(df_score$평균 >= 80, "B",
                ifelse(df_score$평균 >= 70, "C",
                ifelse(df_score$평균 >= 60, "D", "F")))))


# 4. 양의 정수를 매개변수로 받아 1에서부터 매개변수 값까지 홀수를 더해서 그 결과를 리턴하는 함수 oddSum을 작성하고,
#    oddSum(100)의 값을 계산해 보시오.

oddSum <- function(num) {
  sum <- 0
  for(i in 1:num) {
    if(i %% 2 == 1) {
      sum <- sum + i
    }
  }
  return(sum)
}
oddSum(100)

oddSum <- function(num) {
  sum <- 0
  for(i in seq(1, num, 2)) {
      sum <- sum + i
  }
  return(sum)
}
oddSum(100)


# 5. R 내장 데이터인 "iris"를 이용하여 다음을 구하시오.

# 1) "setosa" 종 Sepal.Width의 Box Plot을 그려 이상치를 확인할 것
data1 <- select(subset(iris, Species == "setosa"), Sepal.Width)
data1
boxplot(data1, col="pink", main="Setosa - Sepal.Width Box Plot")    # boxplot, geom_boxplot 의 차이점이 뭘까? 왜 다른 결과가 나오는지??
ggplot(data1, aes(x="", y=Sepal.Width)) +
  stat_boxplot(geom = "errorbar", width=0.5) +
  geom_boxplot()

# 2) 이상치를 제거하기 전과 후의 평균과 표준편차
data2 <- as.data.frame(c(mean(data1$Sepal.Width), sd(data1$Sepal.Width)))

for(i in 1:nrow(data1)) {
  if(data1[i,] < 2.5) print(i)
}
rdata1 <- data1[-42,]
data3 <- as.data.frame(c(mean(rdata1), sd(rdata1)))
colnames(data2) <- "이상치 제거 전"
rownames(data2) <- c("평균", "표준편차")
colnames(data3) <- "이상치 제거 후"
rownames(data3) <- c("평균", "표준편차")

data2
data3

# 6. R 내장 데이터인 "mpg"를 이용하여 다음을 구하시오.
#    toyota에서 제작한 모델 중 시내주행연비(cty)와 고속도로주행연비(hwy)의 
#    산술평균이 가장 좋은 3가지 모델과 평균연비

top3 <- mpg %>%
  filter(manufacturer=="toyota") %>%
  group_by(manufacturer, model) %>%
  mutate(average=(cty+hwy)/2) %>%
  summarise(avg = mean(average)) %>%
  arrange(desc(avg)) %>%
  head(10)
top3


# 7. R 내장 데이터인 "mpg를 이용하여 다음의 그래프를 그리시오.

# 1) SUV 자동차의 시내 연비가 높은 7개 회사와 시내 연비
# 2) 막대 그래프 형식의 컬러 그래프

suv7 <- mpg %>%
  filter(class=="suv") %>%
  group_by(manufacturer) %>%
  summarise(average_cty=mean(cty)) %>%
  arrange(desc(average_cty)) %>%
  head(7)
suv7
  
ggplot(suv7, aes(x=reorder(manufacturer, -average_cty), 
                 y=average_cty, fill=manufacturer)) + 
  geom_bar(stat="identity") +
  theme_light() +
  ggtitle("시내연비 TOP7 SUV Manufacturer") +
  theme(plot.title = element_text(hjust=0.5, face="bold", size=14)) +
  theme(axis.text.x = element_text(hjust=1, vjust=1, size=10))


# 8. R 내장 데이터인 "diamonds"를 이용하여 다음의 그래프를 그리시오.

# 1) clarity 의 돗수를 보여주는 그래프
d <- diamonds %>%
  group_by(clarity) %>%
  summarise(count = n()) %>%
  arrange(count)
d

ggplot(d, aes(x=clarity, y=count, fill=clarity)) + geom_histogram(stat="identity", position = "dodge") +
  theme_light() +
  ggtitle("clarity") +
  theme(plot.title = element_text(hjust=0.5, face="bold", size=14))

# 2) clarity에 따른 가격의 변화를 보여주는 그래프
d2 <- diamonds %>%
  group_by(clarity) %>%
  summarise(average_price = mean(price)) %>%
  arrange(average_price)
d2

ggplot(d2, aes(x=clarity, y=average_price, fill=clarity)) + geom_histogram(stat="identity", position = "dodge") +
  theme_light() +
  ggtitle("clarity * price") +
  theme(plot.title = element_text(hjust=0.5, face="bold", size=14))


# 9. 실습 데이터 중 야구성적.csv 파일을 이용하여 다음의 그래프를 그리시오.

# 1) OPS(출루율+장타율)와 연봉대비 OPS(OPS/연봉*100)를 구하시오
b <- read.csv("data/야구성적.csv")
b1 <- b %>%
  mutate(OPS = 출루율+장타율) %>%
  mutate(연봉대비OPS = OPS/연봉*100) 
# mutate(OPS = 출루율+장타율, 연봉대비OPS = OPS/연봉*100)
select(b1, 선수명, OPS, 연봉대비OPS)

# 2) 연봉대비OPS를 선수별로 비교할 수 있는 막대그래프
ggplot(b1, aes(x=선수명, y=연봉대비OPS, fill=선수명)) + geom_bar(stat="identity") +
  theme_light() +
  ggtitle("선수별 연봉대비OPS") +
  theme(plot.title = element_text(hjust=0.5, face="bold", size=14)) +
  theme(axis.text.x = element_text(hjust=1, vjust=1, angle = 45, size=10))


# 10. 과제 점수 