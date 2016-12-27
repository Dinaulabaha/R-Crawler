install.packages("data.table")
install.packages("rvest")
library(httr)
library(magrittr)
library(data.table)
library(rvest)

urls = paste0("http://temple.twgod.com/CwP/P/P",29:40,".html")

getTable = function(url){
  
  # Connector: 用 httr::GET() 對目標網址發送 HTTP request 
  res = GET(url)
  
  # Connetor: 用 httr::content() 取得 HTTP response 的 xml_document
  doc = content(res, as = "parsed", encoding = "utf-8")
  
  
  # Parser: 用 rvest::html_nodes() 解析 xml_document
  a = doc %>% 
    html_nodes(xpath = "//tr/td/div/div//div") %>% 
    html_text()
  
  # Data: 整理資料
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


table = lapply(urls, getTable) %>% 
  do.call(rbind, .) %>% 
  .[!duplicated(., by=c("name", "addr"))]

table

write.csv(table, file = "tpe_temple.csv")