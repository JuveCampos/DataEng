# Función para extraer datos de una reg lineal!

reg_lin <- function(anio_init, anio_fin, valor_init, valor_final){
    # Recordando la funcion de la pendiente m = (y_2 - y_1/x_2 - x_1)
    m <- (valor_final - valor_init)/(anio_fin - anio_init)
    # Ecuacion de la recta: y = mx + b
    x <- c()
    x[1] <- anio_init + 1
    for (i in 2:(anio_fin - anio_init)){
      x[i] <- x[i - 1] + 1
    }
    y = m * (x - anio_init)
    dato <- cbind(x, y) %>% as.data.frame()
    return(dato)
}

