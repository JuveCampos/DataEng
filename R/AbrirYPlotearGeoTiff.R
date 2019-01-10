library(raster)
library(dplyr)
library(ggplot2)

relief <- raster("Ubicacion/Geotiff.tiff") %>%
  as("SpatialPixelsDataFrame") %>% 
  as.data.frame()

(p <- ggplot() +
  # raster comes as the first layer, municipalities on top
  geom_raster(data = relief, aes(x = x, 
                                 y = y, 
                                 alpha = mex))  )

