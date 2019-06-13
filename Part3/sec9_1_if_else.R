# 조건식

myAbs <- function(x) {
  if (x >= 0) {
    return(x)
  } else {
    return(-x)
  }
}
myAbs(-3.2)
myAbs(4.5)

myAbs2 <- function(x) {
  if (x >= 0) {
    return(x)
  }
  return(-x)
}
myAbs2(-3.2)

myF1 <- function(x) {
  if (x > 0) {
    return(x^2)
  }
  return(0)
}
myF1(4.4)
myF1(-1)
myF1(0)

myF2 <- function(x) {
  if (x > 0) {
    return(2 * x)
  } else if (x == 0) {
    return(0)
  } else {
    return(-2 * x)
  }
}
myF2(2.3)
myF2(0)
myF2(-1.3)

# 정수형 데이터 2차 방정식 근개수 판별 공식
myIntD <- function(a, b, c) {
  x <- (b^2 - 4*a*c)
  if (x > 0) {
    return("근이 2개임")
  } else if (x == 0) {
    return("근이 1개임")
  }
  return("근을 구할 수 없음")
}
myIntD(1,2,1)
myIntD(1,4,4)
myIntD(1,4,8)
myIntD(1,2.4,1.44)
myIntD(1.000000000001,-2.000000000001,1.000000000001)

# 실수형 데이터 2차정식 근 개수 판별 공식
myRealD <- function(a, b, c) {
  x <- (b^2 - 4*a*c)
  if (abs(x) < 1e-5) {    # 왼쪽과 같은 표현 방법을 꼭! 이해하고 숙지하기
    return(1)
  } else if (x > 0) {
    return(2)
  }
  return(0)
}

myRealD(1.000000000001,-2.000000000001,1.000000000001)
myRealD(1,2,1)
myRealD(1,4,4)
myRealD(1,4,8)
myRealD(1,2.4,1.44)

4*1.000000000001*1.000000000001               # 실수형 데이터 처리 방식 TEST
-2.000000000001*-2.000000000001
(-2.000000000001*-2.000000000001)-(4*1.000000000001*1.000000000001)
