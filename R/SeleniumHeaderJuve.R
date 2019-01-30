
######################
# P A S O  # 1       #
# Correr el Selenium #
######################
# Navegacion con Selenium
# Inicio del Selenium
library("RSelenium")
rD <- rsDriver(verbose = FALSE)
rD
remDr <- rD$client
remDr$navigate(url)