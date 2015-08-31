require(shiny)
require(leaflet)

fluidPage(
  titlePanel(title = "",windowTitle = "Pronto Bike Share"),
  leafletOutput("leaf", width = "100%",height =400),
  wellPanel(fixedRow(
    column(10,h3(textOutput("update"))),
    column(2,actionButton("refresh","Refresh Data"))
  ))
)