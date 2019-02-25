# Convertidor de Normales Climatologicas de Conagua a Data Frames


procesa_datos_diarios <- function(url){
  
  require(rebus)
  require(stringr)
  require(dplyr)
  require(reshape)
  
  captura <- function(x) capture(one_or_more(x))
  
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

plot_diarias <- function(nml, Nombre_estacion = ""){
require(lubridate)  
# Sacamos el Periodo    
periodo <- paste0(as.character(min(lubridate::year(nml$FECHA))), 
                  " - ", 
                  as.character(max(lubridate::year(nml$FECHA))))
# Generamos la Grafica
p <-   ggplot(nml, aes(x = nml$FECHA, y = nml$PRECIPITACION)) + 
    geom_line(colour = 'blue') + 
    labs(title="Serie de Tiempo de Precipitación Diaria",
         subtitle=paste0(Nombre_estacion, "Periodo: ", periodo,  ". Nivel Diario"),
         caption="Fuente: Elaboración propia con datos del SMN - CONAGUA, 2019",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) 
# Retornamos la grafica  
return(p)  
}

plot_mensuales <- function(nml, Nombre_estacion = ""){
  require(lubridate)
  require(dplyr)
  # Sacamos el Periodo    
  periodo <- paste0(as.character(min(lubridate::year(nml$FECHA))), 
                    " - ", 
                    as.character(max(lubridate::year(nml$FECHA))))
  # Procesamos la base de datos
  c <- nml
  c$MES  <- month(c$FECHA)
  c$YEAR <- year(c$FECHA) 
  
  c <- c %>%
    group_by(YEAR, MES) %>%
    summarise(prec_anual = sum(na.omit(PRECIPITACION)), 
              TMAX_prom = mean(TMAX), 
              TMIN_prom = mean(TMIN) 
    ) %>%
    mutate(mes_anio = paste("01", MES, YEAR, sep = "/")) %>%
    mutate(mes_year = as.Date(mes_anio, format = "%d/%m/%Y"))
  
  p <- ggplot(data = c, aes(x = c$mes_year, y = c$prec_anual)) + 
    geom_line(colour = 'blue') + 
    labs(title="Serie de Tiempo de Precipitación Mensual",
         subtitle=paste0(Nombre_estacion, "Periodo: ", periodo,  ". Nivel Mensual"),
         caption="Fuente: Elaboración propia con datos del SMN - CONAGUA, 2019",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) 
  return(p)
}

plot_anual <- function(nml, Nombre_estacion = ""){
  require(lubridate)
  require(dplyr)
  # Sacamos el Periodo    
  periodo <- paste0(as.character(min(lubridate::year(nml$FECHA))), 
                    " - ", 
                    as.character(max(lubridate::year(nml$FECHA))))
  # Procesamos la base de datos
  c <- nml
  c$YEAR <- year(c$FECHA) 
  c <- c %>%
    group_by(YEAR) %>%
    summarise(prec_anual = sum(na.omit(PRECIPITACION)), 
              TMAX_prom = mean(TMAX), 
              TMIN_prom = mean(TMIN) 
    ) 
  p <- ggplot(data = c, aes(x = c$YEAR, y = c$prec_anual)) + 
    geom_line(colour = 'blue') + 
    labs(title="Serie de Tiempo de Precipitación Anual",
         subtitle=paste0(Nombre_estacion, "Periodo: ", periodo,  ". Anual"),
         caption="Fuente: Elaboración propia con datos del SMN - CONAGUA, 2019",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) 
  return(p)
  }
