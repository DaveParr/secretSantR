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

saveName <- function(data) {
  # Grab the Google Sheet
  sheet <- gs_key(table)
  # Count how many topics are left unassigned
  freetopics <- gs_read_csv(sheet) %>% filter(is.na(name)) %>% count() %>% as.numeric()
  # Add the data in a random cell
  gs_edit_cells(sheet, input = data, anchor = paste0("A", base::sample(2:freetopics,1)))
}

loadFreeTopics <- function() {
  # Grab the Google Sheet
  sheet <- gs_key(table)
  # Read the data and filter where there is a name
  gs_read_csv(sheet) %>% filter(is.na(name))
}

loadAssignedTopics <- function() {
  # Grab the Google Sheet
  sheet <- gs_key(table)
  # Read the data and filter where there is no name
  gs_read_csv(sheet) %>% filter(!is.na(name))
}

shinyServer(function(input, output, session) {
  
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveName(formData())
  })
  
  # Show the available topics
  # (update with current response when Submit is clicked)
  output$freeTopics <- DT::renderDataTable({
    input$submit
    loadFreeTopics()
  })
  
  # Show the unavailble topics
  # (update with current response when Submit is clicked)
  output$assignedTopics <- DT::renderDataTable({
    input$submit
    loadAssignedTopics()
  })     
})