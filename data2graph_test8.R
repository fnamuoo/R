# 各 data からグラフ描画

# ##################################################
# ##################################################
## ベクトル（１：重複なし）

# ----------
# [5,7,3]
d = c(5,7,3)

# ほかのデータ例
# [1,2,3,5,8,NA,12]
d = c(1,2,3,5,8,NA,12)



# ==============================
# データの中身を確認する操作

head(d)

# [1] 5 7 3

# ----------

str(d)

# num [1:3] 5 7 3

# ----------


summary(d)

# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 3       4       5       5       6       7 

# ----------

table(d,useNA="ifany")

# d
# 3 5 7 
# 1 1 1 

# ----------

addmargins(table(d,useNA="ifany"))

# d
# 3   5   7 Sum 
# 1   1   1   3 

# ----------

### cumsum(table(d,useNA="ifany"))

# ----------

prop.table(table(d,useNA="ifany"))

# d
# 3         5         7 
# 0.3333333 0.3333333 0.3333333 

# ----------

addmargins(prop.table(table(d,useNA="ifany")))

# d
#   3         5         7       Sum 
# 0.3333333 0.3333333 0.3333333 1.0000000

# ----------

length(d)

# [1] 3

# ----------

# 重複の無い、要素の数
library(dplyr)
n_distinct(d)

# [1] 3

# ----------

# 一意の値
unique(d)

# [1] 5 7 3
`

# ==============================

# test8_1_1
png("test8_1_1.png", width=400, height=300)
  plot(d,type="b")
dev.off()

# ----------

# test8_1_2
png("test8_1_2.png", width=400, height=300)
  barplot(d)
dev.off()

# ----------

# test8_1_3
png("test8_1_3.png", width=400, height=300)
  pie(d, clockwise = T)
dev.off()

# ----------

hist(d)
# bin=10(縦棒10本分）で区間を自動分割して表示
hist(d, 10)
# bin=5(縦棒5本分）で区間を自動分割して表示
hist(d, 5)

# ################################################
# ################################################
## ベクトル（２：重複あり）

# ------------------------------------------------
# [1,2,1,3,2,1,1,1,1,1,1,2,1,3,1,1,1,1,1,1]
d = c(1,2,1,3,2,1,1,1,1,1,1,2,1,3,1,1,1,1,1,1)
df = data.frame(c1=d)

# ほかのデータ例
# [2, 1, 3, 1, NA, 2, ..]
d = sample(c(1,2,3,NA), size=100, replace=T, prob=c(.34, .4, .23, .03))
df = data.frame(c1=d)

# [a, c, b, a, b, b, ..]
d = sample(c("a","b","c"), size=100, replace=T, prob=c(.6, .3, .1))
df = data.frame(c1=d)

# ==============================
# データの中身を確認する操作

head(d)

# [1] 1 2 1 3 2 1

# ----------

str(d)

#  num [1:20] 1 2 1 3 2 1 1 1 1 1 ...

# ----------

summary(d)

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   1.00    1.00    1.00    1.35    1.25    3.00 

# ----------

table(d,useNA="ifany")

# d
#  1  2  3 
# 15  3  2 

# ----------

addmargins(table(d,useNA="ifany"))


# d
#   1   2   3 Sum 
#  15   3   2  20 

# ----------

length(d)

# [1] 20

# ----------

library(dplyr)
n_distinct(d)

# [1] 3

# ----------

unique(d)

# [1] 1 2 3
`

# ==============================

# ----------
# test8_2_1
png("test8_2_1.png", width=400, height=300)
  plot(d)
dev.off()

# ----------

# test8_2_2
png("test8_2_2.png", width=400, height=300)
  plot(table(d), type="b")
dev.off()


# test8_2_3
library(ggplot2)
ggplot(df, aes(x=c1)) +
  geom_line(stat="count") +
  geom_point(stat="count",size=6) +
  ggsave("test8_2_3.png", width=4, height=3, dpi=100)


# ----------

# test8_2_4
png("test8_2_4.png", width=400, height=300)
  hist(d)
dev.off()

# ----------

# test8_2_5
png("test8_2_5.png", width=400, height=300)
  barplot(table(d))
dev.off()

## barplot(table(d,useNA="ifany"))

# ----------

# test8_2_6
library(ggplot2)
ggplot(df, aes(x=c1)) +
  geom_histogram(binwidth = 0.5) +
  ggsave("test8_2_6.png", width=4, height=3, dpi=100)

# test8_2_7
ggplot(df, aes(x=c1)) +
  geom_bar(stat="count") +
  ggsave("test8_2_7.png", width=4, height=3, dpi=100)

# ..same
ggplot(df, aes(x=c1)) +
  geom_bar()

# ----------

# test8_2_8
png("test8_2_8.png", width=400, height=300)
  pie(table(d),clockwise = "T")
