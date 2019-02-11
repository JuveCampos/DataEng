# convertidor a imagenes png jpg

# You can do that to transform png to jpg :
library(png)
img <- readPNG("test.png")
library("jpeg")
writeJPEG(img, target = "Converted.jpeg", quality = 1)

# and to transform jpg to png :
library("jpeg")
img <- readJPEG(system.file("img", "img.jpg", package="jpeg"))
library(png)
writePNG(img)
