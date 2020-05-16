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
  
  
  # explaination
  # explaination <- reactive({explain.default(model, data = ceidg[, -1], y = ceidg$Target)})
  explaination <- explain.default(model, data = ceidg[, -1], y = ceidg$Target)
  bd_rf <- reactive({break_down(explaination,
                                data(),
                                keep_distributions = TRUE)})
  output$explainationPlot <- renderPlot(plot(bd_rf()))
  
  
  # shapley
  shap <- reactive({variable_attribution(explaination, 
                               data(), 
                               type = "shap",
                               B = 15)})
  output$shapleyPlot <- renderPlot(plot(shap()))
  
  # ceteris paribus DurationOfExistenceInMonths
  cp_duartion <- reactive({individual_profile(explaination,
                                    new_observation = data())})
  output$ceterisParibusPlot <- renderPlot(plot(cp_duartion(), variables = c("DurationOfExistenceInMonths")))
  
  # diagnostic plot DurationOfExistenceInMonths - some problems with this one
  # diagnostic <- reactive({individual_diagnostics(explaination,
  #                                    data(), 
  #                                    neighbours = 10,
  #                                    variables = c("DurationOfExistenceInMonths"))})
  # output$diagnosticPlot <- renderPlot(plot(diagnostic()))
}