dev.off()



# ################################################
# ################################################
# ------------------------------------------------

## ベクトル（３：カテゴリ分類操作あり）


d = c(3265,7556,4210,2602,5082,9389,4831,9668,6807,3139,2133,9214,2878,3751,1790,2946,4761,6166,8076,5473)


# ほかのデータ例
# 均一分布の乱数で 最小(min)、最大(max)範囲の整数を、個数(10)発生させ、floorで整数化
d = floor(runif(100, min=1000, max=9999))

d = rnorm(100)

# ----------

# データ加工

# カテゴリ化（閾値による分類）
library(dplyr)
df <- data.frame(c1=d) |>
  mutate(c2 = case_when(c1 <1000 ~ "-1000",
                        c1 >= 1000 & c1 < 2000 ~ "1k-2k",
                        c1 >= 2000 & c1 < 5000 ~ "2k-5k",
                        c1 >= 5000 & c1 < 8000 ~ "5k-8k",
                        c1 >= 8000 ~ "8k-")) |>
  mutate(c2 = as.factor(c2))

# カテゴリ値によるグループ化と集計
#   n        .. そのカテゴリのレコード数（重複行あり）
#   c1_ndist .. そのカテゴリにある一意なc1の数（重複値なし）
#   c1_sum   .. そのカテゴリにc1の和
#   c1_mean  .. そのカテゴリにc1の平均値
df2 <- df |>
  group_by(c2) |>
  summarise(n=n(),
            c1_ndist=n_distinct(c1),
            c1_sum=sum(c1),
            c1_mean=mean(c1)) |>
  ungroup()


# ==============================
# データの中身を確認する操作

head(d)

# [1] 3265 7556 4210 2602 5082 9389

# ----------

str(d)

# num [1:20] 3265 7556 4210 2602 5082 ...

# ----------

summary(d)

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   1790    3091    4796    5187    6994    9668 
w
# ----------

# table(d,useNA="ifany")

# ----------

# addmargins(table(d,useNA="ifany"))

# ----------

head(df)

#     c1    c2
# 1 3265 2k-5k
# 2 7556 5k-8k
# 3 4210 2k-5k
# 4 2602 2k-5k
# 5 5082 5k-8k
# 6 9389   8k-

# ----------

summary(df)

#        c1           c2    
#  Min.   :1790   1k-2k: 1  
#  1st Qu.:3091   2k-5k:10  
#  Median :4796   5k-8k: 5  
#  Mean   :5187   8k-  : 4  
#  3rd Qu.:6994             
#  Max.   :9668  

# ----------

table(df$c2)

# 1k-2k 2k-5k 5k-8k   8k- 
#     1    10     5     4 

# ----------

df2

# # A tibble: 4 × 5
#   c2        n c1_ndist c1_sum c1_mean
#   <fct> <int>    <int>  <dbl>   <dbl>
# 1 1k-2k     1        1   1790   1790 
# 2 2k-5k    10       10  34516   3452.
# 3 5k-8k     5        5  31084   6217.
# 4 8k-       4        4  36347   9087.

# ==============================

# test8_3_1
png("test8_3_1.png", width=400, height=300)
  plot(x=1:nrow(df2), y=df2$n)
dev.off()

# ----------

# test8_3_2
png("test8_3_2.png", width=400, height=300)
  hist(d)
dev.off()

# hist(df$c1)

# ----------

# test8_3_3
library(ggplot2)
ggplot(df2) +
  geom_point(mapping = aes(x = c2, y = c1_ndist)) +
  ggsave("test8_3_3.png", width=4, height=3, dpi=100)

# つづきは カテゴリvs連続値　で


# ################################################
# ################################################

# matrix
# RxC= 2x5
#  [  5,  7,  9, 11, 13]
#  [ 16,  8,  4,  2,  1]
d=matrix(c(5,16,7,8,9,4,11,2,13,1),2,5)

#      [,1] [,2] [,3] [,4] [,5]
# [1,]    5    7    9   11   13
# [2,]   16    8    4    2    1

# ==============================
# データの中身を確認する操作

addmargins(d)

#                    Sum
#      5  7  9 11 13  45
#     16  8  4  2  1  31
# Sum 21 15 13 13 14  76

# ----------

round(prop.table(d), 2)

#      [,1] [,2] [,3] [,4] [,5]
# [1,] 0.07 0.09 0.12 0.14 0.17
# [2,] 0.21 0.11 0.05 0.03 0.01

# ----------

addmargins(round(prop.table(d), 2))

#                              Sum
#     0.07 0.09 0.12 0.14 0.17 0.59
#     0.21 0.11 0.05 0.03 0.01 0.41
# Sum 0.28 0.20 0.17 0.17 0.18 1.00

