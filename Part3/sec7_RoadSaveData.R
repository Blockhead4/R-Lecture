# Load and Save Data

list.files()     # Working Directory 파일들을 보여줌
list.files(recursive = T)     # Working Directory 포함 하위 디렉터리 파일들을 보여줌
list.files(all.files = T)     # 숨김 파일까지 전부 보여줌

scan1 <- scan('scan_1.txt'); scan1      # 텍스트 파일안의 내용을 변수에 저장(기본적으로 배열로 저장)
scan2 <- scan('scan_2.txt'); scan2      # 1.00  2.00  3.00  4.00
scan2 <- scan('scan_2.txt',what=""); scan2    # 실수와 문자를 호출할 때는 what 옵션을 사용해야 함
scan3 <- scan('scan_3.txt',what=""); scan3
scan4 <- scan('scan_4.txt',what=""); scan4

input1 <- scan()      # scan() 함수에 입력값을 주지 않으면 사용자에게 입력을 받겠다는 의미
input1
input2 <- scan(what="")      # 문자로 입력받을 때는 what="" 꼭 사용
input2

input3 <- readline()
input3
input4 <- readline("Are you OK? :")    # readline("화면에 출력할 내용")
input4

input5 <- readLines('scan_4.txt'); input5    # 파일 읽어 들여서 여러 행을 하나의 행 배열로 담음

fruits <- read.table('fruits.txt'); fruits   # 일반 텍스트 형태의 파일을 데이터 프레임에 담기
fruits <- read.table('fruits.txt',header=T); fruits      # header=T로 열 이름 설정

fruit2 <- read.table('fruits_2.txt'); fruit2               # 주석은 자동 제외하고 불러옴
fruit2 <- read.table('fruits_2.txt',skip=2); fruit2        # 건너 뛸 줄 수를 지정
fruit2 <- read.table('fruits_2.txt',skip=3); fruit2        
fruit2 <- read.table('fruits_2.txt',nrows=2); fruit2       # 출력할 줄 수를 지정
fruit2 <- read.table('fruits_2.txt',skip=3,nrows=2); fruit2      # 세번째 줄부터 2줄만 출력

fruit3 <- read.table('fruits.txt',header=T,nrows=2); fruit3
fruit3 <- read.table('fruits.txt',header=F,skip=2,nrows=2); fruit3

fruit3 <- read.csv('fruits_3.csv'); fruit3      # csv파일은 txt파일과 다르게 헤더가 있다는 전제가 디폴트
fruit4 <- read.csv('fruits_4.csv'); fruit4
fruit4 <- read.csv('fruits_4.csv',header=F); fruit4      # 헤더가 없는 경우

label <- c('NO','NAME','PRICE','QTY')
fruit4 <- read.csv('fruits_4.csv',header=F,col.names=label); fruit4     # 헤더를 수동으로 직접 지정

install.packages('googleVis')     # 원하는 데이터를 SQL쿼리로 불러오기
library(googleVis)
install.packages('sqldf')
library(sqldf)
Fruits

write.csv(Fruits,'Fruits_sql.csv',quote=F,row.names=F)     # csv파일로 만들기 (quote???)
fruits_2 <- read.csv.sql('Fruits_sql.csv',sql='SELECT * FROM file WHERE Year=2008'); fruits_2
fruits_2 <- subset(Fruits,Fruits$Year==2009); fruits_2     # subset을 이용하여 위와 같은 결과 도출 가능

install.packages('XLConnect')    # 엑셀 데이터를 가져오는 방법(create=T???)
library(XLConnect)

data1=loadWorkbook('fruits_6.xls',create=T)      
data2=readWorksheet(data1,sheet='sheet1',startRow = 1,endRow = 8,startCol = 1,endCol = 5)
data2

fruits6 <- read.delim('clipboard',header=T); fruits6     # 클립보드 내용을 사용해서 데이터 프레임 생성

install.packages('readxl')
library(readxl)

fruits7 <- read_excel("fruits_6.xls", # path
sheet = "Sheet1", # sheet name to read from
 range = "A2:D6", # cell range to read from
col_names = TRUE, # TRUE to use the first row as column names
col_types = "guess", # guess the types of columns
na = "NA") # Character vector of strings to use for missing values
fruits7

