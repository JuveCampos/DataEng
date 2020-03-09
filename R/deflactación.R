# Deflactor
library(tidyverse)

# Obtención del INPC
inpc <- read_csv("D:/Downloads/ca55_2018.csv",
                 locale = locale(encoding = "WINDOWS-1252"),
                                 skip = 11) %>%
  filter(str_length(Fecha) <= 8) %>%
  select(c(1,2)) %>%
  rename(inpc = `583731`) %>%
  mutate(Year = str_sub(Fecha, start = 5L, end = 8L),
         mes = str_sub(Fecha, start = 1L, end = 3L) %>%
           str_replace_all(c("Ene" = "01",
                             "Feb" = "02",
                             "Mar" = "03",
                             "Abr" = "04",
                             "May" = "05",
                             "Jun" = "06",
                             "Jul" = "07",
                             "Ago" = "08",
                             "Sep" = "09",
                             "Oct" = "10",
                             "Nov" = "11",
                             "Dic" = "12")))

# Renta actualizada = Renta inicial x (IPC Final)/(IPC Inicial)

# 1 Peso de 2012 a pesos de 2020
1*(inpc$inpc[inpc$mes == "01" & inpc$Year == 2020]/inpc$inpc[inpc$mes == "01" & inpc$Year == 2012])

# Generamos la función.
deflactar <- function(cantidad = 1,
          mes_inicial = "01",
          anio_inicial = 2012,
          mes_final = "01",
          anio_final = 2020) {

# Cantidad deflactada
cantidad_deflactada <-  cantidad*(inpc$inpc[inpc$mes == mes_final & inpc$Year == anio_final]/inpc$inpc[inpc$mes == mes_inicial & inpc$Year == anio_inicial])
  return(cantidad_deflactada)
}

# Probamos la función
deflactar(cantidad = c(500000),
          anio_final = 2020,
          anio_inicial = 2012)


