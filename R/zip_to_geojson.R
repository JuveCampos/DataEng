# ZIP TO GEOJSON

# Esta funcion sirve para convertir archivos zip que contienen .shp en archivos geojson
# Nota! Hay que tener instalados previamente las librerias rebus, stringr y sf

# Unzipeamos los archivos
zip_to_geojson <- function(file, dir = getwd()){
  utils::unzip(file) 
  files <- list.files(dir)
  map <- sf::st_read(files[str_detect(files, ".shp" %R% END)])
  nombre <- paste0(stringr::str_remove(files[stringr::str_detect(files, ".shp" %R% END)], pattern = ".shp"), ".geojson")
  tryCatch(sf::st_write(map, nombre), 
           error = function(e){
             print("Ya existe un archivo .geojson con ese nombre")
           }
  )
  file.remove(list.files(dir)[stringr::str_detect(files, 
                pattern = rebus::or1(c(".dbf", ".prj", ".sbn", '.sbx', '.shp', ".xml", ".shx")))])
}
