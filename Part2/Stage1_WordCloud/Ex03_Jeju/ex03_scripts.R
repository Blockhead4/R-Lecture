# 예제 1-3 제주도 추천 여행코스 찾기

setwd('D:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part2/Stage1_WordCloud/Ex03_Jeju')
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
useSejongDic()

mergeUserDic(data.frame(readLines('data/제주도여행지.txt'), 'ncn'))

txt <- readLines('data/jeju.txt')
txt
place <- sapply(txt, extractNoun, USE.NAMES = F)
place
head(unlist(place), 30)
cdata <- unlist(place)
place <- str_replace_all(cdata, "[^[:alpha:]]", "")     # 한글, 영어 외에는 삭제
length(place)
place <- gsub(' ', '', place)
length(place)
txt <- readLines('data/제주도여행코스gsub.txt')
txt
for(i in 1:length(txt)) {
  place <- gsub((txt[i]), '', place)
}
place
place <- Filter(function(x) {nchar(x) >= 2}, place)
write(unlist(place), 'data/jeju_2.txt')
rev <- read.table('data/jeju_2.txt')
nrow(rev)
typeof(rev)
wordcount <- table(rev)    # table(data) : data 속 요소들의 빈도변수를 만들어 빈도수를 같이 출력
wordcount
typeof(wordcount)
head(sort(wordcount, decreasing = T), 30)

palete <- brewer.pal(9, 'Set1')
wordcloud(names(wordcount), freq=wordcount, scale = c(5,1), rot.per = 0.25, 
          min.freq = 2, random.order = F, random.color = T, colors = palete)
legend(0.3, 1, '제주도 추천 여행 코스 분석', cex=0.8, fill=NA, border=NA, 
       bg='white', text.col='red', text.font=2, box.col='red')
