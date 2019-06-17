# 데이터 분석 프로젝트
# 한국인의 삶을 파악하라!

# 데이터 분석 준비하기
# 패키지 준비하기
install.packages("foreign")   
library(foreign)              # SPSS 파일 로드
library(dplyr)                # 전처리
library(ggplot2)              # 시각화
library(readxl)               # 엑셀 파일 로드

# 데이터 준비하기
# 데이터 불러오기
raw_welfare <- read.spss(file = "Part2/example/09-1.Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

# 복사본 만들기
welfare <- raw_welfare

# 데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

# 변수명 바꾸기
welfare <- rename(welfare,                  
                  sex = h10_g3,               # 성별
                  birth = h10_g4,             # 태어난 연도
                  marriage = h10_g10,         # 혼인 상태
                  religion = h10_g11,         # 종교
                  income = p1002_8aq1,        # 월급
                  code_job = h10_eco9,        # 직종 코드
                  code_region = h10_reg7)     # 직역 코드


# 1. 성별에 따른 월급 차이
# 성별 변수 검토하기
class(welfare$sex)

# 성별 변수 전처리
# 이상치 확인
table(welfare$sex)

# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9 , NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

# 월급 변수 검토
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

# 월급 변수 전처리
# 이상치 확인
summary(welfare$income)

# 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

# 결측치 확인
table(is.na(welfare$income))

# 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
sex_income

# 그래프 만들기
ggplot(data = sex_income, aes(x=sex, y=mean_income, fill=sex)) + 
  geom_col() + 
  ggtitle("성별에 따른 월급 차이") +
  theme(plot.title=element_text(hjust=0.5, face="bold", size=14))


# 2. 나이와 월급의 관계
# 몇 살때 월급을 가장 많이 받을까?
# 나이 변수 검토
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

# 나이 변수 전처리
# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

# 파생 변수 age - 나이 만들기
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

# 나이별 월급 평균표 만들기
age_income <- welfare %>%
  filter(!is.na(welfare$income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
age_income

welfare %>%
  filter(!is.na(welfare$income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income)) %>%
  arrange(desc(mean_income)) %>%
  head(5)

head(age_income)
summary(age_income)

# 그래프 만들기
ggplot(data = age_income, aes(x=age, y=mean_income)) + 
  geom_line()

# 파생 변수 만들기 - 연령대
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "20대이하",
                ifelse(age < 40, "30대",
                ifelse(age < 50, "40대", 
                ifelse(age < 60, "50대", "60대이상")))))
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))
ageg_income

# 그래프 만들기
ggplot(data = ageg_income, aes(x=ageg, y=mean_income, fill=ageg)) +
  geom_col() +
  scale_x_discrete(limits = c("20대이하", "30대", "40대", "50대", "60대이상"))
  

# 3. 연령대 및 성별 월급 차이
# 성별 월급 차이는 연령대별로 다를까?
# 연령대 및 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))
sex_income

# 그래프 만들기
ggplot(data = sex_income, aes(x=ageg, y=mean_income, fill=sex)) + 
  geom_col() +
  scale_x_discrete(limits = c("20대이하", "30대", "40대", "50대", "60대이상"))

# 분리된 막대그래프 만들기
ggplot(data = sex_income, aes(x=ageg, y=mean_income, fill=sex)) + 
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("20대이하", "30대", "40대", "50대", "60대이상"))     # x축 레이블의 순서 지정 

# 라인 그래프 만들기
sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))
sex_age

ggplot(sex_age, aes(x=age, y=mean_income, col=sex)) +
  geom_line(size=1)


# 4. 직업별 월급 차이
# 어떤 직업이 월급을 가장 많이 받을까?
# 변수 검토하기
class(welfare$code_job)
table(welfare$code_job)

# 직업분류코드 목록 불러오기
list_job <- read_excel("Part2/example/09-1.Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)

# welfare 에 직업명 결합
welfare <- left_join(welfare, list_job, id = "code_job")
welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

# 직업별 월급 평균표 만들기
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))
head(job_income)

