# 조건문(if) 연습 문제

# 1번 문제
myf1 <- function(x) {
  # retrun(ifelse(x > 5 , 1, 0))       # 이런 형식으로 한 줄로도 코딩 가능
  if (x > 5) {
    return(1)
  }
  return(0)
}
myf1(6)
myf1(5)

# 2번 문제
myf2 <- function(x) {
  # return(ifelse(x > 0 , 1, 0))
  if (x > 0) {
    return(1)
  } else if(x < 0) {
    return(0)
  }
  print("양수나 음수를 입력하시오.")
}
myf2(2)
myf2(-2)
myf2(0)

# 3번 문제
myf3 <- function(x, y) {
  # return(ifelse(x > y, x -y, y - x))
  if (x > y) {
    return(x - y)
  } else if (x < y) {
    return(y - x)
  }
  print("첫번째 수와 두번째 수가 같습니다. 결과 값 : 0")
}
myf3(3,1)
myf3(2,8)
myf3(2,2)

# 4번 문제
myf4 <- function(x) {
  if (x < 0) {
    return(0)
  } else if (x >=1 & x <= 5) {
    return(1)
  } else if (x > 5) {
    return(10)  
  }
  return("0을 입력 하셨습니다.")
}
myf4(-2)
myf4(2)
myf4(7)
myf4(0)

# 5번 문제

myf5 <- function(x) {
  if (x == 'Y' | x == 'y') {
    return('Yes')
  }
  return('Not Yes')
}
ans <- scan(what="")

myf5(ans)
myf5('y')
myf5('Y')
myf5('a')
myf5(1)
