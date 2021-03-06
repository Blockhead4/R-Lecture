# Assignment 4

install.packages('ggplot2')
install.packages('dplyr')
install.packages('stringr')
library(ggplot2)
library(dplyr)
library(stringr)
View(mpg)

# 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에
#    어떤 관계가 있는지 알아보려고 합니다. 
#    x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
ggplot(mpg, aes(x=cty, y=hwy, color='red')) + geom_point(size=3) + 
  theme_bw() + 
  ggtitle('Scatterplot : cty x hwy') + 
  theme(plot.title=element_text(hjust=0.5))


# 2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 
#    midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 
#    어떤 관계가 있는지 알아보려고 합니다. 
#    x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 
#    산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인
#    인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.
View(midwest)
str(midwest)

sub_mid <- midwest %>%
  select(poptotal, popasian) %>%
  filter(poptotal <= 500000, popasian <= 10000)

ggplot(sub_mid, aes(x=poptotal, y=popasian, color='red')) + 
  geom_point(size=3) + 
  theme_bw() + 
  ggtitle('Scatterplot : poptotal x popasian') + 
  theme(plot.title=element_text(hjust=0.5))


# 3. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. 
#    "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을
#    막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요. 
df_mpg <- mpg %>%
  filter(class == 'suv') %>%
  group_by(manufacturer) %>%
  summarise(average_cty=mean(cty)) %>%
  arrange(desc(average_cty)) %>%
  head(5)
df_mpg

ggplot(df_mpg, aes(x=reorder(manufacturer, -average_cty), y=average_cty, fill=manufacturer)) +    # reorder 이해하기
  geom_bar(stat='identity') +
  theme_bw() +
  ggtitle('Barplot = manufacturer x average_cty') +
  theme(plot.title=element_text(hjust=0.5))

ggplot(df_mpg, aes(x=manufacturer, y=average_cty, fill=manufacturer)) + 
  geom_col()


# 4. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다.
#    자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
ggplot(mpg, aes(x=class, fill=class)) + 
  geom_bar() + 
  theme_bw() + 
  ggtitle('Barplot : class x count') + 
  theme(plot.title=element_text(hjust=0.5))


# 5. economics 데이터를 이용해서 psavert(개인 저축률)가 시간에 따라서 
#    어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 
#    나타낸 시계열 그래프를 만들어 보세요.
economics
str(economics)

ggplot(economics, aes(x=date, y=psavert, color='red')) + 
  geom_line() + 
  theme_bw() + 
  ggtitle('Lineplot : date x psavert') + 
  theme(plot.title=element_text(hjust=0.5))

# 6. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 
#    cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 
#    세 차종의 cty를 나타낸 상자 그림을 만들어보세요.
sub_mpg2 <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c('compact','subcompact','suv'))
sub_mpg2

ggplot(sub_mpg2, aes(x=class, y=cty, fill=factor(class))) + 
  geom_boxplot() + 
  theme_bw() + 
  ggtitle('Boxplot : class x cty') + 
  theme(plot.title=element_text(hjust=0.5))

# 7. Diamonds 데이터 셋을 이용하여 다음 문제를 해결하세요.
#    단, 컬러, 제목, x축, y축 등 그래프를 예쁘게 작성하세요.

#    1) cut의 돗수를 보여주는 그래프를 작성하세요. - 히스토그램
View(diamonds)
str(diamonds)
unique(diamonds$cut)
unique(diamonds$clarity)

sub_dia <- diamonds %>%
  select(cut, clarity) %>%
  group_by(cut) %>%
  arrange(cut)
sub_dia

ggplot(sub_dia, aes(x=cut, y=clarity, fill=clarity)) + 
  geom_histogram(stat='identity') +
  labs(x='cut', y='clarity') +
  theme_bw() +
  ggtitle('Histogram : cut x clarity') +  
  theme(plot.title=element_text(hjust=0.5))

ggplot(diamonds, aes(x=cut, fill=cut)) +     # 선생님 방법
  geom_bar()    

#    2) cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요. 
sub_dia2 <- diamonds %>%
  select(cut, price) %>%
  group_by(cut) %>%
  arrange(cut) %>%
  summarise(average_price = mean(price))
sub_dia2

ggplot(sub_dia2, aes(x=cut, y=average_price, fill=cut)) + 
  geom_bar(stat='identity') + 
  theme_bw() + 
  ggtitle('Barplot : cut x average_price') + 
  theme(plot.title=element_text(hjust=0.5))

#    3) cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
sub_dia3 <- diamonds %>%
  select(cut, color, price) %>%
  group_by(cut, color) %>%
  summarise(average_price = mean(price)) %>%
  mutate(cutXcolor = str_c(cut, ' & ', color)) %>%
  arrange(cut, color)
sub_dia3

ggplot(sub_dia3, aes(x=cutXcolor, y=average_price, fill=factor(color))) + 
  geom_bar(stat='identity') +
  theme_bw() + 
  theme(axis.text.x=element_text(angle=45, vjust=1, hjust=1, size=8)) +
  ggtitle('Barplot : cut & color x average_price') + 
  theme(plot.title=element_text(hjust=0.5))

