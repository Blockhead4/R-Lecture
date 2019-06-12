# sqldf() 패키지 활용

install.packages("sqldf")
library(sqldf)
library(googleVis)
Fruits

sqldf('SELECT * FROM Fruits')
sqldf('select * from Fruits')      # 대소문자 구분 없이 사용 가능
sqldf("select * from Fruits where Fruit = 'Apples'")
sqldf('select * from Fruits where Fruit = \'Apples\'')     # 작은 따옴표로 두번 묶을 때에는 안쪽에 있는 작은 따옴표에 '\' 붙여서 씀
sqldf('select * from Fruits limit 3')                      # 출력되는 행 수 제어 (limit 0, 3)
sqldf('select * from Fruits limit 3, 5')                   # 출력되는 행 수 제어 (3행 밑의 5개 행을 출력)
sqldf('select * from Fruits order by Year')                # 정렬해서 출력
sqldf('select * from Fruits order by Year desc')           # ORDER BY . DESC (내림차순)
sqldf('select sum(Sales) from Fruits')                            # SUM
sqldf('select max(Sales) from Fruits')                            # MAX
sqldf('select min(Sales) from Fruits')                            # MIN
sqldf('select avg(Sales) from Fruits')                            # AVG
sqldf('select Fruit, sum(Sales) from Fruits group by Fruit')      # GROUP BY
sqldf('select Fruit, avg(Sales) from Fruits group by Fruit')      # GROUP BY
sqldf('select Fruit, sum(Sales), sum(Expenses), sum(Profit) from Fruits group by Fruit')
sqldf('select Year, avg(Sales), avg(Expenses), avg(Profit) from Fruits group by Year')
sqldf('select Year, avg(Sales), avg(Expenses), avg(Profit) from Fruits group by Year order by avg(Profit) desc')
sqldf('select * from Fruits where Sales = 81')
sqldf('select * from Fruits where Sales = (select min(Sales) from Fruits)')
sqldf('select * from Fruits where Sales = (select max(Sales) from Fruits)')
sqldf('select count(*) from Fruits')                              # 총 수량

song <- read.csv('song.csv', header = F, fileEncoding = 'utf8')    # fileEncoding 변환으로 한글 깨짐 문제 해결
names(song) <- c('_id', 'title', 'lyrics', 'girl_group_id')        # 컬럼명 생성
song
girl_group <- read.csv('girl_group.csv', header = F, fileEncoding = 'utf8')
names(girl_group) <- c('_id', 'name', 'debut')
girl_group

sqldf('select gg._id, gg.name, gg.debut, s.title
      from girl_group as gg 
      inner join song as s 
      on gg._id = s.girl_group_id')

# AS 생략 가능, INNER 생략 가능
sqldf('select gg._id, gg.name, gg.debut, s.title
      from girl_group gg
      join song s
      on gg._id = s.girl_group_id')

Fruits
sqldf(c('UPDATE Fruits SET Profit = 40 WHERE Fruit= \'Apples\' AND Year = 2008', 'SELECT * FROM Friuts'))  # Why Error??
sqldf(c("UPDATE Fruits SET Profit = 40 WHERE Fruit='Apples' AND Year = 2008", 'SELECT * FROM Fruits'))

sqldf('select * from Fruits where Fruit = \'Apples\' and Year = 2008')
sqldf(c('update Fruits set Profit=40', 'select * from Fruits'))
