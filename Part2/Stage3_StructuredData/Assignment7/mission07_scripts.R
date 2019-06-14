# 미션 3-7. 마포09번 마을버스 이용 현황 분석

library(ggplot2)
library(reshape2)

# 데이터 불러오기
data <- read.csv("data/마포09번이용현황.csv", stringsAsFactors= F)
data
data$정류소명 <- paste(c(1:length(data$정류소명)), ".", data$정류소명, sep="")


# ggplot 사용을 위해 melt로 데이터 Long 형태로 변환
mdata <- melt(data, id="정류소명", variable.name="승하차구분", value.name="이용승객수")
mdata$정류소명 <- factor(mdata$정류소명, levels=unique(mdata$정류소명))    # factor로 바꿔주고 unique 로 수준 설정
mdata$정류소명 <- factor(mdata$정류소명)
mdata
unique(mdata$정류소명)
mdata$정류소명;


# 정류소별 이용승객수 그래프 출력
ggplot(mdata, aes(x=정류소명, y=이용승객수, group=승하차구분, color=승하차구분)) +
  geom_line(size=1) +
  geom_point(size=3, shape=1) +
  geom_hline(yintercept = seq(0, 40000, 1000), linetype="dotted") +
  theme_light() +
  theme(panel.grid.major.x = element_line(linetype = "dotted", color = "black"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  ggtitle("마포09번 이용 승객수(단위:명) - 2014년 1월 기준") +
  theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=1, size=10))

