# Forma Tidy de renombrar variables

bd <- bd %>%
  reshape::rename(c(var1 = "nuevoNombreVar1", var2 = "nuevoNombreVar2", var3 = "nuevoNombreVar3"))
