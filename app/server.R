server <- function(input, output) {
  
  # Tab 3
  output[["DurationOfExistenceInMonths"]] <- renderPrint({input$DurationOfExistenceInMonths})
  
  output[["MainAddressVoivodeship"]] <- renderPrint({input$MainAddressVoivodeship})
  output[["MainAddressCounty"]] <- renderPrint({input$MainAddressCounty})
  output[["MainAddressTERC"]] <- renderPrint({input$MainAddressTERC})
  output[["MainTERCPopulation"]] <- renderPrint({input$MainTERCPopulation})
  
  output[["PKDMainGroup"]] <- renderPrint({input$PKDMainGroup})
  output[["PKDMainSection"]] <- renderPrint({input$PKDMainSection})
  output[["PKDMainClass"]] <- renderPrint({input$PKDMainClass})
  
  
  data<-reactive({
    df_final=data.frame(DurationOfExistenceInMonths=as.integer(input$DurationOfExistenceInMonths),
                        PKDMainClass=as.integer(input$PKDMainClass),
                        MainAddressVoivodeship=as.character(input$MainAddressVoivodeship),
                        MainAddressCounty=as.character(input$MainAddressCounty),
                        MainAddressTERC=as.integer(input$MainAddressTERC),
                        MainTERCPopulation=as.integer(input$MainTERCPopulation),
                        PKDMainGroup=as.integer(input$PKDMainGroup),
                        PKDMainSection=as.character(input$PKDMainSection))})
  
  pred=reactive({predict(model,data())$predictions})
  
  output[["Target"]] <- renderPrint(pred())
  
}