library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # Tab 1
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$var1 + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    # Tab 2
    output[["var2"]] <- renderPrint({input$var2})
    
    # Tab 3
    
  })
  
})
