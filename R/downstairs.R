# Downstairs
# Funcion para generar valores hacia abajo cuando no los hay
# Es como bajar un dato en excel
# Autor: Yo mero (@Juvenalcamposf)



downstairs <- function(x){
  for(i in 1:(length(x)-1)){

    if( is.na(x[i+1]) ){
      x[i+1] <- x[i]
    } else {
      x[i+1] <- x[i+1]
    }

  }
  return(x)

}