# ==============================

# ---------
# test8_4_1
png("test8_4_1.png", width=400, height=300)
  barplot(d)
dev.off()

# test8_4_2
png("test8_4_2.png", width=400, height=300)
  barplot(d,beside=T)
dev.off()

#x library(ggplot2)
#x ggplot(d) +
#x   geom_bar()


# ###############################################
# ###############################################
## データフレーム（１：連続値ｘ２）

c1 = c( 5,  7,  9, 11, 13)
c2 = c(16,  8,  4,  2,  1)
d = data.frame(c1,c2)

#   c1 c2
# 1  5 16
# 2  7  8
# 3  9  4
# 4 11  2
# 5 13  1

# ほかのデータ例
#   tibble型のデータフレームの例（１）
library(dplyr)
d = data_frame(c1,c2)

# # A tibble: 5 × 2
#      c1    c2
#   <dbl> <dbl>
# 1     5    16
# 2     7     8
# 3     9     4
# 4    11     2
# 5    13     1

#   tibble型のデータフレームの例（２）
d = tibble(c1,c2)

# ----------

# データ加工

# index列を追加
d2 <- d |>
  mutate(idx=1:nrow(d))

# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2
# 1  5 16
# 2  7  8
# 3  9  4
# 4 11  2
# 5 13  1

# ----------

str(d)

# dataframeの場合
# 'data.frame':	5 obs. of  2 variables:
#  $ c1: num  5 7 9 11 13
#  $ c2: num  16 8 4 2 1

# 参考：tibbleの場合
# tibble [5 × 2] (S3: tbl_df/tbl/data.frame)
#  $ c1: num [1:5] 5 7 9 11 13
#  $ c2: num [1:5] 16 8 4 2 1

# ----------

summary(d)

#       c1           c2      
# Min.   : 5   Min.   : 1.0  
# 1st Qu.: 7   1st Qu.: 2.0  
# Median : 9   Median : 4.0  
# Mean   : 9   Mean   : 6.2  
# 3rd Qu.:11   3rd Qu.: 8.0  
# Max.   :13   Max.   :16.0 

# x addmargins(d)

# ==============================

# test8_5_1
png("test8_5_1.png", width=400, height=300)
  plot(d)
dev.off()

# test8_5_2
library(ggplot2)
# ggplot(d) +
#   geom_point(mapping = aes(x = c1, y = c2))
ggplot(d) +
  geom_point(aes(x = c1, y = c2), size=6) +
  ggsave("test8_5_2.png", width=4, height=3, dpi=100)

# ----------
# Indexを追加したデータを使い２列のグラフを重ねる

# test8_5_3
png("test8_5_3.png", width=400, height=300)
  plot(x=d2$idx, y=d2$c1, type="b", ylim=c(0,20))
  par(new=T)
  plot(x=d2$idx, y=d2$c2, type="b", ylim=c(0,20), ann=F)
dev.off()

# test8_5_4
library(ggplot2)
ggplot(d2) +
  geom_line(mapping = aes(x = idx, y = c1)) +
  geom_line(mapping = aes(x = idx, y = c2)) +
  ggsave("test8_5_4.png", width=4, height=3, dpi=100)
  

# ###############################################
# ###############################################

## データフレーム（２：カテゴリ値と連続値）

# c1 | c2
# ---|----
# a  | 3
# b  | 7
# c  | 5

c1 = c("a","b","c")
c2 = c(3,7,5)
d = data.frame(c1=as.factor(c1),c2=c2)

#   c1 c2
# 1  a  3
# 2  b  7
# 3  c  5

# # index列を追加
# d0 <- d |>
#   mutate(c0 = 1:nrow(d))
# 
# #   c1 c2 c0
# # 1  a  3  1
# # 2  b  7  2
# # 3  c  5  3


# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2
# 1  a  3
# 2  b  7
# 3  c  5

# --------

str(d)

# # d = data.frame(c1=as.factor(c1),c2=c2) のときのstr()
# 'data.frame':	3 obs. of  2 variables:
#  $ c1: Factor w/ 3 levels "a","b","c": 1 2 3
#  $ c2: num  3 7 5

# # 参考： d = data.frame(c1,c2) のときのstr()
# 'data.frame':	3 obs. of  2 variables:
#  $ c1: chr  "a" "b" "c"
#  $ c2: num  3 7 5

# --------

summary(d)

# c1          c2   
# a:1   Min.   :3  
# b:1   1st Qu.:4  
# c:1   Median :5  
#       Mean   :5  
#       3rd Qu.:6  
#       Max.   :7 

# --------

table(d)

#    c2
# c1  3 5 7
#   a 1 0 0
#   b 0 0 1
#   c 0 1 0


# ==============================

# ----------

# test8_6_1
png("test8_6_1.png", width=400, height=300)
  plot(d)
