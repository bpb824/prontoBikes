require(shiny)
require(leaflet)

fluidPage(
  titlePanel(title = "",windowTitle = "Pronto Bike Share"),
  leafletOutput("leaf", width = "100%",height =400),
  wellPanel(fixedRow(
    column(6,h1(textOutput("update"))),
    column(3,actionButton("refresh","Refresh Data")),
    column(3,radioButtons("type","Color Variable", c("Bikes Available"="ba", "Docks Available"="da")))
  ))
)