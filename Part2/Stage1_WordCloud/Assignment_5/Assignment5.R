# Assignment 5

# 서울시 응답소 2015년 데이터에서 중요한 키워드를 찾아 워드 클라우드를 만드시오.

# 단, 다음의 조건을 충족시켜야 함.
# 1. 제거해야할 단어를 저장한 gsub 파일을 만들 것
# 2. stringr 패키지를 사용할 것
# 3. R Markdown 보고서를 만들어서 제출할 것

#install.packages('rJava')
#install.packages('KoNLP')
#install.packages('wordcloud')
#install.packages('stringr')
library(rJava)
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
useSejongDic()

setwd('D:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part2/Stage1_WordCloud/Assignment')    # working directory 지정

src_dir <- 'data'; src_dir   # 데이터 파일이 있는 폴더 경로 저장
src_file <- list.files(src_dir); src_file    # 파일 이름 저장
src_file_cnt <- length(src_file); src_file_cnt     # 파일 개수 저장


dataset <- c()     # 파일 한꺼번에 dataset변수에 로딩
for(i in 1:src_file_cnt) {
  dataset <- rbind(dataset, readLines(str_c(src_dir,"/",src_file[i])))
}

response <- sapply(dataset, extractNoun, USE.NAMES = F)
head(unlist(response), 20)

cdata <- unlist(response)
response <- str_replace_all(cdata, "[^[:alpha:]]", "")    # 한글, 영어 제외 전부 삭제

response <- gsub(" ", "", response)
response <- gsub("\\d+", "", response)                    # 숫자형 데이터 전부 삭제
head(unlist(response), 30)
response

write(unlist(response), 'response.txt')     # 공백 데이터를 제거하기 위해 저장 후 리로딩
rev <- read.table('response.txt')
rev

wordcount <- table(rev)                       
head(sort(wordcount, decreasing = T), 100)    # gsuv 데이터를 만들기 위해 wordcount 빈도 확인

response <- Filter(function(x) {nchar(x) >= 2}, response)     # 데이터의 글자 길이가 2이상인 것만 저장
response
# wordcount를 보고 response_gsub.txt 파일 생성

txt <- readLines('response_gsub.txt')     # gsub데이터로 쓸데없는 데이터 제거
txt
for(i in 1:length(txt)) {
  response <- gsub((txt[i]), "", response)
}
response

response <- gsub("시장", "", response)      # gsub로 해결하지 못한 쓸데없는 데이터 추가 제거
response <- gsub("제목", "", response)
response <- gsub("저희", "", response)
response <- gsub("내용", "", response)
response <- gsub("관련", "", response)
response <- gsub("지역", "", response)
response <- gsub("Sh", "", response)

write(unlist(response), 'response_2.txt')     # 빈 공백 제거를 위한 저장 후 리로딩
rev_2 <- read.table('response_2.txt')
nrow(rev_2)
wordcount_2 <- table(rev_2)
head(sort(wordcount_2, decreasing = T), 300)

palete <- brewer.pal(9, 'Set3')
wordcloud(names(wordcount_2), freq=wordcount_2, scale = c(5,1), rot.per = 0.25, 
          min.freq = 2, random.order = F, random.color = T, colors = palete)
legend(0.3, 1, '2015년 서울시 응답소 키워드', cex=1, fill=NA, border=NA, 
       bg='white', text.col='blue', text.font=2, box.col='blue')
