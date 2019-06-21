# Funcion para abrir y explorar datos de manera automatica

open_sf <- function(dir) {
  shp <- st_read(dir) %>% st_transform(crs = 4326)
  print(head(shp))
  plot(shp, max.plot = 1)
  return(shp)
}

