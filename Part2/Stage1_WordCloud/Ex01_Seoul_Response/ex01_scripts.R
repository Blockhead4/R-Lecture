# Word_Cloud


# 예제 1-1. 서울시 응답소 페이지 분석하기

# 비정형 데이터 분석 후 워드클라우드 생성하기

setwd('d:/Workspace-JWP/R_Data_Analysis/R-Lecture/Part2/Stage1_WordCloud/Ex01_Seoul_Response')

#install.packages('rJava')
#install.packages('KoNLP')      # 한국어 작업을 할 때 꼭 필요한 패키지
#install.packages('wordcloud')
library(rJava)
library(KoNLP)
library(wordcloud)
library(RColorBrewer)

useSejongDic()     # 한글이 저장되어 있는 세종사전을 사용함을 알려줌
# > mergeUserDic(data.frame('서진수,', 'ncn'))     # 임의로 사전에 내 사전에 등록하는 방법

data1 <- readLines('data/seoul_new.txt')
data1     # 파일에서 읽은 Raw Data(한글 문장)

?extractNoun
extractNoun('서울시 버스정책을 위반하는 행위를 고발합니다.')     # 한글의 명사를 추출하는 함수

data2 <- sapply(data1, extractNoun, USE.NAMES = F)
head(data2)    # 명사들만 있는 데이터(List 형태)

head(unlist(data2), 30)
data3 <- unlist(data2)
head(data3)    # 리스트 형태가 아닌 명사 데이터

# gsub('변경전 글자', '변경 후 글자', 원본 데이터)
data3 <- gsub('\\d+', '', data3)
data3 <- gsub('서울시', '', data3)
data3 <- gsub('서울', '', data3)
data3 <- gsub('요청', '', data3)
data3 <- gsub('제안', '', data3)
data3 <- gsub(' ', '', data3)
data3 <- gsub('-', '', data3)
View(data3)
data3

# data3 안의 빈 문자열 데이터를 제거하는 방법 : 파일로 저장하고 테이블로 다시 불러오기
write(unlist(data3), 'data/seoul_2.txt')    
data4 <- read.table('data/seoul_2.txt')
head(data4)
nrow(data4)

wordcount <- table(data4)     # 중복되는 단어가 몇개 있는지 셀 수 있는 형태
View(wordcount)
head(sort(wordcount, decreasing = T), 20)

data3 <- gsub('OO', '', data3)
data3 <- gsub('개선', '', data3)
data3 <- gsub('문제', '', data3)
data3 <- gsub('관리', '', data3)
data3 <- gsub('민원', '', data3)
data3 <- gsub('이용', '', data3)
data3 <- gsub('관련', '', data3)
data3 <- gsub('시장', '', data3)
data3 <- gsub('님', '', data3)
data3 <- gsub('한', '', data3)

#=======================================================================#
# Tip : gsub() 반복문으로 해결하기
# txt파일을 하나 만들어 그 안에 제거하고 싶은 문자열들을 입력
# txt <- readLines('sample.txt')
# txt
# cnt_txt <- length(txt)
# cnt_txt
# for(i in 1:cnt_txt) {
#    data3 <- gsub(txt[i], '', data3)
# }
# data3    # 모든 txt파일의 문자열이 제거된 데이터
#=======================================================================#

write(unlist(data3), 'data/seoul_3.txt')
data4 <- read.table('data/seoul_3.txt')
wordcount <- table(data4)
View(wordcount)
head(sort(wordcount, decreasing = T), 20)

palete <- brewer.pal(9, 'Set3')
palete

wordcloud(names(wordcount), freq=wordcount, scale=c(5,1), rot.per = 0.25, 
          min.freq = 1, random.order = F, random.color = T, colors = palete)
legend(0.3, 1, '서울시 응답소 요청사항 분석', cex=0.8, fill=NA, border=NA, 
       bg='white', text.col='red', text.font=2, box.col='red')

# KoNLP 패키지

v3 <- c('봄이 지나면 여름이고 여름이 지나면 가을입니다.', '그리고 겨울이죠'); v3
extractNoun(v3)
v4 <- sapply(v3, extractNoun, USE.NAMES = F); v4

# wordcloud 패키지

# 주요 옵션 설명
# words : 출력할 단어들
# freq : 언급된 빈도수
# scale : 글자 크기
# min.freq : 최소 언급횟수 지정 - 이 값 이상 언급된 단어만 출력
# max.words : 최대 언급횟수 지정 - 이 값 이상 언급되면 삭제
# random.order : 출력되는 순서를 임의로 지정
# random.color : 글자 색상을 임의로 지정
# rot.per : 단어배치를 90도 각도로 출력
# colors : 출력될 단어들의 색상을 지정합니다
# ordered.colors : 이 값을 TRUE로 지정할 경우 각 글자별로 색상을 순서대로 지정할 수 있음
# user.layout : 이 값을 FALSE로 할 경우 R에서 C++코드를 사용할 수 있음

wordcloud(c(letters, LETTERS, 0:9), seq(1, 1000, len=62))     # 색상 없이 워드 클라우드 생성
palete <- brewer.pal(9, 'Set1')                               # 색상을 사용해서 워드 클라우드 생성
wordcloud(c(letters, LETTERS, 0:9), seq(1, 1000, len=62), colors = palete)

