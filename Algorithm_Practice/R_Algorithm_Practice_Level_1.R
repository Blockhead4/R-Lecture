# 알고리즘 Level 1
library(stringr)

# 1. 문자열 다루기 기본
# alpha_string46함수는 문자열 s를 매개변수로 입력받습니다. 
# s의 길이가 4혹은 6이고, 숫자로만 구성되있는지 확인해주는 함수를 완성하세요. 
# 예를들어 s가 “a234”이면 False를 리턴하고 “1234”라면 True를 리턴하면 됩니다

alpha_string46 <- function(s) {
  if((nchar(s) == 4 | nchar(s) == 6) & grepl("[A-Za-z]", s) == F) {
    return(T)
  } else {
    return(F)
  }
}
s <- 1234
s <- "a1234"
alpha_string46(s)


# 2. 문자열 내 p와 y의 개수
# numPY함수는 대문자와 소문자가 섞여있는 문자열 s를 매개변수로 입력받습니다.
# s에 ‘p’의 개수와 ‘y’의 개수를 비교해 같으면 True, 다르면 False를 리턴하도록 함수를 완성하세요. 
# ‘p’, ‘y’ 모두 하나도 없는 경우는 항상 True를 리턴합니다. 예를들어 s가 “pPoooyY”면 True를 리턴하고
# “Pyy”라면 False를 리턴합니다.

numPY <- function(s) {
  if(str_count(tolower(s), "p") == str_count(tolower(s), "y")) return(T)
  return(F)
}
numPY("YYYyyyppp")
numPY("YyYwedppP")


# 3. 삼각형 출력하기
# printTriangle 메소드는 양의 정수 num을 매개변수로 입력받습니다. 
# 다음을 참고해 *(별)로 높이가 num인 삼각형을 문자열로 리턴하는 printTriangle 
# 메소드를 완성하세요 printTriangle이 return하는 String은 개행문자(‘\n’)로 끝나야 합니다.

printTriangle <- function(num) {
  star <- c()
  for(i in 1:num) {
    star <- paste(star, "*")
    print(star)
  }
}
printTriangle(5)


# 4. 스트링을 숫자로 바꾸기 (java, python)
# strToInt 메소드는 String형 str을 매개변수로 받습니다. 
# str을 숫자로 변환한 결과를 반환하도록 strToInt를 완성하세요. 
# 예를들어 str이 “1234”이면 1234를 반환하고, “-1234”이면 -1234를 반환하면 됩니다.
# str은 부호(+,-)와 숫자로만 구성되어 있고, 잘못된 값이 입력되는 경우는 없습니다.

strToInt <- function(str) {
  return(as.numeric(str))
}
a <- strToInt("-1234")
a
class(a)


# 5. 행렬의 덧셈
# 행렬의 덧셈은 행과 열의 크기가 같은 두 행렬의 같은 행, 같은 열의 값을 
# 서로 더한 결과가 됩니다. 2개의 행렬을 입력받는 sumMatrix 함수를 완성하여 
# 행렬 덧셈의 결과를 반환해 주세요.

# 예를 들어 2x2 행렬인 A = ((1, 2), (2, 3)), B = ((3, 4), (5, 6)) 가 주어지면, 
# 같은 2x2 행렬인 ((4, 6), (7, 9))를 반환하면 됩니다. 
# (어떠한 행렬에도 대응하는 함수를 완성해주세요.)

sumMatrix <- function(a, b) {
  return(a+b)
}
a <- matrix(c(1:9), nrow=3, byrow=T); a
b <- matrix(c(2:10), nrow=3, byrow=T); b
sumMatrix(a, b)


# 6. 핸드폰 번호 가리기
# 별이는 헬로월드텔레콤에서 고지서를 보내는 일을 하고 있습니다. 
# 개인정보 보호를 위해 고객들의 전화번호는 맨 뒷자리 4자리를 제외한 나머지를 "*"으로 바꿔야 합니다.
# 전화번호를 문자열 s로 입력받는 hide_numbers함수를 완성해 별이를 도와주세요
# 예를들어 s가 "01033334444"면 "*******4444"를 리턴하고, "027778888"인 경우는 
# "*****8888"을 리턴하면 됩니다.

secureNum <- function(num) {
  hide <- c()
  for(i in 1:nchar(str_sub(num, end=-5))) {
    hide <- paste(hide, "*", sep="")
  }
  return(str_replace_all(num, str_sub(num, end=-5), hide))
}
a <- "0212341234"
secureNum(a)


