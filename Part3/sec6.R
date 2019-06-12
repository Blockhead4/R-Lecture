# 많은 데이터 다루기

# Vector 1차원 : Matrix 2차원 : Array n차원


# Vector

c(1,2,3,4,5)
c(1,2,3,4,"5")

vec1 <- c(1,2,3,4,5); vec1
vec1[3]     # 벡터변수의 3번째 값을 보여줌
vec1[-3]    # 벡터변수의 3번째 값만 빼고 보여줌
vec1[1:3]
length(vec1)
vec1[1:(length(vec1)-2)]
vec1 <- c(vec1, 6); vec1
vec1[9] <- 9; vec1
vec1[2] <- 7; vec1
vec1[length(vec1)]    # 벡터변수의 맨 마지막 값을 보여줌

append(vec1,10,after=3)   # 벡터에 새로운 요소를 추가
append(vec1,13,after=5)
append(vec1,c(10,13),after=3)
append(vec1,13,after=0)   # 0은 가장 앞자리라는 특별한 의미가 있음
append(vec1, 22, length(vec1))    # 맨 마지막 자리에 추가

c(1,2,3) + c(4,5,6)
c(1,2,3) + 1

var1 <- c(1,2,3)
var2 <- c(4,5,6)
var1 + var2
var3 <- c('3','4','5'); var3
var1 + var3
union(var1,var3)    # 데이터형이 다른 두 벡터를 합함
class(union(var1,var3))
var4 <- c(1,2,3,4,5)  # 두 벡터의 길이가 다를 경우 순환원리 적용
var1 + var4
var5 <- c(1,2,3,4,5,6)
var1 + var5

var2 <- c(3,4,5)
var1 - var2
setdiff(var1,var2)      # var1에는 있지만 var2에는 없는 요소 출력
setdiff(var2,var1)      # var2에는 있지만 var1에는 없는 요소 출력
intersect(var1,var2)    # 공통요소 출력
intersect(var2,var1)

fruits <- c(10,20,30); fruits
names(fruits) <- c('apple','banana','mango')
fruits

var5 <- seq(1:6); var5
var6 <- seq(2,-2); var6
even <- seq(2,10,2); even    # seq(시작값, 끝값, 증가분)
odd <- seq(1,10,2); odd

var8 <- rep(1:3,2); var8
var9 <- rep(1:3,each=2); var9

5 %in% even    # 앞에있는 값이 뒤에 있는 변수에 잇는지 확인
4 %in% even


# Matrix(행렬)

mat1 <- matrix(c(1,2,3,4)); mat1                      # 열개수 디폴트 값은 1
mat2 <- matrix(c(1,2,3,4),nrow=2); mat2               # Matrix 입력 우선순위 디폴트 값은 행우선임
mat3 <- matrix(c(1,2,3,4),nrow=2,byrow=T); mat3       # byrow=T 열 우선순위로 바꿔줌

mat3[,1]     # 모든 행의 1열 값을 출력
mat3[1,]     # 모든 열의 1행값을 출력
mat3[1,1]    # 1행 1열의 값을 출력

mat4 <- matrix(seq(1:9),nrow=3,byrow=T); mat4
mat4 <- rbind(mat4, c(11,12,13)); mat4            # 아래쪽으로 행 추가(길이가 안 맞으면 에러 발생)
mat4 <- cbind(mat4, c(13,14,15,16)); mat4         # 오른쪽으로 열 추가

mat5 <- matrix(c('a','b','c','d'),nrow=2,byrow=T); mat5
mat5 <- cbind(mat5,c('e','f')); mat5

colnames(mat5) <- c('First','Second','Third'); mat5
rownames(mat5) <- c(1,2); mat5


# Array(배열)

array1 <- array(c(1:12), dim=c(4,3)); array1            # 행렬과 같은 2차배열 생성
array1 <- array(c(1:12), dim=c(4,3), byrow=T); array1

array2 <- array(c(1:12), dim=c(2,2,3)); array2           # 3차원 배열 생성
array2[1,1,3]      # 1행 1열 3층에 있는 값을 출력
array2[2,2,2]      # 2행 2열 2층에 있는 값을 출력


# List : Any Data Type
# List는 서로 다른 형태의 데이터를 함께 저장할 수 있다

list1 <- list(name='Jwp', address='Dae-Jeon', tel='010-1234-1234', age='20'); list1
list1$name
list1[1:3]

list1$birth <- '2000-1-1'; list1     # List에 항목 추가
list1$name <- c('Jwp','Jyp'); list1$name     # 하나의 Key에 벡터도 추가 가능

list1$birth <- NULL; list1     # 특정 항목 삭제
