# dplyr() 연습 문제 1

# 1번 문제
Fruits
Fruits_2 <- filter(Fruits, Expenses>80); Fruits_2

# 2번 문제
Fruits_3 <- filter(Fruits, Expenses>90 & Sales>90); Fruits_3

# 3번 문제
Fruits_4 <- filter(Fruits, Expenses>90 | Sales>80); Fruits_4

# 4번 문제
Fruits_5 <- filter(Fruits, Expenses==79 | Expenses==91); Fruits_5
Fruits_5 <- filter(Fruits, Expenses %in% c(79,91)); Fruits_5

# 5번 문제
select(Fruits, Fruit:Sales, -Location)

# 6번 문제
Fruits %>%
  group_by(Fruit) %>%
  summarise(avearage=sum(Sales, na.rm=T))

# 7번 문제
Fruits %>%
  group_by(Fruit) %>%
  summarise_each(list(sum), Sales, Profit)
