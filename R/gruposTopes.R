# GRUPOS POR TOPES #
# Propuesta para dividir una columna en grupos en base a topes de TRUES.

grupo <- c(1)
for (i in 2:length(bd$var_interes)) {
  if(bd$var_interes[i] == TRUE)  grupo[i] <- grupo[i-1] +1
  if(bd$var_interes[i] == FALSE) grupo[i] <- grupo[i-1]
}
