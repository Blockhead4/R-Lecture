# 데이터 정렬하기

library(googleVis)

sort1 <- Fruits$Sales; sort1
sort(sort1)     # Ascending Order (오름차순 정렬)
sort(sort1, decreasing = T)     # Descending Order (내림차순 정렬)


# plyr() 패키지

install.packages('plyr')
library(plyr)
fruits <- read.csv('fruits_10.csv',header=T); fruits

# ddply(data, 기준컬럼, 적용함수나 결과들)
ddply(fruits, 'name', summarise, sum_qty=sum(qty), sum_price=sum(price))      # summarise는 GROUP BY와 비슷한 역할
ddply(fruits, 'name', summarise, max_qty=max(qty), min_price=min(price))
ddply(fruits, c('year','name'), summarise, max_qty=max(qty), min_price=min(price))

ddply(fruits, 'name', transform, sum_qty=sum(qty), pct_qty=(100*qty)/sum(qty))    # transform은 행별로 연산을 수행함(예: 비율값)


# dplyr() 패키지

install.packages('dplyr')
library(dplyr)
data1 <- read.csv('2013년_프로야구선수_성적.csv'); data1

# 1. filter - 조건을 주어 필터링
# 2. select - 여러 컬럼이 있는 데이터에서 특정 컬럼만 선택해서 사용
# 3. arrange - 데이터를 오름차순이나 내림차순으로 정렬
# 4. mutate - 기존의 변수를 활용하여 새로운 변수를 생성
# 5. summarise(with group_by) - 주어진 데이터를 집계함(min, max, mean, count)
data2 <- filter(data1, 경기>120); data2     # 경기수가 120 초과인 선수
data3 <- filter(data1, 경기>120 & 득점>80); data3  # 경기수가 120 초과이면서 득점이 80 초과인 선수
data4 <- filter(data1, 포지션=='1루수' | 포지션=='3루수'); data4    # 포지션이 1루수나 3루수인 선수
data4 <- filter(data1, 포지션 %in% c('1루수','3루수')); data4       # 위와 같은 코딩

select(data1, 선수명, 포지션, 팀)    # 특정 컬럼만 출력
select(data1, 순위:타수)             # 순위 ~ 타수 컬럼만 출력
select(data1, -홈런, -타점, -도루)   # 특정 컬럼만 제외하고 출력

# 여러 문장을 조합해서 사용하는 방법 : %>%
data1 %>% select(선수명, 팀, 경기, 타수) %>% filter(타수>400)  

arrange(data1, 타수)
data1 %>% select(선수명, 팀, 경기, 타수) %>% filter(타수>400) %>% arrange(desc(경기), desc(타수))

mutate(data1, 경기x타수=경기*타수)
data1 %>%
  select(선수명, 팀, 경기, 타수) %>%
  mutate(경기x타수=경기*타수) %>%
  arrange(타수)
data1 %>%
  select(선수명, 팀, 출루율, 장타율) %>%
  mutate(OPS = 출루율 + 장타율) %>%
  arrange(desc(OPS))

data1 %>%
  group_by(팀) %>%
  summarise(average=mean(경기, na.rm=T))               # na.rm = TURE : 결측값을 통계 분석시 제외
data1 %>%
  group_by(팀) %>%
  summarise_each(list(mean), 경기, 타수, 타율)         # list(mean) : funs 대신 사용 가능(앞으로 dplyr 패키지에서 funs 사라짐) / 두 개 이상의 함수를 넣을 경우 사용 불가능 
data1 %>%
  group_by(팀) %>%
  summarise_each(funs(mean,n()), 경기, 타수, 타율)     # funs(mean) << functions(mean) : 적용할 함수

