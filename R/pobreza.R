options(scipen = 999)

# Librerias
library(tidyverse)
library(rebus)

# Base de datos de los hogares.
bd_hog <- read_csv("conjunto_de_datos_concentradohogar_enigh_2016_ns/conjunto_de_datos/conjunto_de_datos_concentradohogar_enigh_2016_ns.csv", col_types = cols(folioviv = col_character())) %>%
  mutate(id_hogar = paste0(folioviv, "-", foliohog)) %>%
  select(id_hogar, tot_integ, factor)

# Base de datos de los ingresos por persona y concepto.
bd_ing <- read_csv("conjunto_de_datos_ingresos_enigh_2016_ns/conjunto_de_datos/conjunto_de_datos_ingresos_enigh_2016_ns.csv", col_types = cols(folioviv = col_character()))

# Ingreso diario
ing_hogar <- bd_ing %>%
  mutate(id_hogar = paste0(folioviv, "-", foliohog),
         ing_mensual = ing_tri/3) %>%
  group_by(id_hogar) %>%
  summarise(ing_hogar = sum(ing_mensual))


# ----------------- PPP$ and local currency --------------
# PPP used in computation: 8.94021
# Data mean in local currency: 2685.54
# Data mean in PPP$: 315.201
# Poverty line in PPP$/Day: 1.9
# Poverty line in PPP$/Month: 57.7917
# Poverty line in local currency: 492.391
# -------------------------------------------------------

# Mergeamos
bd <-
  merge(bd_hog, ing_hogar, by = "id_hogar") %>%
  mutate(pop = tot_integ * factor) %>%
  mutate(ing_hogar_pc = ing_hogar / tot_integ) %>%
  mutate(ing_hogar_pc_deflac = deflactar(ing_hogar_pc, anio_inicial = 2016, anio_final = 2011))
# %>%
#   filter(ing_hogar_pc_deflac < 492.391)






