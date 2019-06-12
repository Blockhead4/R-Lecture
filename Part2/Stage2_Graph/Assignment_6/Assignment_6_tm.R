# Assingment 6 - tm 패키지 사용

# R. 연습문제 5. 한영 워드클라우드 및 그래프 그리기

# hiphop.txt 파일을 가지고 다음 문제를 해결하여 파워포인트 파일로 제출하시오.

# 1. 워드 클라우드 만들기
# 2. Top 10 단어에 대해서 원 그래프 만들기 (ggplot 사용할 것)
# 3. Top 10 단어에 대해서 막대 그래프 만들기 (ggplot 사용할 것)

install.packages("SnowballC")
library(SnowballC)
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

# 한글 데이터 명사 필터링
lyrics <- sapply(txt, extractNoun, USE.NAMES = F)
cdata <- unlist(lyrics)
lyrics <- str_replace_all(cdata, "[^[:alpha:]]", "")
lyrics <- Filter(function(x) {nchar(x) >= 2}, lyrics)
lyrics

# tm 패키지로 데이터 필터링
corp1 <- Corpus(VectorSource(unlist(lyrics)))
inspect(corp1)  
class(corp1)
 
corp2 <- tm_map(corp1, stripWhitespace)
corp2 <- tm_map(corp2, tolower)
corp2 <- tm_map(corp2, removeNumbers)
corp2 <- tm_map(corp2, removePunctuation)
corp2 <- tm_map(corp2, stemDocument)
class(corp2)
inspect(corp2)

# 매트릭스로 데이터 타입 변환
corp3 <- TermDocumentMatrix(corp2)
corp3

dtm <- as.matrix(corp3)
colnames(dtm)

freq1 <- sort(rowSums(dtm), decreasing = T)
head(freq1, 30)
freq2 <- sort(colSums(dtm), decreasing = T)
head(freq2, 30)

findFreqTerms(corp3, 5)

# wordcloud 그래프 출력
palete <- brewer.pal(10, 'Set3')
wordcloud(names(freq1), freq=freq1, scale=c(5, 0.3), min.freq = 4, 
          rot.per=0.25, random.order = F, random.color = T, colors=palete)
legend(0.2, 0.95, "Hip Hop 노래가사 HOT 단어", cex=1, fill=NA, border=NA, 
       bg="black", text.col = "yellow", text.font = 2, box.col = NA)

# Top 10 단어 데이터 생성
top10 <- head(freq1, 10)
top10
class(top10)

df_top10 <- as.data.frame(top10)
df_top10
ncol(df_top10)

df_top10 <- cbind(df_top10, rownames(df_top10))
df_top10
colnames(df_top10) <- c("Freq", "rev")
rownames(df_top10) <- c(1:nrow(df_top10))
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
