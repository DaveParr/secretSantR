library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  shinythemes::themeSelector(),
  shinyjs::useShinyjs(),
  titlePanel("Get your secret santa topic!"),
  tags$hr(),
  fluidRow(column(
    6,
    h3(tagList("Talk about:", textOutput("topic"))),
    wellPanel(
      textInput("name", "Name", ""),
      actionButton("mulligan", "Give me another"),
      actionButton("submit", "This one's fine", class = "btn-primary")
      ,
      width = 300
    )
  ),
  fluidRow(column(
    6, h3("Assigned Topics"),
    DT::dataTableOutput("responses")
  )))
))
