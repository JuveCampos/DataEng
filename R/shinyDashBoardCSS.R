library(shiny)
library(shinydashboard)
library(htmltools)

# Titulo del Dashboard 
headCSS <- function(nombre, color, logo, height = "30px", size = "1"){
  head <- htmltools::HTML(paste0('<img src="', 
                                 logo, '" alt="" height=',
                                 height, 
                                 '><b style = color:', color, '; size = ', size, ';> ', 
                                 nombre, '</b>'))
  return(head)
}

coats <- c("https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Coat_of_arms_of_Aguascalientes.svg/50px-Coat_of_arms_of_Aguascalientes.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Coat_of_arms_of_Baja_California.svg/50px-Coat_of_arms_of_Baja_California.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Coat_of_arms_of_Baja_California_Sur.svg/50px-Coat_of_arms_of_Baja_California_Sur.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Coat_of_arms_of_Campeche.svg/50px-Coat_of_arms_of_Campeche.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Coat_of_arms_of_Chiapas.svg/50px-Coat_of_arms_of_Chiapas.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Coat_of_arms_of_Chihuahua.svg/50px-Coat_of_arms_of_Chihuahua.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Coat_of_arms_of_Mexican_Federal_District.svg/50px-Coat_of_arms_of_Mexican_Federal_District.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Coat_of_arms_of_Coahuila.svg/50px-Coat_of_arms_of_Coahuila.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Coat_of_arms_of_Colima.svg/50px-Coat_of_arms_of_Colima.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Coat_of_arms_of_Durango.svg/50px-Coat_of_arms_of_Durango.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Escudo_de_armas_de_la_Ciudad_y_Estado_de_Guanajuato.svg/50px-Escudo_de_armas_de_la_Ciudad_y_Estado_de_Guanajuato.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Coat_of_arms_of_Guerrero.svg/50px-Coat_of_arms_of_Guerrero.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Escudo_del_Estado_Libre_y_Soberano_de_Hidalgo.png/60px-Escudo_del_Estado_Libre_y_Soberano_de_Hidalgo.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Coat_of_arms_of_Jalisco.svg/50px-Coat_of_arms_of_Jalisco.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Coat_of_arms_of_Mexico_State.svg/50px-Coat_of_arms_of_Mexico_State.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Escudo_de_Michoacán.png/50px-Escudo_de_Michoacán.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Coat_of_arms_of_Morelos.svg/50px-Coat_of_arms_of_Morelos.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Coat_of_arms_of_Nayarit.svg/50px-Coat_of_arms_of_Nayarit.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Coat_of_arms_of_Nuevo_Leon.svg/50px-Coat_of_arms_of_Nuevo_Leon.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Coat_of_arms_of_Oaxaca.svg/50px-Coat_of_arms_of_Oaxaca.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Coat_of_arms_of_Puebla.svg/50px-Coat_of_arms_of_Puebla.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Coat_of_arms_of_Queretaro.svg/50px-Coat_of_arms_of_Queretaro.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Coat_of_arms_of_Quintana_Roo.svg/50px-Coat_of_arms_of_Quintana_Roo.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Coat_of_arms_of_San_Luis_Potosi.svg/50px-Coat_of_arms_of_San_Luis_Potosi.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Coat_of_arms_of_Sinaloa.svg/50px-Coat_of_arms_of_Sinaloa.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Coat_of_arms_of_Sonora.svg/50px-Coat_of_arms_of_Sonora.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Coat_of_arms_of_Tabasco_%28México%29.svg/50px-Coat_of_arms_of_Tabasco_%28México%29.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Coat_of_arms_of_Tamaulipas.svg/50px-Coat_of_arms_of_Tamaulipas.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Coat_of_arms_of_Tlaxcala.svg/50px-Coat_of_arms_of_Tlaxcala.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Coat_of_arms_of_Veracruz.svg/50px-Coat_of_arms_of_Veracruz.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Coat_of_arms_of_Yucatan.svg/50px-Coat_of_arms_of_Yucatan.svg.png",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Coat_of_arms_of_Zacatecas.svg/50px-Coat_of_arms_of_Zacatecas.svg.png")

# Pruebas
ui <- shinyUI({
  
  #########################
  ## E N C A B E Z A D O ##
  #########################
dbHeader <- dashboardHeader(titleWidth = 350,
    # Titulo
    title = headCSS(nombre = "Simulacion Presupuestaria", color = "red", logo = coats[09]),
    tags$li(a(href = 'https://www.cide.edu',
              img(src = 'https://www.cide.edu/wp-content/themes/cide_general/img/logo_cide.png',
                  title = "CIDE", height = "30px"),
              style = "padding-top:10px; padding-bottom:10px;"),
            class = "dropdown"),
    tags$li(a(href = 'http://lnpp.cide.edu',
              img(src = 'http://lnpp.cide.edu/wp-content/themes/lnpp/images/logo.svg',
                  title = "LNPP", height = "30px"),
              style = "padding-top:10px; padding-bottom:10px;"),
            class = "dropdown")
    )
  
#################  
# BARRA LATERAL #
#################
sidebar <- dashboardSidebar(
    width = 350, 
    sidebarMenu(
      menuItem("Introducción", tabName = "INTRO"), 
      menuItem("Entidades Federativas", tabName = "ENT", 
               menuSubItem(headCSS(nombre = " Ciudad de México", color = "black", logo = coats[7], height = "20px"), 
                           tabName = "entCDMX")
               ), 
      menuItem("Comparativas", tabName = "COMP", 
               menuSubItem("Comparativas en el tiempo", tabName =  "compTIEMPO"), 
               menuSubItem("Comparativas entre estados", tabName = "compEDOS")       
               ), 
      menuItem("Simulación", tabName = "SIM", 
               menuSubItem("Herramientas de Simulación", "simHERRAMIENTAS")         
               )
  )
)
  
body <- dashboardBody(
tags$head(tags$style(HTML('
     /* color barra de fondo */
		 .skin-black .main-sidebar {
		 background-color: white;
		 }
		 
		 /* Tab seleccionada activa */
		 .skin-black .main-sidebar .sidebar .sidebar-menu .active a{
		 background-color: #cccccc;
		 }
		 
		 /* Tab no seleccionadas */
		 .skin-black .main-sidebar .sidebar .sidebar-menu a{
		 background-color: #e2e2e2;
		 color: black;
		 }
		 
		 /* tabs hovereadas */
		 .skin-black .main-sidebar .sidebar .sidebar-menu a:hover{
		 background-color: white;
		 }
		 
		 /* treemap color base  */                   
		 .skin-black .main-sidebar .sidebar .sidebar-menu .treeview-menu a{
		 background-color: red;
		 }
		 
		 /* treemap color hover  */                   
		 .skin-black .main-sidebar .sidebar .sidebar-menu .treeview-menu a:hover{
		 background-color: green;
		 }
		 
		 /* treemap color seleccionado  */                   
		 .skin-black .main-sidebar .sidebar .sidebar-menu .treeview-menu .active a{
		 background-color: blue;
		 }
		 
		 
		 /* background del boton toggle  */                    
		 .skin-black .main-header .navbar .sidebar-toggle:hover{
		 background-color: white;
		 }

    p {
    font-family: Poppins;
    text-align: justify;
    }


body {
    margin: 0;
    font-family: Poppins-Bold;
}

.hero {
    /* Sizing */
    width: 100vw;
    height: 40vh;
    font-family: Asap-Bold;
    
    /* Flexbox stuff */
    display: flex;
    justify-content: left;
    align-items: center;
    
    /* Text styles */
    text-align: left;
     /* ADD THIS LINE */
    -webkit-text-fill-color: red;
    -webkit-text-stroke: 1px black;
    
    /* Background styles */
    background-image: url("https://www.scentiaalliance.com/wp-content/uploads/2018/11/PRESUPUESTO-PERSONAL.jpg");
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}

.hero h1 {
    /* Text styles */
    font-size: 5em;
    
    /* Margins */
    margin-top: 0;
    margin-bottom: 0.5em;
}

.hero .btn {
    /* Positioning and sizing */
    display: block;
    width: 200px;
    
    /* Padding and margins */
    padding: 1em;
    margin-top: 50px;
    margin-left: auto;
    margin-right: auto;
    
    /* Text styles */
    color: red; /* CHANGE THIS LINE */
    text-decoration: none;
    font-size: 1.5em;
    
    /* Border styles */
    border: 3px solid white; /* CHANGE THIS LINE */
    border-radius: 20px;
}

		 '))), # Fin del CSS manual
    
tabItems(
  tabItem("INTRO", 
    HTML('<section class="hero">
        <div class="hero-inner">
            <h1>&nbsp&nbspSimulación Presupuestaria</h1>
            <h2>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspProyecto de Estancia de Verano en el LNPP - CIDE</h2>
        </div>
    </section>'), 
    HTML('
<br>    
<b>The standard Lorem Ipsum passage, used since the 1500s</b>
<p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
<b>Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</b>
<p>"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"</p>
<b>1914 translation by H. Rackham</b>
<p>"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"</p>
<b>Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</b>
<p>"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."</p>
<b>1914 translation by H. Rackham</b>
<p>"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."</p>
         ')
    
  ),  # Fin de Intro
  
  tabItem("entCDMX", 
    HTML("<h1>Ciudad de México</h1>"),
    
    fluidPage(
      fluidRow(
        column(12, box(title = "Presupuesto por Finalidad / Funcion", 
                          status = 'warning', 
                          solidHeader = TRUE,  
                          width = "100%", 
                          collapsible = TRUE, 
                          shinycssloaders::withSpinner(highchartOutput("tm", width = 1000, height = 500))
         ) # FIn del Box
        )
      )
    )
  )
) # Fin del tabItems    

  ) # Fin del body

dashboardPage(dbHeader, sidebar, body, skin = 'black')
  
})

##############
## Servidor ##
##############
server <- function(input, output){
  
  # 1. treemap
  output$tm <- highcharter::renderHighchart({
    # Treemap
    tm <- treemap::treemap(monto_finalidad.funcion,
                           index = c("DESCRIPCION_FINALIDAD", "DESCRIPCION_FUNCION"), 
                           vSize = "suma",
                           vColor = "DESCRIPCION_FINALIDAD",
                           draw = FALSE,
                           fontfamily.title  = "Poppins",
                           fontsize.labels = 1,
                           palette = wes_palettes$Cavalcanti1)
    
    hctreemap(tm, allowDrillToNode = TRUE, layoutAlgorithm = "squarified") %>%
      hc_title(text = headCSS(nombre = " Ciudad de México", color = "black", logo = coats[7], height = "20px")) %>% 
      hc_tooltip(pointFormat = "<b>{point.name}</b><br>
                                 Presupuesto: $ {point.value:,.0f}<br>")
  })
  
  
}

shinyApp(ui, server)

