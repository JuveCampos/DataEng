#####################
# CAMBIO DE NOMBRES #
####################

pacman::p_load("rebus", "stringr") # Manejo de strings
dir <- getwd() # Obtener el directorio del proyecto actual
files <- list.files(dir) # Nombres Actuales
files2 <- str_replace(files, pattern = ".txt" %R% END, replacement = "") #Nuevos nombres
cbind(files, files2) # Checar que hagan match los nombres (que no se haya alterado el orden)
file.rename(from = files, to = files2) # Hacer el cambio de nombres.

