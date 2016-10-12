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