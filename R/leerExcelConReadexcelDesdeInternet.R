# Leemos la libreria readxl
library(readxl)
# Declaramos url del archivo de interés
url <- "url_del_excel"
# Declaramos el nombre del archivo que se va a descargar
destfile <- "nombre_del_archivo_excel_destino.xlsx"
# Ejecutamos la acción de descarga
curl::curl_download(url, destfile)
obj <- read_excel(destfile, ...)
