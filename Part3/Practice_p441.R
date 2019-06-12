# 반복문 연습 문제

# 1번 문제
# 2번문제
var1 <- read.csv('채소.txt', header = F); var1

# 3번 문제
i<-1
while (i <= nrow(var1)) {
  if (var1[i,] != '버섯') {
    print(var1[i,])
  }
  i <- i + 1
}

# 위 반복문 next 써서 해보기 
