formato <- function(numero, dgt = 0) {
  format(numero, 
         big.mark = ",", 
         scientific = FALSE, 
         trim = TRUE, 
         digits = dgt)
}


