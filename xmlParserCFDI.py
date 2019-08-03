#XML IMPORTER CFDI
# Autores: Creditos originales a Florian Chavez
# Modificado por: Juve Campos

###########
# Imports #
###########

# Modulo os: Provee una manera de acceder a las funciones del sistema operativo. 
# Modilo glob: Filename pattern matching, para trabajar con extensiones de archivos.
import os, glob

# Importa la funcion para acceder al seleccionador de archivos del SO
from tkinter.filedialog import askdirectory

# Paquete para trabajar con datos XML
import xml.etree.ElementTree

# Libreria para manejo de bases de datos (dataframes)
import pandas as pd

# SELECT THE DIRECTORY (Selecciona el directorio, carpeta de archivos)
# Acceder al explorador de archivos del SO
path=askdirectory() 
# Cambiar el directorio de trabajo a la ruta especificada
os.chdir(path) 

# Generar un dataframe vacío
df = pd.DataFrame() 

# Inicializamos contador (primer elemento)
first = True

# Loop
for file in glob.glob("*.xml"):
     
     # Obtenemos el objeto XML
     e = xml.etree.ElementTree.parse(file).getroot()
     
     # Extraemos el elemento fecha
     fecha = e.get('Fecha')
     fecha = fecha[:10]
     
     tipoComprobante = e.get('TipoDeComprobante')
     subtotal = e.get('SubTotal')
     total = e.get('Total')
     emisor = e.find('{http://www.sat.gob.mx/cfd/3}Emisor')
     emisor_rfc = emisor.get('Rfc')
     emisor_nombre = emisor.get('Nombre')
     recep = e.find('{http://www.sat.gob.mx/cfd/3}Receptor')
     recep_rfc = recep.get('Rfc')
     recep_nombre = recep.get('Nombre')
     # Generamos el vector de datos
     mydata =[fecha,tipoComprobante,subtotal,total,emisor_rfc,emisor_nombre,recep_rfc,recep_nombre]
     if first==True:
         data =[mydata]
         first = False
     else:
         data.append(mydata)
     
print("__________________________")
print(data)

# Creamos el DataFrame
df=pd.DataFrame(data,columns=['fecha', 'tipoComprobante','subtotal','total','emisorRFC','emisorNombre','receptorRFC','receptorNombre'])
df.to_csv("listComprobantes.csv", sep=',', encoding='utf-8')

# Convertimos el DataFrame a Archivo de Excel
writer = pd.ExcelWriter('listaComprobantes.xlsx', engine='xlsxwriter')
df.to_excel(writer, sheet_name='Sheet1')
writer.save()
