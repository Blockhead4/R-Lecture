# 2-1 "제주도 여행코스 추천" 검색어 결과를 그래프로 표시하기

install.packages("KoNLP")
install.packages("wordcloud")
install.packages("stringr")
library(KoNLP)
library(wordcloud)
library(stringr)
library(RColorBrewer)
library(ggplot2)
library(dplyr)
useSejongDic()
mergeUserDic(data.frame(readLines("data/제주도여행지.txt"), "ncn"))

txt <- readLines('data/jeju.txt')
txt

place <- sapply(txt, extractNoun, USE.NAMES = F)
place
head(unlist(place), 30)

cdata <- unlist(place)
place <- str_replace_all(cdata, "[^[:alpha:]]", "")     # 한글, 영어 외에는 삭제
place <- gsub(" ", "", place)

txt <- readLines('data/제주도여행코스gsub.txt')
txt
for(i in 1:length(txt)) {
  place <- gsub((txt[i]), "", place)
}
place

place <- Filter(function(x) {nchar(x) >= 2}, place)

write(unlist(place), 'data/jeju_2.txt')
rev <- read.table('data/jeju_2.txt')
nrow(rev)
wordcount <- table(rev)    # table(data) : data 속 요소들의 빈도변수를 만들어 빈도수를 같이 출력
head(sort(wordcount, decreasing = T), 30)

# 가장 추천 수가 많은 상위 10개를 골라서 pie 그래프 출력
top10 <- head(sort(wordcount, decreasing = T), 10)
pie(top10, main="제주도 추천 여행 코스 TOP 10")

# 색상을 변경하여 출력
pal <- brewer.pal(10, 'RdGy')
pie(top10, col=pal, radius=1, main="제주도 추천 여행코스 TOP 10")

# 수치값을 함께 출력
pct <- round(top10/sum(top10)*100 ,1)
names(top10)
lab <- paste(names(top10),"\n",pct,"%")
pie(top10, col=rainbow(length(top10)), radius=1, main="제주도 추천 여행코스 TOP 10", cex=0.8, labels=lab)

# bar 그래프 출력
bchart <- head(sort(wordcount, decreasing = T), 10)
bchart
bp <- barplot(bchart, main="제주도 추천 여행코스 TOP 10", col=rainbow(length(bchart)), cex.names=0.7, las=2, ylim=c(0, 25))
pct <- round(bchart/sum(bchart)*100, 1)
pct
text(x=bp, y=bchart*1.05, labels = paste("(", pct ,"%", ")"), col="black", cex=0.7)
text(x=bp, y=bchart*0.95, labels = paste(bchart, "건"), col="black", cex=0.7)

# 옆으로 누운 bar 그래프 출력
barplot(bchart, main="제주도 추천 여행코스 TOP 10", col=rainbow(length(bchart)), xlim=c(0, 25), cex.names=0.7, las=1, horiz=T)
text(y=bp, x=bchart*0.9, labels = paste(bchart, "건"), col="black", cex=0.7)
text(y=bp, x=bchart*1.15, labels = paste("(", pct ,"%", ")"), col="black", cex=0.7)

# 3D Pie Chart 출력
# plotrix 패키치 필요
install.packages("plotrix")
library(plotrix)
th_pct <- round(bchart/sum(bchart)*100, 1)
th_names <- names(bchart)
th_labels <- paste(th_names, "\n", "(", th_pct, ")")

pie3D(bchart, main="제주도 추천 여행코스 TOP 10", col=rainbow(length(bchart)), cex=0.3, labels=th_labels, explode=0.05)


# ggplot bar & pie chart 출력
str(top10)
df_top10 <- as.data.frame(top10)
df_top10

ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) +
  geom_bar(width=1, stat='identity') +
  geom_text(aes(y=ypos, label=ylabel), color="black")

ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) +
  geom_bar(width=1, stat='identity') +
  coord_polar(theta = "y", start = 0) +
  geom_text(aes(y=ypos, label=ylabel), color="black")

# ggplot pie chart labels 추가하기
options(digits=2)

df_top10_2 <- df_top10 %>%
  mutate(pct = Freq/sum(Freq)*100) %>%
  mutate(ylabel = paste(sprintf("%s\n%4.1f", rev, pct), "%", sep="")) %>%     # sprintf 함수 이해하기 ??????????????
  arrange(desc(rev)) %>%
  mutate(ypos = cumsum(pct) - 0.5*pct)    # ypos : ylabel 위치 지정 변수 ( 만드는 과정이 왜 이렇게 되는지 ????????)
df_top10_2

df_top10_3 <- df_top10 %>%
  mutate(pct = Freq/sum(Freq)*100) %>%
  mutate(ylabel = paste(rev," (",format(pct, digit=2), "%) ", sep="")) %>%    # sprintf -> format으로 변경해도 가능
  arrange(desc(rev)) %>%
  mutate(ypos = cumsum(pct) - 0.5*pct)    
df_top10_3

# extrafont 패키지 : OS내에 설치되어 있는 폰트 사용하기
install.packages('extrafont')
library(extrafont)
windowsFonts()
windowsFonts(malgun = "맑은 고딕")
theme_update(text=element_text(family = "malgun"))

ggplot(df_top10_3, aes(x="", y=Freq, fill=rev)) +
  geom_bar(width=1, stat='identity') +
  geom_text(aes(y=ypos, label=ylabel), cex=4, color="black", family="malgun")

ggplot(df_top10_3, aes(x="", y=Freq, fill=rev)) +
  geom_bar(width=1, stat='identity') +
  coord_polar(theta = "y", start = 0) +
  geom_text(aes(y=ypos, label=ylabel), color="black", family="malgun")
