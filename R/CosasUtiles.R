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
