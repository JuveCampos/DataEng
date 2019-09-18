# Convertir de .csv a .xlsx
library("openxlsx")
write.xlsx(read.csv("Nombre_del.csv"), "Nombre_del.xlsx")  


library(stringr)
# On a loop! 
files <- list.files()[str_detect(string = list.files(), 
                           pattern = ".csv")] %>% 
  str_remove(pattern = ".csv")

for (i in files){
  write.xlsx(read.csv(paste0(i, ".csv")), paste0(i, ".xlsx")) 
}



