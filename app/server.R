server <- function(input, output) {
  
  # Tab 3
  output[["DurationOfExistenceInMonths"]] <- renderPrint({input$DurationOfExistenceInMonths})
  
  output[["MainAddressVoivodeship"]] <- renderPrint({input$MainAddressVoivodeship})
  output[["MainAddressCounty"]] <- renderPrint({input$MainAddressCounty})
  output[["MainTERCPopulation"]] <- renderPrint({input$MainTERCPopulation})
  
  output[["PKDMainSection"]] <- renderPrint({input$PKDMainSection})
  output[["PKDMainDivision"]] <- renderPrint({input$PKDMainDivision})
  output[["PKDMainGroup"]] <- renderPrint({input$PKDMainGroup})
  output[["PKDMainClass"]] <- renderPrint({input$PKDMainClass})
  
  output[["HasLicences"]] <- renderPrint({input$HasLicences})
  output[["NoOfLicences"]] <- renderPrint({input$NoOfLicences})

  
  data<-reactive({
    df_final=data.frame(DurationOfExistenceInMonths=as.integer(input$DurationOfExistenceInMonths),
                        MainAddressVoivodeship=as.character(input$MainAddressVoivodeship),
                        MainAddressCounty=as.character(input$MainAddressCounty),
                        MainTERCPopulation=as.integer(input$MainTERCPopulation),
                        PKDMainSection=input$PKDMainSection,
                        PKDMainDivision=input$PKDMainDivision,
                        PKDMainGroup=input$PKDMainGroup,
                        PKDMainClass=input$PKDMainClass,
                        HasLicences=input$HasLicences,
                        NoOfLicences=input$NoOfLicences
                        )})

  
  
  pred=reactive({predict(model,data())$predictions})
  
  output[["Target"]] <- renderPrint(pred())
  output[["printProbability"]] <- renderPrint(paste("Probability of default:", pred()[2]))
  
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
  
  # Static plots
  
  output$DurationOfExistenceInMonths_Plot<-renderPlot({
    (ggplot(data=DurationOfExistenceInMonths_TargetMean,
           aes(x=DurationOfExistenceInMonths, y=Mean, group=1)) +
      geom_line() + 
      geom_point(aes(x=input$DurationOfExistenceInMonths, y=pred()[2]), colour="blue") +
      theme_light())},
    height = 400,
    width = 800)
  
  output$MainAddressVoivodeship_Plot<-renderPlot({
    (ggplot(data=MainAddressVoivodeship_TargetMean,
            aes(x=MainAddressVoivodeship, y=Mean)) + 
       geom_point() + 
       geom_point(aes(x=input$MainAddressVoivodeship, y=pred()[2]), colour="blue") +
       theme_light() + 
       theme(axis.text.x = element_text(angle = 45, hjust = 1)))},
    height = 400,
    width = 800)
  
  
  output$PKDMainSection_Plot<-renderPlot({
    (ggplot(data=PKDMainSection_TargetMean,
            aes(x=PKDMainSection, y=Mean)) + 
       geom_point() + 
       geom_point(aes(x=input$PKDMainSection, y=pred()[2]), colour="blue") +
       theme_light())},
    height = 400,
    width = 800)
  
  
  
}