dev.off()
# err barplot(d$c1, d$c2)

# test8_6_2
library(ggplot2)
ggplot(d) +
  geom_point(mapping = aes(x = c1, y = c2)) +
  ggsave("test8_6_2.png", width=4, height=3, dpi=100)

# ggplot(d, aes(x = c1, y = c2)) +
#   geom_point()

# test8_6_3 .. 散布図（Y軸のスケールを調整）
ggplot(d) +
  geom_point(mapping = aes(x = c1, y = c2)) +
  scale_y_continuous(breaks=seq(0,10),limits=c(0,10)) +
  ggsave("test8_6_3.png", width=4, height=3, dpi=100)

# ----------
# カテゴリごとの値を棒グラフで
ggplot(d, aes(x = c1, y = c2)) +
  geom_bar(stat = "identity") +
  ggsave("test8_6_4.png", width=4, height=3, dpi=100)

# カテゴリごとの値を棒グラフで＋装飾（カテゴリ値で色分け）
ggplot(d, aes(x = c1, y = c2, fill=c1)) +
  geom_bar(stat = "identity") +
  ggsave("test8_6_5.png", width=4, height=3, dpi=100)

# ----------

png("test8_6_6.png", width=400, height=300)
  pie(x=d$c2, label=d$c1, clockwise = T)
dev.off()

# ラフな円グラフ
ggplot(d, aes(x=0, y=c2, fill=c1)) +
  geom_col(color="black", position=position_stack(reverse=T)) +
  coord_polar("y") +
  ggsave("test8_6_7.png", width=4, height=3, dpi=100)

## geom_col ? geom_bar? .. こちらもOK
#ggplot(d, aes(x=0, y=c2, fill=c1)) +
#  geom_bar(stat="identity", color="black") +
#  coord_polar("y")
#ggplot(d, aes(x=0, y=c2, fill=c1)) +
#  geom_bar(stat="identity", position=position_stack(reverse=T), color="black") +
#  coord_polar("y")

# 円グラフ：時計回りの順に並べる
ggplot(d, aes(x=0, y=rev(c2), fill=c1)) +
  geom_col(color="black") +
  coord_polar("y") +
  geom_text(aes(label=rev(c1)), position=position_stack(vjust=0.5)) +
  theme_void() +
  theme(legend.position = "none") +
  ggsave("test8_6_8.png", width=4, height=3, dpi=100)

# 円グラフ：時計回りの順、ラベル名調整
d |>
  mutate(vlbl = paste0(c1,"(",c2,")")) |>
  mutate(ypos = cumsum(c2) - c2/2) |>
  ggplot(aes(x=0, y=rev(c2), fill=c1)) +
    geom_col(color="black") +
    coord_polar("y") +
    geom_text(aes(y=ypos, label=vlbl), size=4) +
    theme_void() +
    theme(legend.position="none") +
    ggsave("test8_6_9.png", width=4, height=3, dpi=100)

# 円グラフ：時計回りの順、ラベル名調整、配色修正
d |>
  mutate(vlbl = paste0(c1,"(",c2,")")) |>
  mutate(ypos = cumsum(c2) - c2/2) |>
  ggplot(aes(x=0, y=c2, fill=c1)) +
    geom_bar(stat="identity", color="black", position=position_stack(reverse=T)) +
    geom_text(aes(y=ypos, label=vlbl), size=4) +
    coord_polar("y") +
    theme_void() +
    theme(legend.position="none") +
    ggsave("test8_6_10.png", width=4, height=3, dpi=100)


# ###############################################
# ###############################################

## データフレーム（３：カテゴリ値と連続値／カテゴリの重複）

# c1 | c2
# ---|----
# a  | 1
# a  | 1
# a  | 2
# a  | 3
# b  | 5
# c  | 8

c1 = c("a","a","a","a","b","c")
c2 = c(1, 1, 2, 3, 5, 8)
d = data.frame(c1=as.factor(c1),c2)

#   c1 c2
# 1  a  1
# 2  a  1
# 3  a  2
# 4  a  3
# 5  b  5
# 6  c  8

# ほかのデータ例
c1 = c("a","b","a","c","a","a")
c2 = c(1, 13, 2, 4, 1, 2)
d = data.frame(c1=as.factor(c1),c2)

# ----------
# データ加工

# indexを追加
library(dplyr)
d0 <- d |>
  mutate(c0 = 1:nrow(d))

#   c1 c2 c0
# 1  a  1  1
# 2  a  1  2
# 3  a  2  3
# 4  a  3  4
# 5  b  5  5
# 6  c  8  6

# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2
# 1  a  1
# 2  a  1
# 3  a  2
# 4  a  3
# 5  b  5
# 6  c  8

# --------

str(d)

