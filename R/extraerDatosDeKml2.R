# Extraer datos de kml 2


datosDeKml <- function(base, variable = "description"){
  library(rvest)
  library(dplyr)
  library(sf)
  
  # Pruebas
  # base <- ptos
  # variable <- "description"
  
  # Leemos la columna de datos html de interes
  vector <- base %>% as.data.frame() %>% select(variable) 
  
  # Jalamos los datos
  a <- vector[,variable][1] %>% as.vector() %>% minimal_html() %>% html_table(fill = TRUE) 
  vars <- t(a[[2]])[1,] 
  datos <- t(a[[2]])[2,] 
  
  # Creamos los datos
  for (i in 2:length(vector[,variable])){
    a <- vector[,variable][i] %>% as.vector() %>% minimal_html() %>% html_table(fill = TRUE) 
    datos <- rbind(datos, t(a[[2]])[2,]) 
  }
  
  # Generamos los datos
  datos <- as.data.frame(datos) 
  names(datos) <- vars
  
  # Guardamos los datos
  datx <- st_bind_cols(base, datos) 
  
  return(datx)
}
