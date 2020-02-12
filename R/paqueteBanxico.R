# Ejemplo de uso para extraer series de tiempo de Banxico

# Declaramos Token
tkn <- "dcd1dd0f368cffdc9dcb0f8cf211f4a68e2a1efe64087d8721f6938bfe33f8e6"

# Llamamos libreria
library("siebanxicor")

# Setupeamos token
setToken(tkn)

idSeries <- c("SF43718","SF46410","SF46407")
series <- getSeriesData(idSeries, '2016-01-01','2018-07-12')

series[[1]]$date
series[[1]]$value

bd <- cbind.data.frame(series[[1]]$date,
                 series[[1]]$value)