# 'data.frame':	6 obs. of  2 variables:
#  $ c1: Factor w/ 3 levels "a","b","c": 1 1 1 1 2 3
#  $ c2: num  1 1 2 3 5 8

# --------

summary(d)

# c1          c2       
# a:4   Min.   :1.000  
# b:1   1st Qu.:1.250  
# c:1   Median :2.500  
#       Mean   :3.333  
#       3rd Qu.:4.500
#       Max.   :8.000  

# --------

table(d)

#    c2
# c1  1 2 3 5 8
#   a 2 1 1 0 0
#   b 0 0 0 1 0
#   c 0 0 0 0 1


# ==============================
# ----------

# カテゴリごとの分布
png("test8_7_1.png", width=400, height=300)
  plot(d, type="b")
dev.off()

# カテゴリごとの分布：散布図
library(ggplot2)
ggplot(d) +
  geom_point(mapping = aes(x = c1, y = c2)) +
  ggsave("test8_7_2.png", width=4, height=3, dpi=100)

# カテゴリごとの分布：箱ひげ図
ggplot(d) +
  geom_boxplot(aes(x = c1, y = c2)) +
  ggsave("test8_7_3.png", width=4, height=3, dpi=100)

# カテゴリごとの分布：バイオリンプロット
ggplot(d) +
  geom_violin(aes(x = c1, y = c2)) +
  ggsave("test8_7_4.png", width=4, height=3, dpi=100)


# ----------
# カテゴリごとの和
ggplot(d, aes(x = c1, y = c2)) +
  geom_bar(stat = "identity") +
  ggsave("test8_7_5.png", width=4, height=3, dpi=100)

# カテゴリごとの和：カテゴリで色分け
ggplot(d, aes(x = c1, y = c2, fill=c1)) +
  geom_bar(stat = "identity") +
  ggsave("test8_7_6.png", width=4, height=3, dpi=100)

# ----------

# indexと値の散布図
png("test8_7_7.png", width=400, height=300)
  plot(d0$c0, d0$c2)
dev.off()


# indexと値の棒グラフ：カテゴリで色分け
ggplot(d0, aes(x = c0, y = c2, fill=c1)) +
  geom_bar(stat = "identity") +
  ggsave("test8_7_8.png", width=4, height=3, dpi=100)

# ----------

png("test8_7_9.png", width=400, height=300)
  pie(x=d$c2, label=d$c1, clockwise = T)
dev.off()

# ラフな円グラフ
ggplot(d, aes(x=0, y=c2, fill=c1)) +
  geom_col(color="black", position=position_stack(reverse=T)) +
  coord_polar("y") +
  ggsave("test8_7_10.png", width=4, height=3, dpi=100)

# カテゴリ別の円グラフ
# .. 描画時にカテゴリでfillしているためか、最初にカテゴリでソート済みに（arrange）しておく
d |>
  arrange(c1) |>
  mutate(vlbl = paste0(c1,"(",c2,")")) |>
  mutate(ypos = cumsum(c2) - c2/2) |>
  ggplot(aes(x=0, y=c2, fill=c1)) +
    geom_bar(stat="identity", color="black", position=position_stack(reverse=T)) +
    geom_text(aes(y=ypos, label=vlbl), size=4) +
    coord_polar("y") +
    theme_void() +
    theme(legend.position="none") +
    ggsave("test8_7_11.png", width=4, height=3, dpi=100)

# ###############################################
# ###############################################

## データフレーム（４：連続値×３）

# c1 | c2 | c3
# ---|----|----
# 11 | 5  | 16
# 12 | 7  | 8
# 13 | 9  | 4
# 14 | 11 | 2
# 15 | 13 | 1


c1 = 11:15
c2 = c( 5,  7,  9, 11, 13)
c3 = c(16,  8,  4,  2,  1)
d = data.frame(c1,c2,c3)

#   c1 c2 c3
# 1 11  5 16
# 2 12  7  8
# 3 13  9  4
# 4 14 11  2
# 5 15 13  1

# ----------
# データ加工

# indexを追加
library(dplyr)
d0 <- d |>
  mutate(c0 = 1:nrow(d))

#   c1 c2 c3 c0
# 1 11  5 16  1
# 2 12  7  8  2
# 3 13  9  4  3
# 4 14 11  2  4
# 5 15 13  1  5

# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2 c3
# 1 11  5 16
# 2 12  7  8
# 3 13  9  4
# 4 14 11  2
# 5 15 13  1

# ----------

str(d)

# # d = data.frame(c1,c2,c3)
# data.frame':	5 obs. of  3 variables:
# $ c1: int  11 12 13 14 15
# $ c2: num  5 7 9 11 13
# $ c3: num  16 8 4 2 1

