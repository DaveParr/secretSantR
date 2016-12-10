library(shiny)
library(shinythemes)

shinyUI(
  fluidPage(
    theme = shinytheme("paper"),
    shinyjs::useShinyjs(),
    h1("Get your secret santa topic!"),
    h2(tagList("Talk about:", textOutput("topic"))),
    wellPanel(
      textInput("name", "Name", ""),
      actionButton("mulligan", "Give me another"),
      actionButton("submit", "This one's fine", class = "btn-primary")
      , width = 300),
    h3("Assigned Topics"),
    DT::dataTableOutput("responses", width = 300)
  )
)
