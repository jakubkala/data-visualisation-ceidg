ui <- fluidPage(theme=shinythemes::shinytheme('paper'),
                
                # Application title
                titlePanel("Czy mój biznes przetrwa najbliższy rok?"),
                hr(),
                
                sidebarLayout(
                  sidebarPanel(
                    h4("Dane przedsiębiorstwa"),
                    
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
                                "Liczba ludności miasta / gminy (wg TERC):",
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
                              
                    tabPanel("Informacje",
                             h4("Opis programu"),
                             p("Przedstawiamy Państwu aplikację, która umożliwia uzyskanie predykcji
                             na temat \"Czy mój biznes przetrwa najbliższy rok?\".", align = "left"),
                             p("Do wyznaczenia prawdopodobieństwa przrtrwania został wykorzystany model
                             Random Forest. Dane użyte do treningu zostały pozyskane z Centralnej
                             Ewidencji Działalności Gospodarczej. Zbiór danych dostępny
                             jest pod adresem:", align = "left"),
                             a("https://github.com/karabanb/ceidg_datasets/"),
                             hr(),
                             h4("Instrukcja obsługi"),
                             p("Aby uzyskać predykcję oraz jej wyjaśnienie, należy wprowadzić dane
                               firmy w panelu po lewej stronie, a następnie wybrać zakładkę z interesującymi
                               nas informacjami.", align = "left"),
                             tags$ul(
                               tags$li(tags$b("Prawdopodobieństwo przetwania"),
                                       ": w zakładce przedstawione jest prawdopobieństwo przetrwania naszego 
                                       biznesu."), 
                               tags$li(tags$b("XAI - wyjaśnienie predykcji"),
                                       "(eXplainable AI): w zakładce przedstawione jest wyjaśnie
                                       otrzymanej predykcji."), 
                               tags$li(tags$b("???"),
                                       ": w zakładce przedstawiono ???."),
                               align = "left"
                             )
                    ),
                    
                              
                    tabPanel("Prawdopodobieństwo przetrwania",
                             verbatimTextOutput("printProbability"),
                             plotOutput(outputId = "DurationOfExistenceInMonths_Plot"),
                             plotOutput(outputId = "MainAddressVoivodeship_Plot"),
                             plotOutput(outputId = "PKDMainSection_Plot")
                             
                             ),
                            
                    tabPanel("XAI - wyjaśnienie predykcji",
                             #actionButton("refreshXAI", "Odśwież wykresy"),
                             plotOutput(outputId = "explainationPlot"),
                             plotOutput(outputId = "shapleyPlot"),
                             plotOutput(outputId = "ceterisParibusPlot")
                             #plotOutput(outputId = "diagnosticPlot"),
                             ),
                    # 
                    # tabPanel("Tab3",
                    #          
                    #          verbatimTextOutput("DurationOfExistenceInMonths"),
                    #          verbatimTextOutput("MainAddressVoivodeship"),
                    #          verbatimTextOutput("MainAddressCounty"),
                    #          verbatimTextOutput("MainTERCPopulation"),
                    #          verbatimTextOutput("PKDMainClass"),
                    #          verbatimTextOutput("PKDMainGroup"),
                    #          verbatimTextOutput("PKDMainSection")),
                    
                    tabPanel("Nazwa do zmiany",
                             # fluidRow(
                             #   column(
                             #          width = 12,
                             #          plotOutput("scatterPlot",
                             #                     # Equivalent to: click = clickOpts(id = "plot_click")
                             #                     click = "scatterPlot_click",
                             #                     brush = brushOpts(
                             #                       id = "scatterPlot_brush"
                             #                     )
                             #          )
                             #   )
                             # ),
                             # fluidRow(
                             #   column(width = 6,
                             #          h4("Points near click"),
                             #          verbatimTextOutput("click_info")
                             #   ),
                             #   column(width = 6,
                             #          h4("Brushed points"),
                             #          verbatimTextOutput("brush_info")
                             #   )
                             # ),
                             fluidRow(
                               plotlyOutput("p"),
                               tableOutput("table")
                             )
                            )
                    
                  ))))