R Crawler 2
========================================================
author: Miao Chien
date: 10/19
autosize: true
transition: concave
css: custom.css
font-import: http://fonts.googleapis.com/css?family=Proza+Libre
font-family: 'Proza Libre'




使用 RStudio 與下載示範檔案
========================================================

<div class="midcenter" style="margin-left:-500px; margin-top:-300px;">
<img src="img/RStudio.png"></img>
</div>

使用 RStudio 與下載示範檔案
========================================================

進入這個專案的 [github](https://github.com/MiaoChien/R-Crawler)

Clone or download > Download ZIP
![](img/download.png)


使用 RStudio 與下載示範檔案
========================================================

Step1. 將 ZIP 檔解壓縮至指定工作路徑

Step2. 開啟 RStudio File > New Project...

![](img/d1.png)


使用 RStudio 與下載示範檔案
========================================================

</br>
</br>
Step3. 選擇 Existing Directory

![](img/d2.png)

***
</br>
</br>
Step4. 讀入指定的工作路徑 

![](img/d3.png)


所需套件
========================================================
 Pipeline Coding
- magrittr 

Crawler’s toolkits in R
- rvest: a web scraper based on httr and xml2
- httr: toolkit of HTTP methods in R
- XML : XML parser
- xml2: xml parser based on libxml2

Data manipulation
- stringr: string manipulaiton
- data.table: extension of data.frame, a powerful ETL tool in R


安裝所需套件
========================================================
程式碼在 `install_packages.R`


```r
pkg_list <- c("magrittr", "httr", "rvest", "stringr", "data.table","jsonlite", "RSQLite", "devtools")

pkg_new <- pkg_list[!(pkg_list %in% installed.packages()[,"Package"])]

if(length(pkg_new)) install.packages(pkg_new)

if("xmlview" %in% pkg_new) {devtools::install_github("hrbrmstr/xmlview")}

if("data.table" %in% pkg_new) {
    install.packages("data.table", type = "source",
                     repos = "https://Rdatatable.github.io/data.table")
} else if (packageDescription("data.table")$Version < "1.9.7") {
    install.packages("data.table", type = "source", 
                     repos = "https://Rdatatable.github.io/data.table")
}
rm(pkg_new, pkg_list)
```

好用套件介紹：magrittr
=========================================================
[magrittr package document](https://cran.r-project.org/web/packages/magrittr/magrittr.pdf)

<center>
![](img/magrittr.png)
</center>


好用套件介紹：magrittr
=========================================================

![](img/magrittr2.png)

- 把左手邊的參數用 **pipeline** 「 %>% 」傳送到右手邊的函式中

- RStudio 輸入快捷鍵：
    + Windows & Linux：<kbd  class="light">Ctrl</kbd> + <kbd  class="light">Shift</kbd> + <kbd  class="light">M</kbd>
    
    + Mac：<kbd  class="light">⌘</kbd>+ <kbd  class="light">⇧</kbd> + <kbd class="light"> M</kbd>

- Use the dot  **.**   as placeholder in a expression.

    + x %>% f is equivalent to f(x)

    + x %>% f(y) is equivalent to f(x, y)

    + x %>% f %>% g %>% h is equivalent to h(g(f(x)))

    + x %>% f(y, .) is equivalent to f(y, x)

    + x %>% f(y, z = .) is equivalent to f(y, z = x)
    
    
好用套件介紹：magrittr
=========================================================

舉例：


```r
a = 1:3
df = data.frame(a, b=a^2)
rownames(df) = LETTERS[1:3]
vals = lm(b ~ a, data = df)
```

pipe chain 版本


```r
library(magrittr)
vals = 1:3 %>% data.frame(a = ., b = .^2) %>%
  set_rownames(LETTERS[1:3]) %>% lm(b ~ a, data = .)
```


好用套件介紹：data.table
==================================================================

[data.table package document](https://cran.r-project.org/web/packages/data.table/data.table.pdf)

<center>
![](img/datatable.png)
</center>

- 取代內建 data.frame 的好工具

- 運算效率高、節省記憶體

- 資料選取方便


好用套件介紹：data.table
==================================================================
建立 data.table

```r
library(data.table)
DT = data.table(mtcars)
DT %<>% data.table(name = rownames(mtcars), .)
DT 
```

```
                   name  mpg cyl  disp  hp drat    wt  qsec vs am gear
 1:           Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4
 2:       Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4
 3:          Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4
 4:      Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3
 5:   Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3
 6:             Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3
 7:          Duster 360 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3
 8:           Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4
 9:            Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4
10:            Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4
11:           Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4
12:          Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3
13:          Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3
14:         Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3
15:  Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3
16: Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3
17:   Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3
18:            Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4
19:         Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4
20:      Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4
21:       Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3
22:    Dodge Challenger 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3
23:         AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3
24:          Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3
25:    Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3
26:           Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4
27:       Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5
28:        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5
29:      Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5
30:        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5
31:       Maserati Bora 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5
32:          Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4
                   name  mpg cyl  disp  hp drat    wt  qsec vs am gear
    carb
 1:    4
 2:    4
 3:    1
 4:    1
 5:    2
 6:    1
 7:    4
 8:    2
 9:    2
10:    4
11:    4
12:    3
13:    3
14:    3
15:    4
16:    4
17:    4
18:    1
19:    2
20:    1
21:    1
22:    2
23:    2
24:    4
25:    2
26:    1
27:    2
28:    2
29:    4
30:    6
31:    8
32:    2
    carb
```

好用套件介紹：data.table
==================================================================
篩選 data.table

```r
DT[cyl == 8] %>% head
```

```
                 name  mpg cyl  disp  hp drat   wt  qsec vs am gear carb
1:  Hornet Sportabout 18.7   8 360.0 175 3.15 3.44 17.02  0  0    3    2
2:         Duster 360 14.3   8 360.0 245 3.21 3.57 15.84  0  0    3    4
3:         Merc 450SE 16.4   8 275.8 180 3.07 4.07 17.40  0  0    3    3
4:         Merc 450SL 17.3   8 275.8 180 3.07 3.73 17.60  0  0    3    3
5:        Merc 450SLC 15.2   8 275.8 180 3.07 3.78 18.00  0  0    3    3
6: Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.25 17.98  0  0    3    4
```

好用套件介紹：data.table
==================================================================

...


再看一次爬蟲流程
==================================================================
type: pinky

<div class="midcenter" style="margin-left:-500px; margin-top:-300px;">
<img src="img/User-Server.png"></img>
</div>


再看一次爬蟲流程
==================================================================
type: pinky

Step1. **Data**：找出資料藏在哪個 request 裡

- 找到資料頁，想像資料要長什麼樣子，設想產出的資料格式(schema)
- 觀察網頁內容，找到資料所在的 request/response，再一層層往上解析，套上判斷式及迴圈， 完成爬蟲的自動化
  
Step2. **Connector**：拿取資料

- 發送 HTTP request 
- 取得 HTTP response
    
Step3. **Parser**：解析所得資料

- 解析結構化資料（HTML、JSON）
- 解析非結構化資料（strings）

Step4. **Data**：資料處理與儲存


先來看看一個完整的範例
==================================================================

目標：</br>抓取[台灣寺廟網](http://temple.twgod.com/)中，臺北寺廟的「寺廟名稱」、「供奉神祗」與「地址」

完整程式碼放在 `Temples.R`

Step1. 觀察目標網站

Step2. 載入套件、創造要下載的 url


```r
library(httr)
library(magrittr)
library(data.table)
library(rvest)
urls = paste0("http://temple.twgod.com/CwP/P/P",29:40,".html")
```

一個完整的範例
==================================================================
title:false

Step3. 建立一個叫做 `getTable` 的爬蟲函式，可以對每個 url 進行下載

```r
getTable = function(url){

  # Connector: 用 httr::GET() 對目標網址發送 HTTP request 
  res = GET(url)

  # Connetor: 用 httr::content() 取得 HTTP response 的 xml_document
  doc = content(res, as = "parsed", encoding = "utf-8")
  
  
  # Parser: 用 rvest::html_nodes() 解析 xml_document
  a = doc %>% 
    html_nodes(xpath = "//tr/td/div/div//div") %>% 
    html_text()
  
  # Data: 資料處理與儲存
  name = main = addr = vector()
  for(i in 1:length(a)){
    name = c(a[2+4*(i-1)], name)
    main = c(a[3+4*(i-1)], main)
    addr = c(a[4+4*(i-1)], addr)
  }
  
  table = data.table("name"= name,
                     "deities"= main,
                     "addr"= addr) %>% na.omit
  
  return(table)
}
```

一個完整的範例
==================================================================
title:false

將 `getTable` 函式套用在一開始創造的 urls 上，下載所有網址的資料表格

```r
table = 
  lapply(urls, getTable) %>% 
  do.call(rbind, .) %>% 
  .[!duplicated(., by=c("name", "addr"))]

table
```

```
                 name    deities                            addr
  1: 二二八公園福德宮     土地公         臺北市中正區懷寧街109號
  2:           長慶廟   福德正神          臺北市中正區晉江街34號
  3:         蓮雲禪苑 釋迦牟尼佛       臺北市中正區連雲街74巷5號
  4:           南福宮   天上聖母 臺北市中正區和平西路一段55巷1號
  5:           光華寺   觀音菩薩         臺北市中正區水源路157號
 ---                                                            
264:           天恩宮   彌勒古佛   臺北市文山區指南路38巷37之2號
265:           樟山寺   千手觀音      臺北市文山區老泉街45巷29號
266:       木柵集應廟   保儀尊王          臺北市文山區保儀路76號
267:           指南宮   孚佑帝君         臺北市文山區萬壽路115號
268:       木柵忠順廟   保儀尊王          臺北市文山區中崙街13號
```

儲存資料

```r
write.csv(table, file = "tpe_temple.csv")
```


【Connection】發送 HTTP request : GET Method
==================================================================

起手式


```r
library(httr)
res <- GET(
  url = "http://httpbin.org/get",
  add_headers(a = 1, b = 2),
  set_cookies(c = 1, d = 2),
  query = list(q="hihi")
)
```

【Connection】發送 HTTP request : GET Method
==================================================================

GET Method 示範：[PTT Gossiping](https://www.ptt.cc/bbs/Gossiping/index.html)

程式碼放在 `Gossiping.R`


```r
library(magrittr)
library(httr)
library(rvest)

url <- "https://www.ptt.cc/bbs/Gossiping/index.html"
res <- GET(url, set_cookies(over18="1"))  # over18 cookie

res %>%
  content(as = "text", encoding = "UTF-8") %>%
  `Encoding<-`("UTF-8") %>%
  read_html %>%
  html_nodes(css = ".title a") %>%
  html_text()
```

```
 [1] "[問卦] 日皇跟秦王誰比較大"                       
 [2] "Re: [新聞] 男張開雙手嗆「開啊」 所長開槍射中右小"
 [3] "[問卦] 姪女九歲生日要送她什麼?"                  
 [4] "[問卦] \"小朋友\"系列遊戲可以破關到什麼程度?"    
 [5] "Re: [新聞] 港人4成想出走 移民首選台灣"           
 [6] "[新聞] 人魚公主再現！鍾麗緹海洋風喜帖曝光"       
 [7] "[問卦] 米國俗辣如何遊台灣？"                     
 [8] "[新聞] 民進黨1分鐘砍7天國假　學界連署要求重審"   
 [9] "[問卦] 有沒有tsaib8的八卦"                       
[10] "Re: [問卦] 誰 最有資格 開 私人監獄 "             
[11] "Re: [問卦] 手機版PTT是不是已經屌打電腦版了?"     
[12] "Re: [爆卦]北韓高機率發生動亂，有親友在南韓者注意"
[13] "[新聞] 懷疑機車被偷　男持雙刀揮舞與警對峙"       
[14] "[問卦] 有沒有台灣籃球的八卦"                     
[15] "[問卦] 有沒有化核應子的八卦"                     
[16] "[問卦] 音響版和耳機版的鄉民敢挑戰盲測嗎？"       
[17] "[問卦] 蒸魚是最好的烹調手法嗎？"                 
[18] "[問卦] 小s和魏如萱的歌聲你愛哪個"                
[19] "[問卦] 八卦版在想什麼"                           
[20] "[公告] 八卦板板規(2016.08.16)"                   
[21] "[公告] 候選人政見傳送門"                         
[22] "[公告] 八卦版版主選舉─投票開始！"               
[23] "[徵求] 台北至苗栗西湖產業道路的行車紀錄器"       
[24] "[公告] 十月份置底懶叫閒聊區^Q^"                  
```

【Connection】發送 HTTP request : POST Method
==================================================================

起手式


```r
library(httr)

res <- POST(url = "http://httpbin.org/post",
            add_headers(a = 1, b = 2),
            set_cookies(c = 1, d = 2),
            body = "x=hello&y=hihi")  # raw string (need URLencode)

res <- POST(url = "http://httpbin.org/post",
            add_headers(a = 1, b = 2),
            set_cookies(c = 1, d = 2),
            body = list(x = "hello",
                        y = "hihi"), # form data as list
            encode = "form")
```


【Connection】發送 HTTP request : POST Method
==================================================================

POST Method 示範：[___](___)

程式碼放在 `_____.R`




【Connection】發送 HTTP request : 記得帶上通行證
==================================================================
Cookies 


【Connection】發送 HTTP request : 記得帶上通行證
==================================================================
Set Header


【Connection】發送 HTTP request : 檢查是否通行成功
==================================================================
Status Code

【Connection】取得 HTTP response 
==================================================================
The Response Body


【Connection】取得 HTTP response 
==================================================================
Encoding 問題


【Parser】解析所得資料
==================================================================
結構化資料與非結構化資料


【Parser】解析所得資料：結構化資料
==================================================================
title:false

HTML Tree

【Parser】解析所得資料：結構化資料
==================================================================
rvest 套件


【Parser】解析所得資料：非結構化資料
==================================================================
Regular Expression + stringr套件


【Data】資料處理與儲存
==================================================================
- `write.csv`: write data.frame as csv file
- `download.file`: save html, jpeg, etc
- `writeBin`: write binary object into disk
- `RSQLite`: SQLite connector in R

【Data】資料處理與儲存：各種資料庫
==================================================================
- [RSQLite](https://cran.r-project.org/web/packages/RSQLite/RSQLite.pdf)
- [RMySQL](https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf)
- [RPostgreSQL](https://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf)
