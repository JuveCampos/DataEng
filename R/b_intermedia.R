# Armamos la función
# La base intermedia es la base que contiene Estado, Indicador, anio inicial y valor inicial
crear_base_intermedia <- function(base, estado = "Aguascalientes"){
  require(dplyr)
  # Base de ultimos anios
  b <- base %>%
    group_by(no, ent) %>%
    summarize(ultimo_anio = max(as.numeric(year)))
  
  # Base de solo informacion del estado particular
  vi <- base %>%
    filter(ent == estado) 
  
  # Base con lo que queremos
  a <- c()
  for (i in 1:nrow(b)){
    a <- rbind(a , vi[(vi$year == b$ultimo_anio[i] & vi$no == i),] )
  }
  return(a)
}