# 7. x만큼 간격이 있는 n개의 숫자
# number_generator함수는 x와 n을 입력 받습니다. 2와 5를 입력 받으면 2부터 시작해서 
# 2씩 증가하는 숫자를 5개 가지는 리스트를 만들어서 리턴합니다. [2,4,6,8,10]
# 4와 3을 입력 받으면 4부터 시작해서 4씩 증가하는 숫자를 # 3개 가지는 리스트를 
# 만들어서 리턴합니다. [4,8,12]
# 이를 일반화 하면 x부터 시작해서 x씩 증가하는 숫자를 n개 가지는 리스트를 리턴하도록
# 함수 number_generator를 완성하면 됩니다.

number_generator <- function(x, n) {
  result <- c()
  for(i in 1:n) {
    result <- append(result, x*i)
  }
  return(result)
}
number_generator(4, 4)


# 8. 평균 구하기
# def average(list): 함수를 완성해서 매개변수 list의 평균값을 return하도록 
# 만들어 보세요. 어떠한 크기의 list가 와도 평균값을 구할 수 있어야 합니다.

def_average <- function(list) {
  return(mean(list))
}
list = c(3,2,5,20,10)
def_average(list)


# 9. 제일 작은 수 제거하기
# rm_small함수는 list타입 변수 mylist을 매개변수로 입력받습니다. 
# mylist 에서 가장 작은 수를 제거한 리스트를 리턴하고, mylist의 원소가 
# 1개 이하인 경우는 []를 리턴하는 함수를 완성하세요. 예를들어 mylist가 
# [4,3,2,1]인 경우는 [4,3,2]를 리턴 하고, [10, 8, 22]면 [10, 22]를 리턴 합니다.

rm_small <- function(mylist) {
  return(mylist[-grep(min(mylist), mylist)])
}
mylist <- c(10,22, 8)
rm_small(mylist)


# 10. 짝수와 홀수
# evenOrOdd 메소드는 int형 num을 매개변수로 받습니다. num이 짝수일 경우 
# “Even”을 반환하고 홀수인 경우 “Odd”를 반환하도록 evenOrOdd에 코드를 작성해 보세요.
# num은 0이상의 정수이며, num이 음수인 경우는 없습니다.

evenOrOdd <- function(num) {
  return(ifelse(num <= 0, "양의 정수를 입력하시오.",
                ifelse(num %% 2 == 0, "Even", "Odd")))
}
num <- 4
evenOrOdd(num)


# 11. 서울에서 김서방 찾기
# findKim 함수(메소드)는 String형 배열 seoul을 매개변수로 받습니다.
# seoul의 element중 “Kim”의 위치 x를 찾아, “김서방은 x에 있다”는 String을 반환하세요. 
# seoul에 “Kim”은 오직 한 번만 나타나며 잘못된 값이 입력되는 경우는 없습니다.

findKim <- function(seoul) {
  return(paste("김서방은 ", grep("Kim", seoul), "에 있다"))
}
seoul <- c("tod", "Kim", "kid")
findKim(seoul)


# 12. 정수 제곱근 판별하기
# nextSqaure함수는 정수 n을 매개변수로 입력받습니다. n이 임의의 정수 x의 제곱이라면
# x+1의 제곱을 리턴하고, n이 임의의 정수 x의 제곱이 아니라면 ‘no’을 리턴하는 함수를 완성하세요. 
# 예를들어 n이 121이라면 이는 정수 11의 제곱이므로 (11+1)의 제곱인 144를 리턴하고, 
# 3이라면 ‘no’을 리턴하면 됩니다.

nextSqaure <- function(n) {
  return(ifelse(ceiling(sqrt(n)) - sqrt(n) < 1e-10, (n+1)^2, "no"))
}
n <- 4
nextSqaure(n)


# 13. 자릿 수 더하기
# sum_digit함수는 자연수를 전달 받아서 숫자의 각 자릿수의 합을 구해서 return합니다.
# 예를들어 number = 123이면 1 + 2 + 3 = 6을 return하면 됩니다. sum_digit함수를 완성해보세요.

sum_digit <- function(num) {
  return(sum(as.numeric(unlist(strsplit(as.character(num), "")))))
}
num <- 123456
sum_digit(num)


# 14. 수박수박수박수박수박수?
# water_melon함수는 정수 n을 매개변수로 입력받습니다. 길이가 n이고, 
# 수박수박수…와 같은 패턴을 유지하는 문자열을 리턴하도록 함수를 완성하세요.
# 예를들어 n이 4이면 ‘수박수박’을 리턴하고 3이라면 ‘수박수’를 리턴하면 됩니다.