# 参考：tibbleの場合
# # d = data_frame(c1,c2,c3)
# tibble [5 × 3] (S3: tbl_df/tbl/data.frame)
# $ c1: int [1:5] 11 12 13 14 15
# $ c2: num [1:5] 5 7 9 11 13
# $ c3: num [1:5] 16 8 4 2 1

# ----------

summary(d)

#       c1           c2           c3      
# Min.   :11   Min.   : 5   Min.   : 1.0  
# 1st Qu.:12   1st Qu.: 7   1st Qu.: 2.0  
# Median :13   Median : 9   Median : 4.0  
# Mean   :13   Mean   : 9   Mean   : 6.2  
# 3rd Qu.:14   3rd Qu.:11   3rd Qu.: 8.0  
# Max.   :15   Max.   :13   Max.   :16.0 

# ==============================

# ----------
png("test8_8_1.png", width=400, height=300)
  plot(d)
dev.off()

# ----------
# c1をX軸として、c2,c3の折れ線グラフ

png("test8_8_2.png", width=400, height=300)
  plot(x=d$c1, y=d$c2, type="b", col=1, ylim=c(0,20), xlab="c1", ylab="c2,c3")
  par(new=T)
  plot(x=d$c1, y=d$c3, type="b", col=2, ylim=c(0,20), ann=F)
  legend("topleft", legend=c("c1", "c2"), lty=1, col=1:2)
dev.off()

library(ggplot2)
ggplot(d) +
  geom_point(mapping = aes(x = c1, y = c2), size=4) +
  geom_line(mapping = aes(x = c1, y = c2)) +
  geom_point(mapping = aes(x = c1, y = c3), color="red", size=4) +
  geom_line(mapping = aes(x = c1, y = c3), color="red") +
  ggsave("test8_8_3.png", width=4, height=3, dpi=100)

# ----------
# c1をX軸として、c2,c3の棒グラフ
#   .. ずらして描画できない？ので半透明で重ねる
ggplot(d) +
  geom_bar(mapping = aes(x = c1, y = c2), stat="identity", width=0.8, color="red", alpha=1/3) +
  geom_bar(mapping = aes(x = c1, y = c3), stat="identity", width=0.5, color="blue", alpha=1/3) +
  ggsave("test8_8_4.png", width=4, height=3, dpi=100)

# ----------
# c1をX軸として、c2の棒グラフとc3の折れ線グラフ
ggplot(d) +
  geom_bar(aes(x = c1, y = c2), stat="identity") +
  geom_point(aes(x = c1, y = c3), stat="identity", color="blue") +
  geom_line(aes(x = c1, y = c3), stat="identity", color="blue") +
  ggsave("test8_8_5.png", width=4, height=3, dpi=100)



# ###############################################
# ###############################################

## データフレーム（５：連続値×２とカテゴリ値）

# c1 | c2 | c3
# ---|----|----
# 11 | 5  | a
# 12 | 7  | a
# 13 | 9  | a
# 14 | 11 | a
# 15 | 13 | a
# 11 | 16 | b
# 12 | 8  | b
# 13 | 4  | b
# 14 | 2  | b
# 15 | 1  | b

c1a = 11:15
c2a = c( 5,  7,  9, 11, 13)
c3a = rep("a", length(c1a))
c2b = c(16,  8,  4,  2,  1)
c3b = rep("b", length(c1a))
c1 = c(c1a,c1a)
c2 = c(c2a,c2b)
c3 = c(c3a,c3b)
d = data.frame(c1,c2,c3=as.factor(c3))

#    c1 c2 c3
# 1  11  5  a
# 2  12  7  a
# 3  13  9  a
# 4  14 11  a
# 5  15 13  a
# 6  11 16  b
# 7  12  8  b
# 8  13  4  b
# 9  14  2  b
# 10 15  1  b

# ほかのデータ例
#   Rに標準に格納
iris

#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa


# ----------
# データ加工

# indexを追加
library(dplyr)
d0 <- d |>
  mutate(c0 = 1:nrow(d))

#    c1 c2 c3 c0
# 1  11  5  a  1
# 2  12  7  a  2
# 3  13  9  a  3
# 4  14 11  a  4
# 5  15 13  a  5
# 6  11 16  b  6
# 7  12  8  b  7
# 8  13  4  b  8
# 9  14  2  b  9
# 10 15  1  b 10


# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2 c3
# 1 11  5  a
# 2 12  7  a
# 3 13  9  a
# 4 14 11  a
# 5 15 13  a
# 6 11 16  b

# ----------

str(d)

# 'data.frame':	10 obs. of  3 variables:
# $ c1: int  11 12 13 14 15 11 12 13 14 15
# $ c2: num  5 7 9 11 13 16 8 4 2 1
# $ c3: Factor w/ 2 levels "a","b": 1 1 1 1 1 2 2 2 2 2

