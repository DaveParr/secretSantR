library(shiny)
library(shinyjs)
library(data.table)
library(googlesheets)

allowedMulligans <- 1
sheet <- "133bR8TbETkIQOJTe-2hcRBno5lf3EoaS6khhIlhkWoc"
topicslist <- as.data.table(gs_read_csv(gs_key(sheet)))
topic <- topicslist[is.na(Name)|Name=="",Topic[sample(.I,1)]]

shinyServer(function(input, output, session) {
  # Initial setup
  output$topic <- renderText(topic)
  name <- reactive(input$name)
  nameavail <- reactive({(!is.null(name())&name()!="")})
  
  # Update action
  submitaction <- function(){
  workingtopicslist <- topicslist
  rowI <- workingtopicslist[, .I[Topic == topic]]
  gs_edit_cells(gs_key(sheet), input = name(), anchor = paste0("B",rowI+1))
  }
  
  # When submit is picked
  observeEvent(input$submit,{
    if(nameavail()){
      disable("submit")
      disable("mulligan")
      submitaction()
      showModal(modalDialog(
        title = "Saved!",
        "Thanks, we have you down for this topic now"
      ))
    } else {
      showModal(modalDialog(
        title = "No name!",
        "Please tell us your name"
      ))
    }
    
  })
  
  # When mulligan is picked
  v <- reactiveValues(mulligan = 0)
  observeEvent(input$mulligan,{
    v$mulligan <- v$mulligan+1
    
    # Within allowed mulligans
    if(v$mulligan<=allowedMulligans){
      topic <<- topicslist[Topic!=topic&(is.na(Name)|Name==""),Topic[sample(.I,1)]]
      output$topic <- renderText(topic)
    }
    
    # mulligans exceeded
    if(v$mulligan>allowedMulligans){
      if(nameavail()){
        disable("submit")
        disable("mulligan")
        submitaction()
        showModal(modalDialog(
          title = "Sorry, no more mulligans.",
          "We've saved this topic for you"
        ))
      } else {
        v$mulligan <- v$mulligan-1
        showModal(modalDialog(
          title = "No name!",
          "Please tell us your name"
        ))
      }
    }
  })
      
})