# 그래프 만들기
# 상위 10개 추출
top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)
top10

ggplot(top10, aes(x=reorder(job, mean_income), y=mean_income, fill=job)) + 
  geom_col() +
  coord_flip()    # x와 y의 좌표를 바꿔서 출력

# 하위 10개 추출
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)
bottom10

ggplot(bottom10, aes(x=reorder(job, -mean_income), y=mean_income, fill=job)) + 
  geom_col() +
  coord_flip()    # x와 y의 좌표를 바꿔서 출력

# 5. 성별 직업 빈도
# 성별로 어떤 직업이 가장 많을까?
# 성별 직업 빈도표 만들기
job_male <- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_male

job_female <- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_female

# 그래프 만들기
# 남성 직업 빈도 상위 10개 직업
ggplot(data=job_male, aes(x=reorder(job, n), y=n, fill=job)) + 
  geom_col() + 
  coord_flip()

# 여성 직업 빈도 상위 10개 직업
ggplot(data=job_female, aes(x=reorder(job, n), y=n, fill=job)) + 
  geom_col() + 
  coord_flip()


# 6. 종교 유무에 따른 이혼율
# 변수 검토하기
class(welfare$religion)
summary(welfare$religion)
table(welfare$religion)

# 전처리
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

# 혼인 상태 변수 검토 및 전처리
# 변수 검토하기
class(welfare$marriage)
table(welfare$marriage)

# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1 , "marriage",
                          ifelse(welfare$marriage == 3, "divorce", NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

# 종교 유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
religion_marriage

# count() 활용
religion_marriage_1 <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion, group_marriage) %>%
  mutate(pct = round(n/sum(n)*100, 1))     #  ????? 이거 이상함 안됨
religion_marriage_1  

# 이혼율 표 만들기
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)
divorce

# 그래프 만들기
ggplot(divorce, aes(x=religion, y=pct, fill=religion)) + 
  geom_col()


# 7. 연령대별 이혼율 표 만들기
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage

# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>%
  filter(ageg != "20대이하" & group_marriage == "divorce") %>%
  select(ageg, pct)
ageg_divorce

# 그래프 만들기
ggplot(ageg_divorce, aes(x=ageg, y=pct, fill=ageg)) +
  geom_col()


# 8. 연령대 및 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "20대이하") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/sum(n)*100, 1))
ageg_religion_marriage

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)
df_divorce

# 연령대 및 종교 유무별 이혼율 그래프 만들기
ggplot(df_divorce, aes(x=ageg, y=pct, fill=religion)) +
  geom_col(position = "dodge")


# 9. 지역별 연령대 비율
# 노년층이 많은 지역은 어디일까?
# 변수 검토하기
class(welfare$code_region)
table(welfare$code_region)

# 전처리
list_region <- data.frame(code_region = c(1:7), 
                          region = c("서울",
                          "수도권(인천/경기)",
                          "부산/경남/울산",
                          "대구/경북",
                          "대전/충남",
                          "강원/충북",
                          "광주/전남/전북/제주도"))
list_region

# welfare 에 지역명 변수 추가
welfare <- left_join(welfare, list_region, id = "code_region")
welfare %>%
  select(code_region, region) %>%
  head

# 지역별 연령대 비율표 만들기
region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 2))
head(region_ageg)

ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col() +
  coord_flip() 

ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col(position = "dodge") +
  coord_flip()

# 노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "60대이상") %>%
  arrange(pct)
list_order_old

order <- list_order_old$region
order

ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col(position = "dodge") +
  coord_flip() +
  scale_x_discrete(limits = order)

# 연령대 순으로 막대 색깔 나열하기
# "20대이하", "30대", "40대", "50대", "60대이상"
class(region_ageg$ageg)
region_ageg$ageg <- factor(region_ageg$ageg, levels = c("60대이상", "50대", "40대", "30대", "20대이하"))
levels(region_ageg$ageg)

ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col() +
  coord_flip()

ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col(position = "dodge") +
  coord_flip() +
  scale_x_discrete(limits = order)

# 40대 인구가 가장 많은 지역

