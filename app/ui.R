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
                    
                    sliderInput("MainTERCPopulation",
                                "Liczba ludności (wg TERC):",
                                min = min(MainTERCPopulation_unique),
                                max = max(MainTERCPopulation_unique),
                                value = min(MainTERCPopulation_unique),
                                step = 1),
                    
                    selectInput("PKDMainSection", "Sekcja PKD",
                                sort(PKDMainSection_unique)),
                    
                    selectInput("PKDMainDivision", "Dywizja(?) PKD",
                                sort(PKDMainDivision_unique)),
                    
                    selectInput("PKDMainGroup", "Grupa PKD",
                                sort(PKDMainGroup_unique)),
                    
                    selectInput("PKDMainClass", "Klasa PKD",
                                sort(PKDMainClass_unique)),
                    
                    radioButtons("HasLicences", "Licencja:",
                                 c("Tak" = "True",
                                   "Nie" = "False")),
                    
                    sliderInput("NoOfLicences",
                                "Liczba licencji:",
                                min = min(NoOfLicences_unique),
                                max = max(NoOfLicences_unique),
                                value = min(NoOfLicences_unique),
                                step = 1)
                    
                  ),
                  
                  mainPanel(align = "center",
                            tabsetPanel(
                    
                    tabPanel("Tab1",
                             verbatimTextOutput("Target"),
                             verbatimTextOutput("printProbability"),
                             plotOutput(outputId = "DurationOfExistenceInMonths_Plot"),
                             plotOutput(outputId = "MainAddressVoivodeship_Plot"),
                             plotOutput(outputId = "PKDMainSection_Plot")
                             
                             ),
                            
                    tabPanel("Tab2",
                             plotOutput(outputId = "explainationPlot"),
                             plotOutput(outputId = "shapleyPlot"),
                             plotOutput(outputId = "ceterisParibusPlot")
                             #plotOutput(outputId = "diagnosticPlot"),
                             ),
                    
                    tabPanel("Tab3",
                             
                             verbatimTextOutput("DurationOfExistenceInMonths"),
                             verbatimTextOutput("MainAddressVoivodeship"),
                             verbatimTextOutput("MainAddressCounty"),
                             verbatimTextOutput("MainTERCPopulation"),
                             verbatimTextOutput("PKDMainClass"),
                             verbatimTextOutput("PKDMainGroup"),
                             verbatimTextOutput("PKDMainSection"))
                    
                  ))))