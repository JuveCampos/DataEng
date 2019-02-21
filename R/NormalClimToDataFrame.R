# Convertidor de Normales Climatologicas de Conagua a Data Frames


procesa_datos_diarios <- function(url){
  
  require(rebus)
  require(stringr)
  require(dplyr)
  require(reshape)
  
  # Patrones
  pat_fecha <- START %R% captura(DGT) %R% "/" %R% captura(DGT) %R% "/" %R% captura(DGT)
  
  # Leemos datos 
  nml <- read.delim(url, 
                    fileEncoding = "latin1", 
                    stringsAsFactors = FALSE) %>%
    reshape::rename(c(CNA.SMN.SPMLP.CLIMATOLOGÍA = "Texto"))
  
  datos_num <- nml$Texto[str_detect(nml$Texto, pattern = pat_fecha)]
  length(datos_num)      
  
  aaa <- strsplit(datos_num, " ")
  a <- matrix(nrow = 0, ncol = 5)
  
  ###################################
  # SUPER INEFICIENTE PERO FUNCIONA #
  ###################################
  
  for (i in 1:length(datos_num)){
    a <- rbind(a, aaa[[i]][str_detect(aaa[[i]], "")])
  }
  
  b <- as.data.frame(a)
  b$V1 <- as.Date(b$V1, format = "%d/%m/%Y")
  b$V2 <- tolower(as.character(b$V2)) %>% str_replace(pattern = 'nulo', replacement = "NA") %>% as.numeric()
  b$V3 <- tolower(as.character(b$V3)) %>% str_replace(pattern = 'nulo', replacement = "NA") %>% as.numeric()
  b$V4 <- tolower(as.character(b$V4)) %>% str_replace(pattern = 'nulo', replacement = "NA") %>% as.numeric()
  b$V5 <- tolower(as.character(b$V5)) %>% str_replace(pattern = 'nulo', replacement = "NA") %>% as.numeric()
  
  b <- reshape::rename(b, c(V1='FECHA', V2='PRECIPITACION', V3='EVAPORACION', V4="TMAX", V5="TMIN"))
  
  return(b)
}
