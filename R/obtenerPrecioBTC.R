library(rvest)
library(tidyverse)
library(stringr)

# Obtenemos la URL
url <- "https://bitso.com"
info <- read_html(url)
info_stats <- html_nodes(info, ".stat") %>% 
  html_text() %>% 
  str_trim() %>% 
  unlist()

##############
# Precio BTC #
############
(precio_btc <-  info_stats[1] %>% 
    str_remove_all(pattern = "(?:[$,MXN])") %>% 
    as.numeric())
