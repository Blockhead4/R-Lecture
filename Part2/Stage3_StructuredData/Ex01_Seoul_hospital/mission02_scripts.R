# 미션 3-2. 얘들아....고민이 뭐니?

install.packages("XLConnect")
install.packages('readxl')

library(ggplot2)
library(reshape2)
library(XLConnect)
library(readxl)


# 각 데이터별 변수 생성
category1 <- matrix(c("남자", "여자",
                    "흡연", "음주",             
                    "중학생", "고등학생"),
                    nrow=2)
category1[,3]
category2 <- c("남자", "여자", "중학생", "고등학생", "대학생")
category2[2]

# 각 데이터별 목록명 생성
cname <- c("성별", "흡연여부", "교육수준")

# 각 데이터별 x축 label 생성
x <- c("항목", "연도(년)", "만족도", "피해 사유", "항목", "기업 종류")

# 각 데이터별 ggplot title 생성
title <- c("주요 고민거리",
           "흡연율 / 음주율",
           "학교 생활 만족도",
           "학교 폭력 사유",
           "직업 선택 요인",
           "직장 선호도")


# 원하는 데이터의 그래프를 출력해주는 함수 생성
plotf <- function(i) {
  i <- i + 1
  if(i <= 4) {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category1[,i-1])
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "범례"
    t <- title[i-1]
    xl <- x[i-1]
  } else if(i >= 6) {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category2)
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "범례"
    t <- title[i-1]
    xl <- x[i-1]
  } else {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category2[-5])
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "범례"
    t <- title[i-1]
    xl <- x[i-1]
  }
  
  gg <- ggplot(temp, aes(x=variable, y=value, fill=범례, color=범례)) +
    geom_bar(width=0.5, stat="identity", position = "dodge") +
    geom_text(aes(x=variable, y=value, label=paste(value,"%")), color="black", position = position_dodge(width=1)) +
    geom_hline(yintercept=seq(0, max(temp$value), max(temp$value)/10), linetype="dashed", color="skyblue") +
    theme_light() +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank()) +
    ggtitle(t) +
    theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) +
    theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=10)) +
    ylab("비율(%)") +
    xlab(xl)
  
  return(gg)
  
}

# 원하는 데이터의 그래프 출력
plotf(1)
plotf(2)
plotf(6)






# ***** 아래는 참고 ***** #

# 데이터 셋 받기

var <- c()
for(i in 2:7) {
  if(i <= 4) {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category1[,i-1])
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "구분"
    var <- paste("data", i, sep="")
    assign(var, temp)
  } else if(i >= 6) {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category2)
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "구분"
    var <- paste("data", i, sep="")
    assign(var, temp)
  } else {
    temp <- read_excel("data/청소년통계.xls", sheet = i, col_names = T, col_types = "numeric", na = "NA")
    temp <- as.data.frame(temp)
    temp <- cbind(temp, category2[-5])
    temp <- melt(temp, id=names(temp)[length(temp)])
    names(temp)[1] <- "구분"
    var <- paste("data", i, sep="")
    assign(var, temp)
  }
}