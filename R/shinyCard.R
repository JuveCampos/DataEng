# Generar tarjetas de imagenes 
# Jorge Juvenal Campos Ferreira
# Con información de la pregunta de la sig. publicación de StackOverflow
# https://stackoverflow.com/questions/57963034/is-it-possible-to-arrange-shiny-app-cards-in-a-masonry-grid

card <- function(img, titulo, pie) {
  HTML(
    paste0(
      '<div class="card">
              <div class="container">
              <h4><b>', titulo, '</b></h4>
              </div>
              <img src="', img, '" style="width:100%">
              <div class="container">
              <h5><i>', pie, '</i></h5>
              </div>
              </div>'
    )
  )
}


