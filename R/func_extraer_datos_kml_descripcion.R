# DATOS 

extraer_datos <- function(tp) {
  # ESTA FUNCION EXTRAE DATOS DE OBSERVACIONES CON EL TAG <td> #
  # Para una observacion (celda) nos da un vector con los datos #
  #tp <- a$Description[1]
  
  require(rebus)
  require(stringr)
  captura <- function(x) capture(one_or_more(x))
  
  # Capturando los tags td
  pat_info <-   or1(c("<td>" %R% captura(WRD %R% optional(SPC)) %R% "</td>", 
                      "<td>" %R% captura(optional(PUNCT) %R% optional(DGT)) %R% "</td>", 
                      "</tr>", 
                      "<tr>"
  )) 
  # Capturando las palabras con letras mayusculas
  pat_mayus <- one_or_more(regex("[A-Z]") %R% optional("_" %R% one_or_more(regex("[A-Z]")))) %R% optional(DGT) %R% END
  
  vars <- unlist(str_extract_all(tp, pat_info)) %>%
    str_remove_all(pattern = or1(c("<td>", "</td>", '<tr>')))
  vars <- c("NOM_PTO", vars)
  vars <- vars[vars != ""]
  vars <- vars[-length(vars)]
  str_view(vars, pattern = pat_mayus)
  
  # EXTRAEMOS LOS DATOS
  
  # 1. Extraemos los datos en mayuscula (las variables).
  variables <<- na.omit(str_extract(vars, pat_mayus))
  
  # 2. Escribimos los datos 
  logico <- str_detect(vars, pat_mayus)
  
  grupo <- c(1)
  for (i in 2:length(logico)) {
    if(logico[i] == TRUE)  grupo[i] <- grupo[i-1] + 1
    if(logico[i] == FALSE) grupo[i] <- grupo[i-1]
  }
  
  datos <- cbind(vars, grupo) %>% as.data.frame()
  
  # Armamos una df
  vector_cortado <- split(vars, f = grupo)
  
  data <- c()
  for (i in 1:length(vector_cortado)){
    if(length(vector_cortado[[i]]) == 2){
      data[i] <- NA
    } else if (length(vector_cortado[[i]]) >= 3){
      data[i] <- vector_cortado[[i]][2]
    }
  }
  return(data)
} 


obtener_columnas <- function(col_html){
  ## Esta funcion nos sirve para extraer el DataFrame de los datos contenidos en el HTML 
  ## de la columna "Descripcion" que se obtiene de leer los archivos *.kml transformados (Google Earth)
  ## desde un *.kmz descargado de la seccion del Sistema de información sobre Riesgos
  ## del Atlas Nacional de Riesgos de México.
  
  ### col_html es la columna que contiene la informacion en el formato del ANR
  
  obs <- c()
  for (i in 1:length(col_html)){
    obs <- rbind(obs, extraer_datos(col_html[i]))
  }
  obs <- as.data.frame(obs)
  names(obs) <- variables
  return(obs)
}

