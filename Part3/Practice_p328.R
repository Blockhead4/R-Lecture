# Matrix형 연습문제 

# 1번 문제
seasons <- matrix(c('봄','여름','가을','겨울'),nrow=2); seasons
seasons <- matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T); seasons

# 2번 문제
seasons[,2]

# 3번 문제
seasons_2 <- rbind(seasons,c('초봄','초가을')); seasons_2

# 4번 문제
seasons_3 <- cbind(seasons_2,c('초여름','초겨울','한겨울')); seasons_3
