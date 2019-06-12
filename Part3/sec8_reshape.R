# reshape2() 패키지

install.packages('reshape2')
library(reshape2)
fruits <- read.csv('fruits_10.csv')

# melt() 함수로 wide -> long 형태로 변형하기
melt(fruits, id = 'year')
melt(fruits, id = c('year', 'name'), variable.name = '변수명', value.name = '변수값')

mtest <- melt(fruits, id = c('year', 'name'), variable.name = '변수명', value.name = '변수값'); mtest
mtest
# dcast() 함수로 long -> wide 형태로 변형하기
dcast(mtest, year + name ~ 변수명)     # dcast(data, 기준컬럼 ~ variable, 적용함수)
dcast(mtest, name ~ 변수명, sum)
dcast(mtest, name ~ 변수명, subset = .(name=='apple'))


# stringr() 패키지

install.packages('stringr')
library('stringr')

fruits <- c('apple', 'Apple', 'banana', 'pineapple'); fruits
str_detect(fruits, 'A')         # 대문자 A가 있는 단어 찾기
str_detect(fruits, 'a')   
str_detect(fruits, '^a')        # 첫 글자가 소문자 a 인 단어 찾기
str_detect(fruits, 'e$')        # 끝 글자가 소문자 e 인 단어 찾기
str_detect(fruits, '^[aA]')     # 첫 글자가 대문자 A 나 소문자 a 인 단어 찾기
str_detect(fruits, '[aA]')      # 단어에 대문자 A 와 소문자 a 가 들어 있는 단어 찾기

str_detect(fruits, regex('a', ignore_case = T))     # 대소문자 구분 없이 검사
str_count(fruits, regex('a', ignore_case = T))      # 주어진 단어에 해당 글자가 몇번 나오는지 검사
str_count(fruits, 'a')

str_c('apple', 'banana')      # paste() 함수와 같이 주어진 문자열(공백 없이)을 합쳐서 출력
str_c('Fruits: ', fruits)
str_c(fruits, ' name is ', fruits)
str_c(fruits, collapse = '')
str_c(fruits, collapse = '-')
str_c(fruits, collapse = ', ')

str_dup(fruits, 3)      # 주어진 문자열을 주어진 횟수만큼 반복해서 출력

str_length('apple')     # 주어진 문자열의 길이를 출력
str_length('과일')
str_length(fruits)

str_locate('apple', 'a')    # 주어진 문자열에서 특정 문자가 처음으로 나오는 위치와 마지막 위치를 알려 줌
str_locate('apple', 'app')
str_locate(fruits, 'a')

str_replace('apple', 'p', '*')        # 주어진 문자열에서 첫 번째 매치되는 변경 전 문자를 변경 후 문자로 바꾸어 줌
str_replace(fruits, 'a', '*')
str_replace_all(fruits, 'a', '*')     # 주어진 문자열에서 특정문자에 해당되는 모든 문자를 바꾸어 줌
fruits2 <- str_c('apple', '/', 'orange', '/', 'banana'); fruits2

str_split(fruits2, '/')     # 주어진 데이터셋을 지정된 기호로 분리

str_sub(fruits2, start=1, end=3)      # 주어진 문자열에서 지정된 길이 만큼의 문자를 잘라내어 출력
str_sub(fruits2, start=6, end=9)
str_sub(fruits2, start=7)
str_sub(fruits2, start=-5)            # -는 뒤에서부터 시작

'' apple banana berry '
str_trim(' apple banana berry ')      # 가장 앞과 가장 뒤의 공백을 제거
'\t apple banana berry \t'
str_trim('\t apple banana berry \t')  # 앞뒤 Tab 공백 제거
str_trim(' apple banana berry \n')    # 앞뒤 new line 제거