# ----------

summary(d)

#       c1           c2        c3   
# Min.   :11   Min.   : 1.00   a:5  
# 1st Qu.:12   1st Qu.: 4.25   b:5  
# Median :13   Median : 7.50        
# Mean   :13   Mean   : 7.60        
# 3rd Qu.:14   3rd Qu.:10.50        
# Max.   :15   Max.   :16.00  

# ==============================

# ---------
# 相関プロット群
png("test8_9_1.png", width=400, height=300)
  plot(d)
dev.off()

# ----
# カテゴリ値（c3）と連続値（c2）の分布
png("test8_9_2.png", width=400, height=300)
  plot(d$c3, d$c2)
dev.off()

# カテゴリ値（c3）と連続値（c2）の分布：箱ひげ図
library(ggplot2)
ggplot(d) +
  geom_boxplot(aes(x = c3, y = c2)) +
  ggsave("test8_9_3.png", width=4, height=3, dpi=100)

# カテゴリ値（c3）と連続値（c2）の分布：バイオリンプロット
ggplot(d) +
  geom_violin(aes(x = c3, y = c2)) +
  ggsave("test8_9_4.png", width=4, height=3, dpi=100)

# カテゴリ値（iris.Speces）と連続値（iris.Sepal.Length）の分布：バイオリンプロット＋箱ひげ図
ggplot(iris, aes(x = Species, y = Sepal.Length, fill=Species)) +
  geom_violin() +
  geom_boxplot(width=.2, fill="white")+
  theme_classic() +
  ggsave("test8_9_5.png", width=4, height=3, dpi=100)


# ----
# 連続値（c1）と連続値（c2）の折れ線グラフ：カテゴリ別

# x plot(d$c1, d$c2, type="b")

library(ggplot2)
ggplot(d) +
  geom_line(mapping = aes(x = c1, y = c2, col=c3)) +
  ggsave("test8_9_6.png", width=4, height=3, dpi=100)

# ----------
# 連続値（c1）と連続値（c2）の棒グラフ：カテゴリ別

# 連続値（c1）と連続値（c2）の棒グラフ：カテゴリの和
ggplot(d, aes(x = c1, y = c2)) +
  geom_bar(stat="identity") +
  ggsave("test8_9_7.png", width=4, height=3, dpi=100)

# 連続値（c1）と連続値（c2）の棒グラフ：カテゴリ別積層
ggplot(d, aes(x = c1, y = c2, fill=c3)) +
  geom_bar(stat="identity") +
  ggsave("test8_9_8.png", width=4, height=3, dpi=100)

# 連続値（c1）と連続値（c2）の棒グラフ：カテゴリ別横並び
ggplot(d, aes(x = c1, y = c2, fill=c3)) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggsave("test8_9_9.png", width=4, height=3, dpi=100)

# ----------
# 連続値（iris.Sepal.Width）と連続値（iris.Sepal.Length）の散布図：カテゴリ別

ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length, color=Species)) +
  ggsave("test8_9_10.png", width=4, height=3, dpi=100)


# ----------
# ここは何がしたかったのか不明 ..skip

plot(d0$c0, d$c1, type="b")

library(ggplot2)
ggplot(d0) +
  geom_line(mapping = aes(x = c0, y = c1))

ggplot(d0) +
  geom_line(mapping = aes(x = c0, y = c1, col=c2))

# ###############################################
# ###############################################

## データフレーム（６：連続値とカテゴリ値×２）

c1 = c(1, 1, 2, 3, 5, 8,13,21,35,56,91,147)
c2 = c("a","a","a","a","b","b","b","b","c","c","c","c")
c3 = c("XX", "XX", "XX", "YY", "XX", "XX","XX", "XX", "XX", "YY", "XX", "YY")
d = data.frame(c1,c2=as.factor(c2),c3=as.factor(c3))

#     c1 c2 c3
# 1    1  a XX
# 2    1  a XX
# 3    2  a XX
# 4    3  a YY
# 5    5  b XX
# 6    8  b XX
# 7   13  b XX
# 8   21  b XX
# 9   35  c XX
# 10  56  c YY
# 11  91  c XX
# 12 147  c YY

# カテゴリ列(c2,c3)でグループ化して集計
library(dplyr)
d2 <- d |>
  group_by(c2,c3) |>
  summarise(vn=n(),
            sumc1=sum(c1)) |>
  ungroup()

# # A tibble: 5 × 4
#   c2    c3       vn sumc1
#   <fct> <fct> <int> <dbl>
# 1 a     XX        3     4
# 2 a     YY        1     3
# 3 b     XX        4    47
# 4 c     XX        2   126
# 5 c     YY        2   203

# ==============================
# データの中身を確認する操作

head(d)

