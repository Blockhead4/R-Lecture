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
printTriangle(3)


# 4. 스트링을 숫자로 바꾸기 (java, python)
# strToInt 메소드는 String형 str을 매개변수로 받습니다. 
# str을 숫자로 변환한 결과를 반환하도록 strToInt를 완성하세요. 
# 예를들어 str이 “1234”이면 1234를 반환하고, “-1234”이면 -1234를 반환하면 됩니다.
# str은 부호(+,-)와 숫자로만 구성되어 있고, 잘못된 값이 입력되는 경우는 없습니다.

strToInt <- function(str) {
  return(as.integer(str))
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


# 8. 