water_melon <- function(n) {
  result <- ""
  ifelse(n %% 2 == 0 , result <- str_dup("수박", as.integer(n/2)), 
         result <- paste("수", str_dup("박수", as.integer((n-1)/2)), sep=""))
  return(result)
}
water_melon(6)


# 15. 같은 숫자는 싫어
# no_continuous함수는 스트링 s를 매개변수로 입력받습니다.
# s의 글자들의 순서를 유지하면서, 글자들 중 연속적으로 나타나는 아이템은 
# 제거된 배열(파이썬은 list)을 리턴하도록 함수를 완성하세요. 
# 예를들어 다음과 같이 동작하면 됩니다.
# s가 ‘133303’이라면 [‘1’, ‘3’, ‘0’, ‘3’]를 리턴 s가 ‘47330’이라면 [4, 7, 3, 0]을 리턴

no_continuous <- function(s) {
  char <- unlist(strsplit(s, ""))
  result <- char[1]
  for(i in 1:(nchar(s)-1)) {
    if(char[i] != char[i+1]) {
      result <- append(result, char[i+1])
    }
  }
  return(result)
}
s <- "133303"
no_continuous(s)
a <- "47330"
no_continuous(a)


# 16. 문자열 내 마음대로 정렬하기
# strange_sort함수는 strings와 n이라는 매개변수를 받아들입니다. strings는 문자열로 
# 구성된 리스트인데, 각 문자열을 인덱스 n인 글자를 기준으로 정렬하면 됩니다.
# 예를들어 strings가 [“sun”, “bed”, “car”]이고 n이 1이면 각 단어의 인덱스 1인 문자 u, e ,a를
# 기준으로 정렬해야 하므로 결과는 [“car”, “bed”, “sun”]이 됩니다. strange_sort함수를 완성해 보세요.

strange_sort <- function(strings, n) {
  tmp <- data.frame(matrix(unlist(strsplit(strings, "")), nrow=length(strings), byrow=T))
  tmp <- tmp %>% mutate(arr = sort(tmp[,n]))
  tmp2 <- c()
  result <- c()
  for(i in 1:nrow(tmp)) {
    tmp2 <- rbind(tmp2, subset(tmp[,-4], tmp[,n] == levels(tmp[,n])[i]))
    char <- c()
    for(k in 1:length(tmp2[i,])) {
      char <- paste(char, tmp2[i,k], sep="")
      
    }
    result <- append(result, char)
  }
  return(result)
}
strings <- c("apaend", "abcd", "sikkf")
strange_sort(strings, 3)
strings <- c("sun", "bed", "car")
strange_sort(strings, 2)


# 17. 피보나치 수
# 피보나치 수는 F(0) = 0, F(1) = 1일 때, 2 이상의 n에 대하여 F(n) = F(n-1) + F(n-2) 가 
# 적용되는 점화식입니다. 2 이상의 n이 입력되었을 때, fibonacci 함수를 제작하여 n번째 피보나치 수를 
# 반환해 주세요. 예를 들어 n = 3이라면 2를 반환해주면 됩니다.

fibo <- function(n) {
  result <- c(0, 1)
  if(n > 2) {
    for(i in 3:n){
      result <- c(result, result[i-1] + result[i-2])
    }
  }
  return(result[n])
}
fibo(7)


# 18. 최대공약수와 최소공배수
# 두 수를 입력받아 두 수의 최대공약수와 최소공배수를 반환해주는 gcdlcm 함수를 완성해 보세요. 
# 배열의 맨 앞에 최대공약수, 그 다음 최소공배수를 넣어 반환하면 됩니다. 예를 들어 gcdlcm(3,12) 가
# 입력되면, [3, 12]를 반환해주면 됩니다.

gcdlcm <- function(a, b) {
  an  <- c()
  bn <- c()
  for(i in 1:a) { if(a %% i == 0) an <- append(an, i) }
  for(i in 1:b) { if(b %% i == 0) bn <- append(bn, i) }
  gcd <- ifelse(length(an) <= length(bn), max(subset(an, an %in% bn)), max(subset(bn, bn %in% an)))
  ad <- a/gcd
  bd <- b/gcd
  lcm <- ad*bd*gcd
  return(c(gcd, lcm))
}
a <- 18
b <- 24
gcdlcm(a, b)


# 19. 