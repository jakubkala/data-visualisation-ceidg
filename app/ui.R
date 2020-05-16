library(shinythemes)

ui <- fluidPage(theme=shinythemes::shinytheme('paper'),
                
                # Application title
                titlePanel("title to be considered"),
                
                sidebarLayout(
                  sidebarPanel(
                    h1("Dane przedsiębiorstwa"),
                    
                    
                    sliderInput("DurationOfExistenceInMonths",
                                "Długość życia przedsiębiorstwa:",
                                min = min(DurationOfExistenceInMonths_unique),
                                max = max(DurationOfExistenceInMonths_unique),
                                value = min(DurationOfExistenceInMonths_unique),
                                step = 1),
                    
                    selectInput("MainAddressVoivodeship", "Województwo:",
                                MainAddressVoivodeship_unique),
                    
                    selectInput("MainAddressCounty", "Powiat:",
                                MainAddressCounty_unique),
                    
                    selectInput("MainAddressTERC", "Kod TERC",
                                sort(MainAddressTERC_unique)),
                    
                    sliderInput("MainTERCPopulation",
                                "Kod TERC - populacja:",
                                min = min(MainTERCPopulation_unique),
                                max = max(MainTERCPopulation_unique),
                                value = min(MainTERCPopulation_unique),
                                step = 1),
                    
                    
                    selectInput("MainAddressTERC", "Kod TERC",
                                sort(MainAddressTERC_unique)),
                    
                    
                    selectInput("PKDMainSection", "Sekcja PKD",
                                sort(PKDMainSection_unique)),
                    
                    selectInput("PKDMainClass", "Klasa PKD",
                                sort(PKDMainClass_unique)),
                    
                    selectInput("PKDMainGroup", "Grupa PKD",
                                sort(PKDMainGroup_unique))
                    
                  ),
                  
                  mainPanel(tabsetPanel(
                    
                    tabPanel("Tab1",
                             verbatimTextOutput("Target")
                             ),
                            
                    tabPanel("Tab2",
                             plotOutput(outputId = "explainationPlot")
                             ),
                    
                    tabPanel("Tab3",
                             
                             verbatimTextOutput("DurationOfExistenceInMonths"),
                             verbatimTextOutput("MainAddressVoivodeship"),
                             verbatimTextOutput("MainAddressCounty"),
                             verbatimTextOutput("MainAddressTERC"),
                             verbatimTextOutput("MainTERCPopulation"),
                             verbatimTextOutput("PKDMainClass"),
                             verbatimTextOutput("PKDMainGroup"),
                             verbatimTextOutput("PKDMainSection"))
                    
                  ))))