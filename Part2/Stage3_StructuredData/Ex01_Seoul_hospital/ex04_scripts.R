# 예제 3-4. 연도별 기관별 보험청구 건수 분석 후 그래프로 보여주기

count <- read.csv("data/연도별요양기관별보험청구건수_2001_2013_세로.csv", stringsAsFactors = F)
colname <- count$년도
count

#v1 <- count[,2]/100000
#v2 <- count[,3]/100000
#v3 <- count[,4]/100000
#v4 <- count[,5]/100000
#v5 <- count[,6]/100000
#v6 <- count[,7]/100000
#v7 <- count[,8]/100000
#v8 <- count[,9]/100000
#v9 <- count[,10]/100000
#v10 <- count[,11]/100000

length(count)
paste("v",1,sep="")

# 변수 여러개 한꺼번에 생성해서 value 넣기
#for(i in 1:(length(count)-1)) {
#  vset <- paste("b",i,sep="")
#  assign(vset, count[,i+1]/100000)
#}

# matrix로 변수 여러개 생성해서 value 넣기
mat <- c()
for(i in 1:(length(count)-1)) {
  mat <- rbind(mat, count[,i+1]/100000)
}
mat

plot(mat[1,], xlab="", ylab="", ylim=c(0,6000), axes=F, col="violet", type="o", lwd=2, 
     main=paste("연도별 요양 기관별 보험 청구 건수(단위:십만건)", "\n", "출처:건강보험심사평가원"))

axis(1, at=1:10, label=colname, las=2)
axis(2, las=1)     

#lines(v2, col="blue", type="o", lwd=2)
#lines(v3, col="red", type="o", lwd=2)
#lines(v4, col="black", type="o", lwd=2)
#lines(v5, col="orange", type="o", lwd=2)
#lines(v6, col="green", type="o", lwd=2)
#lines(v7, col="cyan", type="o", lwd=2)
#lines(v8, col="yellow", type="o", lwd=2)
#lines(v9, col="brown", type="o", lwd=2)
#lines(v10, col="pink", type="o", lwd=2)

colors <- c("blue", "red", "black", "orange", "green", "cyan", "yellow", "brown", "pink")
length(colors)

for(i in 2:nrow(mat)) {
  lines(mat[i,], col=colors[i-1], type = "o", lwd=2)
}

# ggolot으로 변환하기
count2 <- melt(count, id="년도", variable.name="병원종류", value.name="건수")
count2
count2$건수 <- count2$건수/100000

ggplot(count2, aes(x=년도, y=건수, fill=병원종류, color=병원종류)) + 
  geom_line(linetype=1, size=1) +
  geom_point(size=3) +
  geom_hline(yintercept = seq(0,5000,500), linetype="dashed", color="skyblue") +
  ggtitle(paste("연도별 요양기관별 보험청구건수 2001 - 2013 (단위:십만건)", "\n","출처:건강보험심사평가원")) +
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=14)) +
  theme_light() +
  theme(panel.grid.major.x = element_line(color="red", linetype = "dashed"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="red", linetype = "dashed"))


