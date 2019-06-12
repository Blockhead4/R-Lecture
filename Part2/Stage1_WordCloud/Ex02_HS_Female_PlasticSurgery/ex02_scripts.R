# 예제 1-2 여고생은 어디를 가장 고치고 싶을까요?

setwd('D:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part2/Stage1_WordCloud/Ex02_HS_Female_PlasticSurgery')
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
useSejongDic()

data1 <- readLines('data/remake.txt')
data1      # 파일에서 읽은 원시 데이터
data2 <- sapply(data1, extractNoun, USE.NAMES = F)
data2      # 리스트 형태의 명사만 추출된 데이터
data3 <- unlist(data2)
data3      # 명사만 추출된 데이터
data3 <- Filter(function(x) {nchar(x) <= 10}, data3)
length(data3)      # 10 글자보다 큰 문자는 제외된 데이터
head(unlist(data3), 30)

data3 <- gsub('\\d+', '', data3)
data3 <- gsub('쌍수', '쌍꺼풀', data3)
data3 <- gsub('쌍커풀', '쌍꺼풀', data3)
data3 <- gsub('메부리코', '매부리코', data3)
data3 <- gsub('\\.', '', data3)
data3 <- gsub(' ', '', data3)
data3 <- gsub("\\'", '', data3)

txt <- readLines('data/성형gsub.txt')
txt
typeof(txt)
class(txt)
for(i in 1:length(txt)) {
  data3 <- gsub((txt[i]), '', data3)
}
data3

data3 <- gsub('적', '', data3)
data3 <- gsub('개', '', data3)
data3 <- gsub('수', '', data3)
data3 <- gsub('술', '', data3)
data3 <- gsub('때', '', data3)
data3 <- gsub('넣치', '', data3)
data3 <- gsub('&', '', data3)
data3 <- gsub('것', '', data3)
data3 <- gsub('한', '', data3)
data3 <- gsub('시', '', data3)
data3 <- gsub('후', '', data3)

write(unlist(data3), 'data/remake_2.txt')
data4 <- read.table('data/remake_2.txt')
data4
nrow(data4)

wordcount <- table(data4)
wordcount
head(sort(wordcount, decreasing = T), 30)
palete <- brewer.pal(9, 'Set3')
palete
wordcloud(names(wordcount), freq=wordcount, scale=c(5,1), rot.per = 0.25, 
          min.freq = 2, random.order = F, random.color = T, colors =palete)
legend(0.3, 1, '여고생들이 선호하는 성형수술 부위', cex=0.8, fill=NA, border=NA, 
       bg='white', text.col='red', text.font=2, box.col='red')
