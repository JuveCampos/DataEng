# Librerias

######################
# P A S O  # 1       #
# Correr el Selenium #
######################
# Navegacion con Selenium
# Inicio del Selenium
library("RSelenium")
library(stringr)
library(rebus)

###### D A T O S ##############################
datos <- read_csv("/home/juve/Escritorio/mpiosZMCM.csv") %>% rbind("Azcapotzalco") 
names(datos) <- "Mpios"
###############################################

#### FUNCIONES ##############################
# Declaramos funciones utiles
extraerTexto <- function(x){
  c <- unlist(lapply(x, function(x){x$getElementText()}))
  c <- unlist(strsplit(c, "[\n]"))
  return(c)
}
captura <- function(x) capture(one_or_more(x))
#############################################
# Activamos el Selenium
rD <- rsDriver(verbose = FALSE)
rD
remDr <- rD$client
remDr$navigate("https://www.google.com/")

# AQUI HACEMOS UNA BUSQIEDA INICIAL Y CONFIGURAMOS LAS HERRAMIENTAS
buscador <- remDr$findElement("class", "gLFyf")
buscador$sendKeysToElement(list(datos$Mpios[1], " inundacion" , key = "enter" ))

Noticias <- remDr$findElements("class", "hdtb-tl") 
Noticias[[1]]$clickElement()

uno <- remDr$findElements("class", "mn-hd-txt")
uno[[2]]$clickElement()

dos <- remDr$findElements("id", "cdrlnk")
dos[[1]]$clickElement()

tres <- remDr$findElements("class", "ktf")
tres[[3]]$sendKeysToElement(list("1/28/2010"))
tres[[4]]$sendKeysToElement(list("1/28/2019", key = "enter"))

Noticias <- remDr$findElements("class", "q") 
Noticias[[3]]$clickElement()

# Busqueda
noticias <- c()
info_adic <- c()

for (i in 19:nrow(datos)[-c(37)]){

  buscador <- remDr$findElement("class", "gsfi")
  buscador$clearElement()
  buscador$sendKeysToElement(list(datos$Mpios[i], " inundacion" , key = "enter" ))
  
  Sys.sleep(runif(1, 1,2))

for (j in 2:10){
  
  # Navegación
  page <- remDr$findElements("class", "fl")
  page[[j]]$clickElement()
  Sys.sleep(runif(1, 2,4))
  
  # E N C A B E Z A D O S #
  headers <- remDr$findElements("css", "h3") %>%
    extraerTexto()
  
  # F E C H A S   y   A U T O R E S #
  fechas_texto <- remDr$findElements("class", "slp") %>% 
    extraerTexto()
  
  # Guardamos dato
  noticias  <- append(noticias, headers)
  info_adic <- c(info_adic, fechas_texto)
  mpio      <- datos$Mpios[i]
  
}  
    
}

i
j
