#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#source("app/read_data.R")
# Define UI for application that draws a histogram
#source('app/read_data.R', local = TRUE)

ui <- fluidPage(theme=shinytheme('paper'),
                
                # Application title
                titlePanel("title to be considered"),
                
                sidebarLayout(
                  sidebarPanel(
                    h1("Lorem ipsum"),
                    
                    selectInput("MainAddressVoivodeship", "Województwo:",
                                MainAddressVoivodeship_unique),
                    
                    
                    sliderInput("DurationOfExistenceInMonths",
                                "DurationOfExistenceInMonths:",
                                min = min(DurationOfExistenceInMonths_unique),
                                max = max(DurationOfExistenceInMonths_unique),
                                value = min(DurationOfExistenceInMonths_unique),
                                step = 1),
                    
                    sliderInput("NoOfLicences",
                                "NoOfLicences:",
                                min = min(NoOfLicences_unique),
                                max = max(NoOfLicences_unique),
                                value = min(NoOfLicences_unique),
                                step = 1),
                    radioButtons("Sex", "Płeć:",
                                 choiceNames = list("Mężczyzna", "Kobieta"),
                                 choiceValues = list(
                                   "M", "F"
                                 )),
                    radioButtons("HasPolishCitizenship", "Obywatelstwo:",
                                 choiceNames = list("polskie", "inne"),
                                 choiceValues = list("True", "False"))
                    
                  ),
                  
                  mainPanel(tabsetPanel(
                    
                    tabPanel("Tab1"),
                    tabPanel("Tab2"),
                    tabPanel("Tab3",
                             verbatimTextOutput("MainAddressVoivodeship"),
                             verbatimTextOutput("HasPolishCitizenship"),
                             verbatimTextOutput("Sex"),
                             verbatimTextOutput("NoOfLicences"),
                             verbatimTextOutput("DurationOfExistenceInMonths"))
                    ))))

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # Tab 3
    output[["MainAddressVoivodeship"]] <- renderPrint({input$MainAddressVoivodeship})
    output[["HasPolishCitizenship"]] <- renderPrint({input$HasPolishCitizenship})
    output[["Sex"]] <- renderPrint({input$Sex})
    output[["NoOfLicences"]] <- renderPrint({input$NoOfLicences})
    output[["DurationOfExistenceInMonths"]] <- renderPrint({input$DurationOfExistenceInMonths})
    
    
    # output$plot1 <- 
}
shinyApp(ui = ui, server = server)

