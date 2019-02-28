# Convertidor de Normales Climatologicas de Conagua a Data Frames

# Funcion extraída de la ayuda de Character Translation and Casefolding
capwords <- function(s, strict = TRUE) {
  cap <- function(s) paste(toupper(substring(s, 1, 1)),
                           {s <- substring(s, 2); if(strict) tolower(s) else s},
                           sep = "", collapse = " " )
  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
}

procesa_datos_diarios <- function(url){
  
  require(rebus)
  require(stringr)
  require(dplyr)
  require(reshape)
  captura <- function(x) capture(one_or_more(x))
  
  # Patrones
  cc1 <- char_class("()")
  pat_fecha <- START %R% captura(DGT) %R% "/" %R% captura(DGT) %R% "/" %R% captura(DGT) # Detecta el inicio de los datos numericos
  pat <- or1(c(captura(DGT) %R% END, captura(one_or_more(WRD %R% SPC %R% optional(cc1) %R% WRD %R% optional(cc1))) %R% END)) # Detecta el nombre y ID de la estacion 
  
  # Leemos datos 
  nml <- read.delim(url, 
                    fileEncoding = "latin1", 
                    stringsAsFactors = FALSE) %>%
    reshape::rename(c(CNA.SMN.SPMLP.CLIMATOLOGÍA = "Texto"))
  
  datos_num <- nml$Texto[str_detect(nml$Texto, pattern = pat_fecha)]
  datos_id <- nml$Texto[str_detect(nml$Texto, pattern =  or1(c("NOMBRE " %R% captura(SPC) %R% ":", "ESTACIÓN ")))]
  id_y_nombre_estacion <<- capwords(str_extract(datos_id, pat) %>% str_remove(pat = START %R% " "), strict = TRUE)
  #length(datos_num)      
  
  
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
  
  # Metemos los huecos!
  all_days <- seq.Date(from = min(b$FECHA), to = max(b$FECHA), by = "day") %>% 
    as.data.frame()
  names(all_days) <- "FECHA"
  
  # Rellenamos los huecos
  b <- left_join(all_days, b, by = 'FECHA') 
  
  return(b)
}

# GRAFICAS DE DATOS DIARIOS
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
         subtitle=paste0(Nombre_estacion, " Periodo: ", periodo,  ". Nivel Diario"),
         caption="FUENTE: SMN - CONAGUA. Registros Diarios meteorológicos disponibles en febrero del 2019.\n https://smn.cna.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) + 
  scale_x_date(date_labels = "%Y", 
               date_breaks = "10 year") 

# Retornamos la grafica  
return(p)  
}

# GRAFICAS DE DATOS MENSUALES
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
    summarise(prec_anual = sum(PRECIPITACION), 
              TMAX_prom = mean(TMAX), 
              TMIN_prom = mean(TMIN) 
    ) %>%
    mutate(mes_anio = paste("01", MES, YEAR, sep = "/")) %>%
    mutate(mes_year = as.Date(mes_anio, format = "%d/%m/%Y"))
  
  p <- ggplot(data = c, aes(x = c$mes_year, y = c$prec_anual)) + 
    geom_line(colour = 'blue') + 
    labs(title="Serie de Tiempo de Precipitación Mensual",
         subtitle=paste0(Nombre_estacion, " Periodo: ", periodo,  ". Nivel Mensual"),
         caption="FUENTE: SMN - CONAGUA. Registros Diarios meteorológicos disponibles en febrero del 2019.\n https://smn.cna.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) + 
    scale_x_date(date_labels = "%Y", 
            date_breaks = "10 year") 
  
  return(p)
}

# GRAFICAS DE DATOS ANUALES
plot_anual <- function(nml, Nombre_estacion = ""){
  require(lubridate)
  require(dplyr)
  #nml <- datos_meteo_cdmx
  #Nombre_estacion <- "Vaya vaya tacubaya"
  # Sacamos el Periodo    
  periodo <- paste0(as.character(min(lubridate::year(nml$FECHA))), 
                    " - ", 
                    as.character(max(lubridate::year(nml$FECHA))))
  # Procesamos la base de datos
  c <- nml
  c$YEAR <- year(c$FECHA) 
  c <- c %>%
    group_by(YEAR) %>%
    summarise(prec_anual = sum(PRECIPITACION), 
              TMAX_prom = mean(TMAX), 
              TMIN_prom = mean(TMIN) 
    ) 
  
  p <- ggplot(data = c, aes(x = c$YEAR, y = c$prec_anual)) + 
    geom_line(colour = 'blue') + 
    labs(title="Serie de Tiempo de Precipitación Anual",
         subtitle=paste0(Nombre_estacion, " Periodo: ", periodo,  ". Anual"),
         caption="FUENTE: SMN - CONAGUA. Registros Diarios meteorológicos disponibles en febrero del 2019.\n https://smn.cna.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica",
         y="Precipitación (mm)" , x = "") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
          panel.grid.minor = element_blank()) + 
    scale_x_continuous(breaks = c(1860, 1870, 1880, 1890, 1900, 1910, 1920, 1930, 1940, 1950, 
                                  1960, 1970, 1980, 1990, 2000, 2010, 2020)) 
  
  p
  return(p)
  }
