#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(googlesheets)
library(tidyverse)

# Source google sheet
table <- "133bR8TbETkIQOJTe-2hcRBno5lf3EoaS6khhIlhkWoc"

# Define the fields we want to save from the form
fields <- c("name")

saveData <- function(data) {
  # Grab the Google Sheet
  sheet <- gs_key(table)
  # Add the data as a new row
  gs_edit_cells(sheet, input = data, anchor = paste0("A", sample(1:14,1)))
}

loadData <- function() {
  # Grab the Google Sheet
  sheet <- gs_key(table)
  # Read the data
  gs_read_csv(sheet)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  # Show the previous topics
  # (update with current response when Submit is clicked)
  output$topics <- DT::renderDataTable({
    input$submit
    loadData()
  })     
})