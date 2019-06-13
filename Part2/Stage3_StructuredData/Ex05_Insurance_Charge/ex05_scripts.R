# 예제 3-5. 년도별 기관별 보험청구 금액 현황 분석후 그래프로 보여주기

library(reshape2)

count <- read.csv("data/연도별요양기관별보험청구금액_2004_2013_세로.csv", stringsAsFactor = F)
count

count2 <- melt(count, id="년도", variable.name="병원종류", value.name="청구금액")
count2$청구금액 <- count2$청구금액/1000000
View(count2)

ggplot(count2, aes(x=년도, y=청구금액, fill=병원종류, color=병원종류)) +
  geom_line(size=0.6) +
  geom_point(size=1.5) +
  geom_hline(yintercept = seq(0,8000,1000), lty="dotted", color="black") +     # lty = linetype
  theme_light() +
  ggtitle(paste("연도별 요양 기관별 보험 청구 금액 현황(단위:백만원)","\n","출처:건강보험심사평가원")) +
  theme(plot.title = element_text(face="bold", hjust = 0.5, size=14)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=8))
