# Assingment 6

# R. 연습문제 5. 한영 워드클라우드 및 그래프 그리기
	
# hiphop.txt 파일을 가지고 다음 문제를 해결하여 파워포인트 파일로 제출하시오.

# 1. 워드 클라우드 만들기
# 2. Top 10 단어에 대해서 원 그래프 만들기 (ggplot 사용할 것)
# 3. Top 10 단어에 대해서 막대 그래프 만들기 (ggplot 사용할 것)

library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(dplyr)
library(ggplot2)
library(tm)
library(extrafont)
useSejongDic()

windowsFonts(myfont = "MD이솝체")
theme_update(text=element_text(family="myfont"))

# 텍스트 파일 불러오기
txt <- readLines("data/hiphop.txt")

# 데이터 필터링
lyrics <- sapply(txt, extractNoun, USE.NAMES = F)
cdata <- unlist(lyrics)
lyrics <- str_replace_all(cdata, "[^[:alpha:]]", "")
lyrics <- gsub(" ", "", lyrics)
lyrics <- Filter(function(x) {nchar(x) >= 2}, lyrics)
lyrics

# 필터링된 변수의 공백 데이터 제거
write(lyrics, "data/lyrics.txt")
rev <- read.table("data/lyrics.txt")
nrow(rev)

# 중복된 데이터의 빈도수 생성
wordcount <- table(rev)
head(sort(wordcount, decreasing = T), 100)

# wordcloud 출력
pal <- brewer.pal(9, 'Set1')
wordcloud(names(wordcount), freq=wordcount, scale=c(5, 0.5), rot.per = 0.25, 
          min.freq=5, random.order = F, random.color = T, colors = pal)
legend(0.2, 0.95, "Hip Hop 노래가사 HOT 단어", cex=1, fill=NA, border=NA, 
       bg="black", text.col = "yellow", text.font = 2, box.col = NA)

# Top 10 단어 데이터 생성
top10 <- head(sort(wordcount, decreasing = T), 10)
df_top10 <- as.data.frame(top10)
df_top10

# 레이블 변수 생성
options(digits=2)     # 소수점 첫째 자리까지만 출력하도록 지정

df_top10_2 <- df_top10 %>%
  mutate(pct = Freq/sum(Freq)*100) %>%
  mutate(ylabel_b = str_c(rev, " (", format(pct, digits=2), "%)")) %>%
  mutate(ylabel_p = str_c(rev, "\n (", format(pct, digits=2), "%)")) %>%
  arrange(desc(rev)) %>%
  mutate(ypos = cumsum(Freq) - 0.5*Freq)
df_top10_2

# ggplot Bar & Pie Chart 출력
# myfont = "MD이솝체" 미적용
ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) + 
  geom_bar(width = 1, stat="identity") +
  geom_text(aes(y=ypos, label=ylabel_b), cex=5, color="black") +
  ggtitle("Hip Hop 노래가사 HOT 단어")

ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) + 
  geom_bar(width = 1, stat="identity") +
  geom_text(aes(y=ypos, label=ylabel_p), cex=5, color="black") +
  coord_polar(theta="y", start=0) +
  ggtitle("Hip Hop 노래가사 HOT 단어")

# myfont = "MD이솝체" 적용
ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) + 
  geom_bar(width = 1, stat="identity") +
  geom_text(aes(y=ypos, label=ylabel_b), cex=5, color="black", family="myfont") +
  ggtitle("Hip Hop 노래가사 HOT 단어") +
  theme(plot.title=element_text(color='purple', size=rel(2), face="bold", hjust=0.5))

ggplot(df_top10_2, aes(x="", y=Freq, fill=rev)) + 
  geom_bar(width = 1, stat="identity") +
  geom_text(aes(y=ypos, label=ylabel_p), cex=5, color="white", family="myfont") +
  coord_polar(theta="y", start=0) +
  ggtitle("Hip Hop 노래가사 HOT 단어") +
  theme(plot.title=element_text(color='purple', size=rel(2), face="bold", hjust=0.5))

