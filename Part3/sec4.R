print(5 / 2)
print(5 %/% 2)    # 나눗셈의 몫
print(5 %% 2)     # 나눗셈의 나머지
print(5 ^ 2)
print(5 * 5)

1+2*3
(1+2)*3

10000
100000          # 십만부터 10의 승수로 표현
100000 + 100000
1 / 1000000
1 / 10000       # 만분의 1부터 10의 -승수로 표현
1 / 1000

'1' + '2'
as.numeric('1') + as.numeric('2')   # 문자열을 정수로 바꾸어 줌

'first'
"first"        # 문자열 작은 따옴표나 큰따옴표로 감싸야 출력 가능
first
first <- 1     # first에 값 1을 넣으면 fitst 입력시 1이 출력됨
first

class(1)       # 값이 어떤 형식(문자열, 숫자, 논리)인지 확인
class("1")
class(!0)

3 & 0    # and
3 & 4
1 | 0    # or
!0
!3
|2

cat(1, NA, 2)        # NA는 그대로 출력됨 (연산에 포함됨)
cat(1, NULL, 2)     # NULL은 출력되지 않음(연산 불포함)
sum(1, NA, 2)         # NA : 잘못된 값이 들어올 경우(Not Available, Not Applicable)
sum(1, NULL, 2)       # NULL : 값이 없을 경우

class(NA)
class(NULL)

setwd("d:/Workspace/R_Data_Analysis/Part3/data")
txt1 <- read.csv("factor_test.csv")
txt1

factor1 <- factor(txt1$blood)
factor1
gender1 <- factor(txt1$sex)
gender1

summary(factor1)
summary(gender1)
View(txt1)

stringsAsFactors=FALSE     # ???? 무슨 말인지 이해 못함

