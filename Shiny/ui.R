library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("paper"),
  shinyjs::useShinyjs(),
  h1("Get your secret santa topic!"),
  textInput("name", "Name", ""),
  h2(tagList("Talk about:",textOutput("topic"))),
  actionButton("mulligan", "Give me another"),
  actionButton("submit", "This one's fine", class = "btn-primary"),
  h3("Assigned Topics"),
  DT::dataTableOutput("responses", width = "50%")
))
