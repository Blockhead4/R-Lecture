# 예제 1-6. 영어 문서 분석하기 - 스티브 잡스 연설문 분석하기

install.packages('tm')
library(tm)
library(wordcloud)
library(RColorBrewer)


# 스티브 잡스 연설문

data1 <- readLines("data/steve.txt")
data1
class(data1)
# data1 <- iconv(data1, "WINDOWS-1252", "UTF-8")    # UTF-8 로 변경
corp1 <- Corpus(VectorSource(data1))    # 말뭉치로 변환하기
corp1

# 위 corp1 명령의 결과에서 documents :4 부분이 중요
inspect(corp1)    # corp1(Corpus) 안의 내용 살펴보기
tdm <- TermDocumentMatrix(corp1)
tdm
m <- as.matrix(tdm)
m

# tm_map : Corpus 안에 있는 문서의 내용을 지정한 형태로 변경
corp2 <- tm_map(corp1, stripWhitespace)   # 공백 제거
corp2 <- tm_map(corp2, tolower)           # 소문자로 바꿔라
corp2 <- tm_map(corp2, removeNumbers)     # 숫자 제거
corp2 <- tm_map(corp2, removePunctuation) # 마침표, 콤마, 세미콜론, 콜론 등 문자 제거
#corp2 <- tm_map(corp2, PlainTextDocument)   # 현 버전에서는 에러 발생

# stopwords('en') : 영 단어중 쓸데 없는 단어들 모음 / en : English 
# stopwords('dutch') / '  ' 안에 나라 언어를 입력하면 그 나라의 불용어들을 정리해 놓았음
stopwords('en')
stopwords('dutch')

#sword2 <- c(stopwords('en'), "and", "but", "not")
corp2 <- tm_map(corp2, removeWords, stopwords('en'))
corp2
tdm2 <- TermDocumentMatrix(corp2)
tdm2

m2 <- as.matrix(tdm2)
m2
class(m2)
colnames(m2) <- c(1:59)

m2
freq1 <- sort(rowSums(m2), decreasing = T)
head(freq1 ,20)
freq2 <- sort(colSums(m2), decreasing = T)
head(freq2, 20)

# Term Documnet Matrix 에서 특정 횟수 이상 언급된 것들만 출력
findFreqTerms(tdm2, 2)

palete <- brewer.pal(7, 'Set3')
wordcloud(names(freq1), freq=freq1, scale=c(5, 0.3), min.freq = 1, colors=palete, random.order = F, random.color = T)
legend(0.2, 1, "Steve Jobs 연설문", cex = 1, border = NA, fill = NA, bg="white", text.col = "blue", text.font = 2, box.col = "blue")

