# 반복문

# while 문(좀 더 일반적인 경우) / for 문

no <- 0
while (no < 5) {
  print(no)
  no <- no + 1
}

x <- 1
while (x < 5) {
  x <- x + 1
  if (x == 4)
    break
  print(x)
}
while (x < 5) { x <- x + 1; if (x == 4) break; print(x); }    # 한 줄로 표현

n <- -1
while (n <= 10) {
  n <- n + 1
  if (n %% 2 == 1)
    next
  print(n)
}

n <- 1

while (n <= 10) {
  if (10 %% n == 0)
    print(n)
  n <- n + 1
}

# 약수 찾기 - while 문
fn <- function(n) {
  i = 0
  while (i <= n) {
    i <- i + 1
    if (n %% i== 0)
      print(i)
  }
}
fn(12)

# 약수 찾기 - for 문
getDenominator <- function(x) {
  den <- c(1) 
  if (x >= 2) {
    for (i in 2:x) {
      if (x %% i ==0)
        den <- c(den, i)
    }
  }
  return(den)
}
getDenominator(10)


# for ( 변수 in 초기 값 : 끝나는 값 ) / for ( 변수 in seq( 초기 값, 끝나는 값, 증가분 )) / for (i in c(1,7,20,...))도 가능

for (i in 1:10) {
  print(i)
}
for (i in 1:10) print(i)

sum <- 0
for (i in 1:100) {
  sum <- sum + i
}
print(sum)

sum <- 0
for (i in seq(3, 100, 3)) {
  sum = sum + i
}
print(sum)

sum<-0
for (i in seq(1, 0, 1)) {
  sum = sum + i
}
print(sum)

for (i in c(1,3,5,7,100)) {
  print(i)
}

fn1 = function(limit, num) {
  sum = 0
  for (i in 1:limit) {
    if (i %% num == 0)
      sum = sum + i
  }
  return(sum)
}
fn1(1000, 3)
fn1(1000, 5)

fn2 <- function(n) {
  for (i in 1:(n/3)*3) {
      print(i)
  }
}
fn2(10)



library(stringr)

for (i in 1:5) {
  line <- ''
  for (k in 1:i) {
    line <- str_c(line, '#')
  }
  print(line)
}

for (i in 5:1) {
  line <- ''
  for (k in 1:i) {
    line <- str_c(line, '#')
  }
  print(line)
}


# 삼각형 거꾸로 그리기 --- 이해 요망 ---
for (i in 1:5) {
  line <- ''
  if (i != 1) {
    for (k in 1:(i-1)) {
      line <- str_c(line, ' ')
    }
  }
  for (k in i:5) {
    line <- str_c(line, '#')
  }
  print(line)
}
##


# 약간 기울어진 마름모 그리기
for (i in 1:9) {
  line <- ''
  if (i <= 5) {
    for (k in 1:i) {
      line <- str_c(line, '#')
    }
    print(line)
  } else {
    for (k in 5:(i-1)) {
      line <- str_c(line, ' ')
    }
    for (k in i:9) {
      line <- str_c(line, '#')
    }
    print(line)
  }
}

# 다이아몬드 그리기
for (i in 1:7) {
  line <- ''
  if (i < 4) {
    for (k in (4-i):1) {
      line <- str_c(line, ' ')
    }
    for (k in 1:(i*2-1)) {
      line <- str_c(line, '#')
    }
    print(line)
  } else if (i > 4) {
    for (k in 5:i) {
      line <- str_c(line, ' ')
    }
    for (k in ((10-i)*2-1):5) {
      line <- str_c(line, '#')
    }
    print(line)
  } else {
    line <- str_c(line, '#######')
    print(line)
  }
}


# 좀 더 짧게 만들기 : i != 4 이용
for (i in 1:7) {
  line <- ''
  if (i < 4) {
    for (k in (4-i):1) {
      line <- str_c(line, ' ')
    }
    for (k in 1:(i*2-1)) {
      line <- str_c(line, '#')
    }
    print(line)
  } else if (i > 4) {
    for (k in 5:i) {
      line <- str_c(line, ' ')
    }
    for (k in ((10-i)*2-1):5) {
      line <- str_c(line, '#')
    }
    print(line)
  } else {
    line <- str_c(line, '#######')
    print(line)
  }
}





str_c(line, '#', '#')
print(line)








## 구구단

for (i in 2:9) {
  cat(i, '단', '\n')
  for(k in 1:9) {
    cat(i, " * ", k, " = ", i*k , '\n')
  }
  cat('\n')
}
