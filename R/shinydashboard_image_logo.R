# Librerias
library(shinydashboard)
library(shiny)

# Header
dbHeader <- dashboardHeader(title = "Titulo", HTML('<script> document.title = "Internet Tab Name"; </script>'))
# Aca metemos una imagen 
dbHeader$children[[2]]$children <-  tags$a(href='https://juvenalcampos.com',
                                           tags$img(src='https://juvenalcampos.com/sobre_mi_files/logo.png',
                                                    height='60',
                                                    width='60'))

# Body
body <- dashboardBody(
  # ACA ESTA LA MAGIA :P 
  HTML('<script> document.title = "JuvePlataforma"; </script>')
  )

ui <- dashboardPage(
  dbHeader,
  dashboardSidebar(),
  body
)

server <- function(input, output){
  
}

shinyApp(ui, server)
