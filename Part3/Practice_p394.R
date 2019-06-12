# apply() 계열 연습 문제

# 1번 문제
data1 <- read.csv('data1.csv'); data1

apply(data1[,c(2:15)],2,sum)
apply(data1[,-1],1,sum)

# 2번 문제
# 2-1)
data2 <- read.csv('1-4호선승하차승객수.csv'); data2
attach(data2)

# 2-2)
tapply(승차,노선번호,sum)                   # aggregate(승차~노선번호,data2,sum)도 가능
tapply(하차,노선번호,sum)
apply(data2[,c(3,4)],2,sum)                 # sapply(data2[,c(3,4)],sum)도 가능
aggregate(승차+하차~노선번호,data2,sum)     # tapply(승차+하차,노선번호,sum)도 가능
aggregate(승차~노선번호,data2,sum)
aggregate(하차~노선번호,data2,sum)

