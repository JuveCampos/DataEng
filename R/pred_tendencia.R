# Funcion para pred_escenarios (basica pero efectiva)

# FUNCION #
pred_tendencia_escenarios <- function(valor_inicial, 
                                      anio_inicial, 
                                      valor_final, 
                                      anio_final = 2045){
  require(dplyr)
  # 1. Calculamos la pendiente del caso optimista
  m <- (valor_final - valor_inicial)/(anio_final - anio_inicial)
  
  # 2. Obtenemos la serie de anios faltantes
  anios_proj <- seq(from = anio_inicial, to = anio_final, by = 1)
  
  # 3. Obtenemos los datos faltantes) 
  a <- c()
  for(i in 1:length(anios_proj)-1){
    calculo <- m * i  + valor_inicial
    if(calculo <= 0 ){
      calculo <- 0
    } else {
      calculo <- calculo
    }
    a <- append(a, calculo)
  }
  
  # Juntamos los datos
  datos_optimista <- cbind(anios_proj, a) %>% as.data.frame()
  names(datos_optimista) <- c("Año", "Valor_Proyectado")
  return(datos_optimista)
}

# Prueba con datos de ejemplo
(a <- pred_tendencia_escenarios(valor_inicial =  1000, anio_inicial =  2016, valor_final = 0, anio_final = 2030))

# Prueba Grafica
ggplot(data = a, aes(x = Año, y = jitter(Valor_Proyectado, 5))) + geom_line()
anios <- seq(from = , to = anio_final, by = 1)