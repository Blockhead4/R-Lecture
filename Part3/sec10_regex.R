# 정규표현식

# grep(pattern, a) : 벡터 a 에서 특정 패턴의 위치 출력
char <- c('apple', 'Apple', 'APPLE', 'banana', 'grape'); char
grep('apple', char)

char2 <- c('apple', 'banana'); char2
grep(char2, char)

grep(paste(char2, collapse='|'), char, value=T)     # value = T : 값 자체를 출력

grep('pp', char)
grep('pp', char, value=T)

grep('^A', char, value=T)
grep('e$', char, value=T)

char2 <- c('grape1', 'apple1', 'apple', 'orange', 'Apple'); char2
grep('ap', char2, value=T)            
grep('[1-9]', char2, value=T)            # 숫자 포함된 단어
grep('[0-9]', char2, value=T)            # 위와 같은 결과
grep('\\d', char2, value=T)              # 위와 같은 결과
grep('[[:upper:]]', char2, value=T)      # 대문자가 포함된 단어
grep('[A-Z]', char2, value=T)            # 위와 같은 결과



# nchar(a) : 입력된 배열이나 문자의 길이를 출력
nchar(char)
nchar('James seo')
nchar('서진수')



# paste('a', 'b', 'c') : a 와 b 와 c를 합쳐서 하나의 문자열처럼 출력
paste('Seo', 'Jin', 'Su')               # 기본 값은 각 값들 사이에 공백을 출력
paste('Seo', 'Jin', 'Su', sep='')       # 자동 삽입 공백을 없앰
paste('Seo', 'Jin', 'Su', sep='/')      # 구분자를 지정
paste('I', '\'m', 'Hungry')             # 특수문자가 있을 경우 Escape character (\) 를 써야 함



# sunbstr('a', 시작 위치, 끝나는 위치) : 배열 a 에서 시작부분부터 끝부분 까지 글자를 출력
substr('abc123', 3, 3)
substr('abc123', 3, 4)



# strsplit('문자열', split = '기준문자') : 문자열에서 split 부분의 글자를 기준으로 분리
strsplit('2014/11/22', split='/')



# regexpr('pattern'.text) : text 에서 패턴이 가장 먼저 나오는 위치값을 출력
grep('-', '010-8706-4712')      # grep 으로는 위치 찾기 불가능
regexpr('-', '010-8706-4712')      # 위치값, 길이, ?? 순서로 출력
