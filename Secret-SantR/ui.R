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
  DT::dataTableOutput("responses", width = 300), tags$hr(),
  textInput("name", "Name", ""),
  checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
  sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
  actionButton("submit", "Submit")
))
