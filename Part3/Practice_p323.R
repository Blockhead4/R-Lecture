# Vector형 연습문제

# 1번 문제
date4 <- seq(as.Date('2015-1-1'),as.Date('2015-1-31'),1); date4
seq(from=as.Date('2015-1-1'),to=as.Date('2015-1-31'),by=1)

# 2번 문제
vec1 <- c('사과','배','감','버섯','고구마'); vec1
vec1[-3]

# 3번 문제
vec1 <- c('봄','여름','가을','겨울')
vec2 <- c('봄','여름','늦여름','초가을')

union(vec1,vec2)
setdiff(vec1,vec2)
intersect(vec1,vec2)