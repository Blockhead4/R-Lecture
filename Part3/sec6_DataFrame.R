# Data Frame

no <- seq(1:4)
name <- c('Apple','Peach','Banana','Grape')
price <- c(500,200,100,50)
qty <- c(5,2,4,7)

sales <- data.frame(NO=no,NAME=name,PRICE=price,QTY=qty)
sales

sales2 <- matrix(c(1,'Apple',500,5,
                   2,'Peach',200,2,
                   3,'Banana',100,4,
                   4,'Grape',50,7),nrow=4,byrow=T)
sales2                 

df1 <- data.frame(sales2); df1
names(df1) <- c('NO','NAME','PRICE','QTY'); df1

sales$NAME
sales[1,3]
sales[,3]

sales[c(1,2),]      # 특정 행과 열을 출력
sales[,c(1,2)]
sales[,c(1:3)]

subset(sales,QTY<5)        # 특정 조건에 맞는 데이터만 출력
subset(sales,PRICE==200)
subset(sales,PRICE!=200)
subset(sales,name=='Apple')    # 조건이 문자일 경우 반드시 홑따옴표나 쌍따옴표로 처리

no <- c(1,2,3)
name <- c('apple','banana','peach')
price <- c(100,200,300)
df1 <- data.frame(NO=no,NAME=name,PRICE=price); df1

no <- c(10,20,30)
name <- c('train','car','airplane')
price <- c(1000,2000,3000)
df2 <- data.frame(NO=no,NAME=name,PRICE=price); df2

df3 <- cbind(df1,df2); df3
df3$NAME    # 앞에 있는 NAME 요소만 출력
df3[,5]     # 5열 출력
df4 <- rbind(df1,df2); df4
df4$NAME

df5 <- data.frame(name=c('apple','banana','cherry'),price=c(300,200,100)); df5
df6 <- data.frame(name=c('apple','cherry','berry'),qty=c(10,20,30)); df6

merge(df5,df6)           # df1 기준으로 df2와 공통으로 있는 name 컬럼 데이터를 출력
merge(df5,df6,all=T)     # 데이터가 없는것도 모두 나오도록 출력

rbind(df5,df6)     # name이 달라서 에러
cbind(df5,df6)
cbind(df6,df5)

df5
new <- data.frame(name='mango',price=400)
df5 <- rbind(df5,new); df5
df5 <- cbind(df5,data.frame(qty=seq(10,40,10))); df5

no <- seq(1,5,1)
name <- c('서진수','주시현','최경우','이동근','윤정웅')
address <- c('서울','대전','포항','경주','경기')
tel <- seq(1111,5555,1111)
hobby <- c('독서','미술','놀고먹기','먹고놀기','노는애감시하기')
member <- data.frame(NO=no,NAME=name,ADDRESS=address,TEL=tel,HOBBY=hobby)
member

member2 <- subset(member,select=c(NO,NAME,TEL)); member2     # 특정 칼럼만 출력
member3 <- subset(member,select=-TEL); member3               # 특정 칼럼만 제외하고 출력

colnames(member3) <- c('번호','이름','주소','취미'); member3      # 칼럼 이름 변경

sales
ncol(sales)     # 열 개수
nrow(sales)     # 행 개수수
names(sales)    # 열 이름
colnames(sales) # 열 이름
rownames(sales) <- c('one','two','three','four'); sales # 행 이름
sales
sales[c(2,3,1),]      # 행의 출력 순서 조정
sales[,c(1,2,4,3)]    # 열의 출력 순서 조정
