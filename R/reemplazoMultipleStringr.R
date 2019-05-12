#################################
# Multiple reemplazo de strings #
#################################

# Este codigo es para ya, de una vez por todas, tener una referencia de como 
#  reemplazar multiples vectores de manera selecta. 

# Librerias utiles
library(stringr)
library(dplyr)

# Datos Ejemplo 
fechas_texto <- c("1 Apr 2018",  "1 Aug 2018",  "1 Dec 2018",  "1 Feb 2018",  "1 Jan 2018",  
                  "1 Jul 2018",  "1 Jun 2018",  "1 Mar 2018",  "1 May 2018", 
                  "1 Nov 2018",  "1 Oct 2018",  "1 Sep 2018",  "10 Apr 2018", "10 Aug 2018", 
                  "10 Dec 2018", "10 Feb 2018", "10 Jan 2018", "10 Jul 2018",
                  "10 Jun 2018", "10 Mar 2018")

# Vector Reemplazo
# Meses Reemplazo 
mr <- c("Jan" = "01", 
        "Feb" = "02", 
        "Mar" = "03", 
        "Apr" = "04", 
        "May" = "05", 
        "Jun" = "06", 
        "Jul" = "07", 
        "Aug" = "08",
        "Sep" = "09",
        "Oct" = "10",
        "Nov" = "11",
        "Dec" = "12")

# Comando de reemplazo 
# Pasarle un vector a la funcion str_replace_all() #
str_replace_all( fechas_texto ,          mr           )
                 #Texto         # Vector de Reemplazo
