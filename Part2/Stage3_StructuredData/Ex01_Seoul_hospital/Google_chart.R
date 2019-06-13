# 예제 3-3. 서울시 주요 구의 의원 현황을 구글 차트로 불러오기

library(googleVis)
library(stringr)

data <- read.csv("data/2013년_서울_구별_주요과목별병원현황_구글용.csv")
data

hos <- gvisColumnChart(data, options = list(title="지역별 병원현황", height=400, weight=500))
plot(hos)

header <- hos$html$header    # html 웹상 그래프의 소스부분 header 불러오기
header

header <- str_replace_all(header, "utf-8", "euc-kr")    # utf-8 -> euc-kr
header

hos$html$header <- header    # 다시 웹상 소스 header 바꿔주기
plot(hos)                    # 그래프 출력
