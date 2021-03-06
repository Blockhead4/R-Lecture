# 미션 3-5. 전염병을 미리 막아 보자구요!

library(ggplot2)
library(reshape2)

# 데이터 불러오기
ydata <- read.csv("data/1군전염병발병현황_년도별.csv")
mdata <- read.csv("data/1군전염병발병현황_월별.csv")

# ggplot 사용을 위해 melt로 데이터 Long 형태로 변환
year <- melt(ydata, id="년도별", variable.name="병명", value.name="발병횟수")
month <- melt(mdata, id="월별", variable.name="병명", value.name="발병횟수")

# month 데이터의 월별 컬럼의 levels 다시 지정
month$월별 <- factor(month$월별, levels <- c("1월", "2월", "3월", "4월", "5월","6월", "7월", "8월", "9월", "10월", "11월", "12월"));
month$월별;

# 년도별 발병현황 그래프 출력
ggplot(year, aes(x=년도별, y=발병횟수, fill=병명, color=병명, group=병명)) + 
  geom_line(size=1) +
  geom_point(size=1.5) +
  geom_hline(yintercept = seq(0, 6000, 100), lty="dotted", color="black") +     # lty = linetype
  theme_light() +
  theme(panel.grid.major.x = element_line(linetype = "dotted", color="black"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  ggtitle("1군 전염병 발병현황-년도별(단위:건수) 출처:통계청") +
  theme(plot.title = element_text(face="bold", hjust = 0.5, size=14)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=8))

# 월별 발병현황 그래프 출력
ggplot(month, aes(x=월별, y=발병횟수, fill=병명, color=병명, group=병명)) + 
  geom_line(size=1) +
  geom_point(size=1.5) +
  geom_hline(yintercept = seq(0, 1500, 100), lty="dotted", color="black") +     # lty = linetype
  theme_light() +
  theme(panel.grid.major.x = element_line(linetype = "dotted", color="black"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  ggtitle("1군 전염병 발병현황-월별(단위:건수) 출처:통계청") +
  theme(plot.title = element_text(face="bold", hjust = 0.5, size=14)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=8))

# 년도별 A형 간염 제외 발생 현황
dayear <- melt(ydata[,-6], id="년도별", variable.name="병명", value.name="발병횟수")
dayear

ggplot(dayear, aes(x=년도별, y=발병횟수, fill=병명, color=병명, group=병명)) + 
  geom_line(size=1) +
  geom_point(size=1.5) +
  geom_hline(yintercept = seq(0, 1500, 100), lty="dotted", color="black") +     # lty = linetype
  theme_light() +
  theme(panel.grid.major.x = element_line(linetype = "dotted", color="black"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  ggtitle("1군 전염병 발병현황-년도별(단위:건수) 출처:통계청") +
  theme(plot.title = element_text(face="bold", hjust = 0.5, size=14)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1, color='black', size=8))


