# 지도 시각화

install.packages("maps")
install.packages("gridExtra")
install.packages("ggiraphExtra")
library(ggiraphExtra)
library(gridExtra)
library(ggplot2)
library(tibble)
library(dplyr)
library(reshape2)
library(extrafont)
library(maps)
windowsFonts(myfont = "MD이솝체")
theme_update(text = element_text(family = "myfont"))

str(USArrests)
head(USArrests)
tail(USArrests)
summary(USArrests)

# 행 이름을 칼럼으로 바꿔주는 함수 
crime <- rownames_to_column(USArrests, var="state")   # tibble 패키지
head(crime)
crime$state <- tolower(crime$state)

# maps 패키지의 map_data로 미국 주 지도 가져오기
states_map <- map_data("state")
str(states_map)

# 단계 구분도 만들기
install.packages('mapproj')
library(mapproj)

# 인터랙티브 단계 구분도 만들기
ggChoropleth(data = crime,
             aes(fill=Murder, map_id= state), 
             map = states_map,
             interactive=T)    # 뷰어에 출력된 Plot 안의 정보를 조회할 수 있음

#
m <- ggChoropleth(data = crime,
             aes(fill=Murder, map_id= state), 
             map = states_map) +
  ggtitle("미국 주별 살인범죄 분포", "(단위 : 인구 10만명당 건수)")+
  theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) +
  theme(plot.subtitle = element_text(hjust=1, size=12))
m

r <- ggChoropleth(data = crime,
             aes(fill=Rape, map_id= state), 
             map = states_map)   

a <- ggChoropleth(data = crime,
             aes(fill=Assault, map_id= state), 
             map = states_map)

u <- ggChoropleth(data = crime,
             aes(fill=UrbanPop,
                 map_id= state), 
             map = states_map)

windows()
grid.arrange(m, r, a, u, ncol=2,
             top = "미국 주별 강력범죄 분포")
