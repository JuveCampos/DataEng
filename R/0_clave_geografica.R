# Pegar el cero cuando las claves INEGI no se importan bien

bd <- openxlsx::read.xlsx("01_Datos/declaratorias.xlsx") %>% 
  as_tibble() %>% 
  mutate(CVE_ENT = case_when(str_length(Clave.Estado) == 1 ~ paste0('0', Clave.Estado), 
                             str_length(Clave.Estado) == 2 ~ paste0(Clave.Estado)), 
         CVE_MUN = case_when(str_length(Clave.Municipio) == 4 ~ paste0('0', Clave.Municipio), 
                             str_length(Clave.Municipio) == 5 ~ paste0(Clave.Municipio))) %>% 
  select(-Clave.Estado, -Clave.Municipio)
