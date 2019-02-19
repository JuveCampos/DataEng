# Cosas Utiles

# 1. Vector de meses
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", 
           "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")

# Fechas
months <- c("jan", "feb", "mar", "apr", "may", 
                "jun", "jul", "aug", "sep", "oct", "nov", "dec")

# Meses Reemplazo 
mr <- c("ene" = "01", 
  "feb" = "02", 
  "mar" = "03", 
  "abr" = "04", 
  "may" = "05", 
  "jun" = "06", 
  "jul" = "07", 
  "ago" = "08",
  "sep" = "09",
  "oct" = "10",
  "nov" = "11",
  "dic" = "12")

# Funcion captura
captura <- function(x) rebus::capture(rebus::one_or_more(rebus::WRD))

# Funcion niveles
niveles <- function(x) levels(as.factor(x))

# Funcion captura
captura <- function(x) rebus::capture(rebus::one_or_more(x))

# Estados de Mexico en Mayusculas
estados <- c('AGUASCALIENTES',
  'BAJA CALIFORNIA',
  'BAJA CALIFORNIA SUR',
  'CAMPECHE',
  'CHIAPAS',
  'CHIHUAHUA',
  'CIUDAD DE MÉXICO',
  'COAHUILA DE ZARAGOZA',
  'COLIMA',
  'DURANGO',
  'GUANAJUATO',
  'GUERRERO',
  'HIDALGO',
  'JALISCO',
  'MÉXICO',
  'MICHOACÁN DE OCAMPO',
  'MORELOS',
  'NAYARIT',
  'NUEVO LEÓN',
  'OAXACA',
  'PUEBLA',
  'QUERÉTARO',
  'QUINTANA ROO',
  'SAN LUIS POTOSÍ',
  'SINALOA',
  'SONORA',
  'TABASCO',
  'TAMAULIPAS',
  'TLAXCALA',
  'VERACRUZ DE IGNACIO DE LA LLAVE',
  'YUCATÁN',
  'ZACATECAS')
