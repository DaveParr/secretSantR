#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  DT::dataTableOutput("freeTopics", width = 300), tags$hr(),
  textInput("name", "Name", ""),
  actionButton("submit", "Submit"),
  DT::dataTableOutput("assignedTopics", width = 300), tags$hr()
))
