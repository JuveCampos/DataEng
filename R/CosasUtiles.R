# Cosas Utiles

# 1. Vector de meses
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", 
           "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")

# Fechas
months <- c("jan", "feb", "mar", "apr", "may", 
                "jun", "jul", "aug", "sep", "oct", "nov", "dec")

# Funcion captura
captura <- function(x) rebus::capture(rebus::one_or_more(rebus::WRD))

# Funcion niveles
niveles <- function(x) levels(as.factor(x))






