library(shiny)
library(geosphere)


ui <-  fluidPage(tags$head(tags$script(src="map_rectonly.js")),
                 tags$body(tags$div(id="map", style="width: 500px; height: 400px;")),
                 includeScript("https://maps.googleapis.com/maps/api/js?key=AIzaSyDG8Gy_kG7dfrQvJDEAV6HHqU8rlm1a0P8&libraries=drawing&callback=initMap"),
                 textOutput("acres"))

server <- function(input, output, session) {

  output$acres <- renderPrint({
    if(is.null(input$SWlng)){return()}
    nw <- c(input$SWlng,input$NElat)
    ne <- c(input$NElng,input$NElat)
    se <- c(input$NElng,input$SWlat)
    sw <- c(input$SWlng,input$SWlat)
    coords <- rbind(nw,ne,se,sw)
    sqm <- areaPolygon(coords, a=6378137, f=1/298.257223563)
    acres <- sqm * 0.000247105
    return(acres)
    })
}

shinyApp(ui, server)

