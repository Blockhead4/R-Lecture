# 변수 배우기 

var1 <- "aaa"; var1
var2 <- 111; var2
var3 <- Sys.Date(); var3
var4 <- c("a","b","c"); var4     # 여러 건의 데이터를 한 번에 담기(배열)

111 -> var5 -> var6       # 오른쪽 화살표 방식은 권장되지 않음(비보편적인 코딩방식)
var5; var6
var7 <- var8 <- 222       # 연속으로 여러 변수에 값을 할당
var7; var8

string1 <- "Very Easy R Programing"; string1
string2 <- "I'm JWP"; string2
string3 <- 'He said, "I am single".'; string3
string4 <- "He said, \"I am single\"."; string4    # 백슬래쉬는 어떤 명령어의 효력을 상실시킴

comp <- c(1,"2"); comp     # 하나의 변수에 문자와 숫자가 동시에 담기면 숫자가 문자열로 인식됨(자동 형 변환)
class(comp)

num1 <- 1
num2 <- 2
num1 + num2

char1 <- "a"
num1 + char1      # 숫자와 문자의 산술연산은 불가능

seq1 <- 1:5; seq1         # 연속적인 숫자값을 할당
seq2 <- "a":"f"; seq2     # 문자는 연속적인 할당이 불가능

date1 <- seq(from=as.Date('2014-01-01'),to=as.Date('2014-01-31'),by=2); date1     # 날짜는 연속값 가능
class(date1)
date2 <- seq(from=as.Date('2014-01-01'),to=as.Date('2014-12-31'),by='month'); date2
date3 <- seq(from=as.Date('2014-01-01'),to=as.Date('2020-12-31'),by='year'); date3
date4 <- seq(from=as.Date('2014-01-01'),to=as.Date('2014-01-31'),by='day'); date4

objects()       # 생성된 변수들 확인
.hidden <- 3    # '.'으로 시작하는 변수는 숨김 변수
.hidden

str1 <- "Hi"; str1
rm(str1); str1  # 변수 삭제

ls()
rm(list=ls())   # 모든 변수 삭제(숨김 변수는 삭제되지 않음)
.hidden
rm(.hidden)
.hidden
objects()
