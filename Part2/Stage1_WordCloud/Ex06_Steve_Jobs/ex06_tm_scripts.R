# 예제 1-6. 영어 문서 분석하기 - 스티브 잡스 연설문 분석하기

install.packages('tm')
library(tm)
library(wordcloud)
library(RColorBrewer)


# 스티브 잡스 연설문

data1 <- readLines("data/steve.txt")
data1
class(data1)   # data1 의 유형이 벡터 형태
# data1 <- iconv(data1, "WINDOWS-1252", "UTF-8")    # UTF-8 로 변경
corp1 <- Corpus(VectorSource(data1))    # 말뭉치로 변환 / 벡터이므로 VectorSource() 사용
corp1                                   # Dataframe 의 경우 DataframeSource

# 위 corp1 명령의 결과에서 documents :4 부분이 중요
# document 란 tm 패키지가 작업할 수 있는 특별한 형태를 의미
# 일반적으로는 1줄이 1개의 document가 됨, 위의 경우 원본 파일이 총 4줄이라 documents : 4

inspect(corp1)    # corp1(Corpus) 안의 내용 살펴보기
tdm <- TermDocumentMatrix(corp1)    
tdm

# terms : 15 / 총 15개의 단어를 골랐다는 뜻
# documents : 4 / 소스가 4개의 문장이라는 뜻

# Term_Document Matrix는 tm 패키지만 볼 수 있으므로 Matrix 로 변환
m <- as.matrix(tdm)
m

# tm_map : Corpus 안에 있는 문서의 내용을 지정한 형태로 변경
corp2 <- tm_map(corp1, stripWhitespace)   # 여러 개의 공백을 하나의 공백으로 변환
corp2 <- tm_map(corp2, tolower)           # 대문자를 소문자로 변환
corp2 <- tm_map(corp2, removeNumbers)     # 숫자 제거
corp2 <- tm_map(corp2, removePunctuation) # 마침표, 콤마, 세미콜론, 콜론 등 문자 제거
#corp2 <- tm_map(corp2, PlainTextDocument)   # 현 버전에서는 에러 발생

# stopwords('en') : 영단어 중 불용어 모음 / en : English 
# stopwords('dutch') / '  ' 안에 나라 언어를 입력하면 그 나라의 불용어들을 정리해 놓았음
stopwords('en')
stopwords('dutch')

#sword2 <- c(stopwords('en'), "and", "but", "not")   
corp2 <- tm_map(corp2, removeWords, stopwords('en'))      # 불용어 제거
corp2
tdm2 <- TermDocumentMatrix(corp2)
tdm2

m2 <- as.matrix(tdm2)
m2
class(m2)
colnames(m2) <- c(1:59)    # Doc의 이름이 Character(0) 으로 변경되어 colnames 로 알아보기 쉽게 변환
m2

# 단어별로 빈도수 집계
freq1 <- sort(rowSums(m2), decreasing = T)     # 행의 합계
head(freq1 ,20)
freq2 <- sort(colSums(m2), decreasing = T)     # 열의 합계
head(freq2, 20)

# Term Documnet Matrix 에서 특정 횟수 이상 언급된 것들만 출력
findFreqTerms(tdm2, 2)

palete <- brewer.pal(7, 'Set3')
wordcloud(names(freq1), freq=freq1, scale=c(5, 0.3), min.freq = 1, colors=palete, random.order = F, random.color = T)
legend(0.2, 1, "Steve Jobs 연설문", cex = 1, border = NA, fill = NA, bg="white", text.col = "blue", text.font = 2, box.col = "blue")

