## 处理乱年龄，3岁11月，1岁2月，8月5天，7岁等

# import data

mydata <- read.csv("C:/R Projects/learning/age.csv")


library(stringr)

# 从AGE变量中提取字符串，"<数字*任意位>+岁/月/天"分别到y/m/d变量
# [0-9] 指数字字符（也可以用d?）
# '+'表示{1，}，匹配一个及以上的
mydata$y <- str_extract(mydata$AGE, "[0-9]+[岁]")
mydata$m <- str_extract(mydata$AGE, "[0-9]+[月]")
mydata$d <- str_extract(mydata$AGE, "[0-9]+[天]")

# length check, space may count
# 检查出来绝大多数结果一致，但有一些原始数据中存在空格
length <- data.frame( l0 = str_length(mydata$AGE),
                      l1 = str_length(mydata$y),
                      l2 = str_length(mydata$m),
                      l3 = str_length(mydata$d))
length[is.na(length)] <- 0
ifelse(length$l0==length$l1+length$l2+length$l3, yes = "TRUE", no = "FALSE")

# 从y/m/d变量中提取字符串，"<数字*任意位>"分别到y/m/d变量，（即舍去岁/月/天）
mydata$year <- str_extract(mydata$y, "[0-9]+")
mydata$month <- str_extract(mydata$m, "[0-9]+")
mydata$day <- str_extract(mydata$d, "[0-9]+")

# 将year/month/day变量(第5-7列）中的NA替换为0
mydata[,5:7][is.na(mydata[,5:7])] <-0

# 转为数值型变量
mydata$year <- as.numeric(mydata$year)
mydata$month <- as.numeric(mydata$month)
mydata$day <- as.numeric(mydata$day)

# 计算AGE_NEW 变量
with(mydata, AGE_NEW <<- year + month/12 + day/365.25) 

mydata <- data.frame(mydata, AGE_NEW = AGE_NEW)

mydata

# 可以write.csv输出表格
# write.csv(mydata, file = "./age_new.csv")
