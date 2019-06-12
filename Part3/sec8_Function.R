# Function

?subset()     # 함수에 관한 도움말 정보 보기
?read.csv.sql


# 기본 함수

vec1 <- c(1:5)
vec2 <- c('a','b','c','d','e')

max(vec1)    # 최대값
max(vec2)    # 최대값(문자열 가능)
mean(vec1)   # 평균값
mean(vec2)   # 평균값(문자열 불가능), NA로 반환
min(vec1)    # 최소값
sd(vec1)     # 표준편차
sum(vec1)    # 합계
var(vec1)    # 분산

library(googleVis)
Fruits


# aggregate() 함수

aggregate(Sales~Year,Fruits,sum)      # aggregate(계산될 칼럼 ~ 기준될 칼럼, 데이터, 함수) / Year별 Sales 합계
aggregate(Sales~Fruit,Fruits,sum)
aggregate(Sales~Year,Fruits,max)      # Year별 Sales 최대값
aggregate(Sales~Year,Fruits,min)
aggregate(Sales~Year,Fruits,mean)

aggregate(Sales~Year+Fruit,Fruits,max)      # '+ 추가조건' 형태로 조건을 추가 / Year, Fruit별 Sales 최대값


# apply() 함수

mat1 <- matrix(c(1:6),nrow=2,byrow=T); mat1

apply(mat1,1,sum)       # apply(범위대상, 행/열(1/2), 적용함수) / 각 행의 합계
apply(mat1,2,sum)       # 각 열의 합계
apply(mat1,1,prod)      # 각 행의 요소들의 곱
apply(mat1[,c(2,3)],1,sum)    # 2, 3열의 행 단위 합계
apply(mat1[,c(2,3)],2,sum)    # 2, 3열의 열 단위 합계


# lapply() 함수

list1 <- list(Fruits$Sales); list1
list2 <- list(Fruits$Profit); list2

# lapply / sapply(대상, 적용함수)
lapply(c(list1,list2),max)    # list1과 list2에서 max 값을 구해 list 형태로 출력
sapply(c(list1,list2),max)    # list1과 list2에서 max 값을 구해 vector 형태로 출력

Fruits
lapply(Fruits[,c(4,5)],max)   # 데이터 레이블이 표시되어 가시성이 좋음
sapply(Fruits[,c(4,5)],max)
apply(Fruits[,c(4,5)],2,max)


# tapply() / mapply() 함수

Fruits
# tapply(출력값, 기준컬럼, 적용함수) / mapply(함수, 벡터1, 벡터2, ...)
tapply(Sales, Fruits, sum)

attach(Fruits)      # attach()는 각 컬럼 이름을 '변수명'처럼 처리해서 데이터를 쉽게 관리하게 하는 기능
tapply(Sales, Fruit, sum)
tapply(Sales, Year, sum)

vec1 <- seq(1,5); vec1
vec2 <- seq(10,50,10); vec2
vec3 <- seq(100,500,100); vec3
mapply(sum, vec1, vec2, vec3) 

# sweep() 함수

mat1 <- matrix(seq(1,6,1),nrow=2,byrow=T); mat1
a <- rep(1,3); a
sweep(mat1,2,a)     # 1: 행 단위로 계산 / 2: 열 단위로 계산

b <- matrix(c(2,3)); b
sweep(mat1,1,b)


# length() 함수

library(googleVis)
a <- seq(1,6,1); length(a)   # 벡터의 길이 출력
mat1
length(mat1)       # 가로 * 세로 개수 출력
Fruits
length(Fruits)     # 데이터 프레임의 경우 열의 개수 출력

log(10)
log10(10)
sin(pi)


# abs() 함수

abs(1)       # 절대값 출력
abs(-1)
v1 <- c(1,-2,-3,4)
abs(v1)


# ceiling() / floor() / round() / choose() 함수

ceiling(2.2)     # 올림
floor(2.6)       # 내림
round(2.6)       # 반올림 (0.5 사용시 실수 표기법에 따라 조심해서 사용해야 함)
v2 <- c(1, 2.1, 1.7, 3, -2.3, -0.6)
ceiling(v2)
floor(v2)
round(v2)

choose(5,3)      # 5 combination 3: 5개 중에 3개를 뽑는 경우의 수


# 사용자 정의 함수

myfunct1 <- function(){         # fuction(입력받을 값, 입력받을 값, ...){함수 내용}
  return(10)
}
myfunct1()

myfunct2 <- function(x){
  y = x * x;
  return(y)
}
myfunct2(-3)

