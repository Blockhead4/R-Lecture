# Assignment 3

install.packages('stringr')
library(stringr)
View(iris)

## 데이터 셋 만들기

list <- unique(iris$Species)

iris_data <- c()
col <- c()

for(i in 1:length(list)) {
  df <- subset(iris, Species == list[i], select = names(iris)[-5])
  for(k in 1:(length(names(iris))-1)) {
    col <- c(col, str_c(names(iris)[k],' = ',list[i]))
  }
  iris_data <- rbind(iris_data, t(df))
}
rownames(iris_data) <- col

View(iris_data)


# 1. sepal(length, width), petal(length, width)
# 산점도 (Scatter Plot)

par(mfrow = c(3,2))

names(iris)
for(i in 1:(nrow(iris_data)/4)*4) {
  plot(iris_data[i-3,], iris_data[i-2,], xlab = names(iris)[i/i], ylab = names(iris)[i/i+1],
       main = list[i/4], col = 'red', xlim = c(4, 8.1), ylim = c(0, 4.5))
  plot(iris_data[i-1,], iris_data[i,], xlab = names(iris)[i/i+2], ylab = names(iris)[i/i+3], 
       main = list[i/4], col = 'blue', xlim = c(0.8, 7.5), ylim = c(0, 4.5))
}

# 2. 품종별 평균치로 BarPlot으로 비교하기

par(mfrow = c(1,2))

avg <- c()
for (i in 1:nrow(iris_data)) {
  avg <- c(avg, mean(iris_data[i,]))
}
avg

avg_mat <- matrix(avg, 4, 3)
colnames(avg_mat) <- list
avg_mat

barplot(avg_mat, beside = T, main = 'Average of Species', col = rainbow(nrow(avg_mat)), ylim = c(0,7))
legend(1, 7, names(iris)[1:4], cex=0.7, fill = rainbow(nrow(avg_mat)))

barplot(avg_mat, main = 'Average of Species', col = rainbow(nrow(avg_mat)), ylim = c(0, 20))
legend(0.2, 20, names(iris)[1:4], cex=0.7, fill = rainbow(nrow(avg_mat)))


# 3. BoxPlot 12개 그리기 

par(mfrow= c(1,3))

# for문으로 왜 불가능?????????????????????????????????????
boxplot(iris_data[1,], iris_data[2,], iris_data[3,], iris_data[4,],
        col = rainbow(nrow(iris_data)/3), names = col[1:4], main = list[1])
boxplot(iris_data[5,], iris_data[6,], iris_data[7,], iris_data[8,],
        col = rainbow(nrow(iris_data)/3), names = col[5:8], main = list[2])
boxplot(iris_data[9,], iris_data[10,], iris_data[11,], iris_data[12,],
        col = rainbow(nrow(iris_data)/3), names = col[9:12], main = list[3])

boxplot(iris_data[1:12,], col = rainbow(nrow(iris_data)), names = col)
