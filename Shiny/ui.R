library(shiny)

shinyUI(fluidPage(
  h1("Get your secret santa topic!"),
  textInput("name", "Name", ""),
  h2(tagList("Talk about:",textOutput("topic"))),
  actionButton("mulligan", "Give me another"),
  actionButton("submit", "This one's fine")
))
