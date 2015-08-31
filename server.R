require(shiny)
require(leaflet)
require(sp)
require(httr)
source("functions.R")
url <- 'https://secure.prontocycleshare.com/data/stations.json'

function(input, output, session) {
  
  data <- content(GET(url), as="parsed")
  stations = list2shape(data$stations)
  
  time = as.POSIXct(data$timestamp/1000, origin="1970-01-01",tz="America/Los_Angeles")
  output$update = renderText({
    paste0("Update Timestamp: ",as.character(time))
  })
  
  pal <- colorNumeric(
    palette = c("Red","Yellow","Green"),
    domain = c(0,1)
  )
  
  htmlGen = function(shape){
    html = paste0("<b>",shape$s,"</b><br>",
                  "Bikes Available: ",shape$ba,"<br>",
                  "Docks Available: ",shape$da
    )
  }
  
  output$leaf <- renderLeaflet({
    map = leaflet()%>%
      setView(-122.3359058, 47.614848, zoom = 13) %>%
      addProviderTiles("CartoDB.DarkMatter",
                       options = providerTileOptions(noWrap = TRUE)
      ) %>% addLegend(position = "bottomright", pal =pal, values = c(0,1),title ="% of Bikes Available",labFormat = labelFormat(
        suffix = '%', between = ', ',
        transform = function(x) 100 * x
      ))
  })
  
  proxy = leafletProxy("leaf",data = stations) %>% addCircleMarkers(layerId =~id, fillColor = ~pal(ba/(ba+da)),stroke=FALSE,fillOpacity = 0.5, popup = htmlGen(stations))
  
  observeEvent(input$refresh,{
    data <- content(GET(url), as="parsed")
    time = as.POSIXct(data$timestamp/1000, origin="1970-01-01",tz="America/Los_Angeles")
    output$update = renderText({
      paste0("Update Timestamp: ",as.character(time))
    })
    stations = list2shape(data$stations)
    proxy = leafletProxy("leaf",data = stations) %>% addCircleMarkers(layerId =~id,fillColor = ~pal(ba/(ba+da)),stroke=FALSE,fillOpacity = 0.5, popup = htmlGen(stations))
  })
  
  
}