#   c1 c2 c3
# 1  1  a XX
# 2  1  a XX
# 3  2  a XX
# 4  3  a YY
# 5  5  b XX
# 6  8  b XX

# ----------

str(d)

# 'data.frame':	12 obs. of  3 variables:
#  $ c1: num  1 1 2 3 5 8 13 21 35 56 ...
#  $ c2: Factor w/ 3 levels "a","b","c": 1 1 1 1 2 2 2 2 3 3 ...
#  $ c3: Factor w/ 2 levels "XX","YY": 1 1 1 2 1 1 1 1 1 2 ...

# ----------

summary(d)

#        c1         c2     c3   
#  Min.   :  1.00   a:4   XX:9  
#  1st Qu.:  2.75   b:4   YY:3  
#  Median : 10.50   c:4         
#  Mean   : 31.92               
#  3rd Qu.: 40.25               
#  Max.   :147.00   

# ----------

table(d)

# , , c3 = XX
# 
#      c2
# c1    a b c
#   1   2 0 0
#   2   1 0 0
#   3   0 0 0
#   5   0 1 0
#   8   0 1 0
#   13  0 1 0
#   21  0 1 0
#   35  0 0 1
#   56  0 0 0
#   91  0 0 1
#   147 0 0 0
# 
# , , c3 = YY
# 
#      c2
# c1    a b c
#   1   0 0 0
#   2   0 0 0
#   3   1 0 0
#   5   0 0 0
#   8   0 0 0
#   13  0 0 0
#   21  0 0 0
#   35  0 0 0
#   56  0 0 1
#   91  0 0 0
#   147 0 0 1

# ==============================

# plot(d)

# ----------
# 連続値（c1）の棒グラフ

png("test8_10_1.png", width=400, height=300)
  barplot(d$c1)
dev.off()

# ----------
# カテゴリ値(c2)と連続値(c1)の分布

library(ggplot2)
ggplot(d, aes(x = c2, y = c1)) +
  geom_bar(stat="identity") +
  ggsave("test8_10_2.png", width=4, height=3, dpi=100)

# カテゴリ値(c2)と連続値(c1)の分布：カテゴリ値(c3)で積層
ggplot(d, aes(x = c2, y = c1, fill=c3)) +
  geom_bar(stat="identity") +
  ggsave("test8_10_3.png", width=4, height=3, dpi=100)

# カテゴリ値(c2)と連続値(c1)の分布：カテゴリ値(c3)で横並び
# - カテゴリ(c3)別に横に並べる場合は別途group_by で集計したデータで描画が必要
ggplot(d2, aes(x = c2, y = sumc1, fill=c3)) +
  geom_bar(stat="identity", position = position_dodge()) +
  ggsave("test8_10_4.png", width=4, height=3, dpi=100)

# ----------

# カテゴリ値(c2)と連続値(c1)の散布図

library(ggplot2)
# カテゴリ値(c2)と連続値(c1)の散布図
ggplot(d) +
  geom_point(aes(x = c2, y = c1)) +
  ggsave("test8_10_5.png", width=4, height=3, dpi=100)

# カテゴリ値(c2)と連続値(c1)の散布図＋カテゴリ値(c3)でマーカ・色変更
ggplot(d) +
  geom_point(aes(x = c2, y = c1, color=c3, pch=c3, size=2)) +
  ggsave("test8_10_6.png", width=4, height=3, dpi=100)

# ----------

# カテゴリ値(c2)と連続値(c1)の箱ひげ図
png("test8_10_7.png", width=400, height=300)
  # boxplot(d$c2, d$c1) # こちらだとX軸が変。NA未対応？
  plot(d$c2, d$c1)
dev.off()

ggplot(d) +
  geom_boxplot(aes(x = c2, y = c1)) +
  ggsave("test8_10_8.png", width=4, height=3, dpi=100)


# カテゴリ値(c2)と連続値(c1)の箱ひげ図＋カテゴリ値(c3)で色分け
ggplot(d) +
  geom_boxplot(aes(x = c2, y = c1, color=c3)) +
  ggsave("test8_10_9.png", width=4, height=3, dpi=100)

# ----------
# カテゴリ値(c2,c3)の組み合わせに対する連続値(c1)の和


# カテゴリ値(c2,c3)の組み合わせに対する連続値(c1)の和：散布図
# 内部でc1の和と取っている。size=c1だと大きすぎる。調整のためlogをとる
ggplot(d) +
  geom_point(aes(x = c2, y = c3), size=log(c1)*3) +
  ggsave("test8_10_10.png", width=4, height=3, dpi=100)

# 集計済みのデータを使った場合と同じ
ggplot(d2) +
  geom_point(aes(x = c2, y = c3), size=log(d2$sumc1)*3) +
  ggsave("test8_10_10_2.png", width=4, height=3, dpi=100)

# (eof)
