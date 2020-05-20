ui <- fluidPage(theme=shinythemes::shinytheme('paper'),
                
                # Application title
                titlePanel("Czy mój biznes przetrwa najbliższy rok?"),
                hr(),
                
                sidebarLayout(
                  sidebarPanel(
                    h4("Dane przedsiębiorstwa"),
                    
                    numericInput("DurationOfExistenceInMonths",
                                "Długość życia przedsiębiorstwa (w miesiącach):",
                                min = min(DurationOfExistenceInMonths_unique),
                                max = max(DurationOfExistenceInMonths_unique),
                                value = min(DurationOfExistenceInMonths_unique),
                                step = 1),
                    
                    selectInput("MainAddressVoivodeship", "Województwo:",
                                MainAddressVoivodeship_unique),
                    
                    selectInput("MainAddressCounty", "Powiat:",
                                MainAddressCounty_unique),
                    
                    numericInput("MainTERCPopulation",
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
                    
                    numericInput("NoOfLicences",
                                "Liczba licencji:",
                                min = min(NoOfLicences_unique),
                                max = max(NoOfLicences_unique),
                                value = min(NoOfLicences_unique),
                                step = 1)
                    
                  ),
                  
                  mainPanel(align = "center",
                            tabsetPanel(
                              
                    tabPanel("Informacje",
                             h4("Opis programu", align = "left"),
                             p("Przedstawiamy Państwu aplikację, która umożliwia uzyskanie predykcji
                             na temat \"Czy mój biznes przetrwa najbliższy rok?\".", align = "left"),
                             p("Do wyznaczenia prawdopodobieństwa przrtrwania został wykorzystany model
                             Random Forest. Dane użyte do treningu zostały pozyskane z Centralnej
                             Ewidencji Działalności Gospodarczej. Zbiór danych dostępny
                             jest pod adresem:", align = "left"),
                             a(href="https://github.com/karabanb/ceidg_datasets/", "https://github.com/karabanb/ceidg_datasets/"),
                             hr(),
                             h4("Instrukcja obsługi", align = "left"),
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
                               tags$li(tags$b("Podobne firmy"),
                                       ": w zakładce przedstawiono wyniki podobnych firm z uwzględnieniem
                                       województwa oraz czasu istnienia."),
                               align = "left"
                             ),
                             hr(),
                             h4("Szczegóły modelu", align = "left"),
                             p(tags$b("Accuracy"), " : 0.8208", align = "left"),
                             hr(),
                             h4("Autorzy", align = "left"),
                             tags$ul(
                               tags$li("Jakub Kała"),
                               tags$li("Michał Bortkiewicz"),
                               tags$li("Krzysztof Spaliński"),
                               align = "left"
                             ),
                             p("Kod projektu znajduje się w repozytorium na Githubie:", align = "left"),
                             a(href="https://github.com/jakubkala/data-visualisation-ceidg", "https://github.com/jakubkala/data-visualisation-ceidg"),
                    ),
                    
                              
                    tabPanel("Prawdopodobieństwo przetrwania",
                             h4("Prawdopodobieństwo przetrwania", align = 'left'),
                             verbatimTextOutput("printProbability"),
                             hr(),
                             h4("Stopa przetrwania w zależności od Długości życia przedsiębiorstwa", align = 'left'),
                             plotOutput(outputId = "DurationOfExistenceInMonths_Plot"),
                             h4("Stopa przetrwania w zależności od województwa", align = 'left'),
                             plotOutput(outputId = "MainAddressVoivodeship_Plot"),
                             h4("Stopa przetrwania w zależności od sekcji PKD", align = 'left'),
                             plotOutput(outputId = "PKDMainSection_Plot")
                             ),
                            
                    tabPanel("XAI - wyjaśnienie predykcji",
                             #actionButton("refreshXAI", "Odśwież wykresy"),
                             # plotOutput(outputId = "explainationPlot"),
                             h4("Wpływ wprowadzonych parametrów na wynik predykcji", align = "left"),
                             p("Wykresy przedstawione poniżej zostały stworzone za pomocą narzędzia DALEX. Więcej informacji
                             na jego temat można znaleźć na stronach: ", align = "left"),
                             a(href="https://github.com/ModelOriented/DALEX", "https://github.com/ModelOriented/DALEX"),
                             p(),
                             a(href="https://pbiecek.github.io/ema", "https://pbiecek.github.io/ema"),
                             hr(),
                             h4("Udział poszczególnych zmiennych w otrzymanej predykcji", align = "left"),
                             plotOutput(outputId = "explainationPlot"),
                             h4("Średnie udziały dla różnych kolejności zmiennych", align = "left"),
                             plotOutput(outputId = "shapleyPlot"),
                             h4(tags$i("Ceteris paribus")," zmiana predykcji w zależności od zmiany zmiennej Długość życia przedsiębiorstwa", align = "left"),
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
                    
                    tabPanel("Podobne firmy",
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
                             h4("Podobne firmy", align = "left"),
                             p("Na wykresie poniżej przedstawione są wyniki podobnych firm z uwzględnieniem podziału na
                               województwa oraz Długość życia przedsiębiorstwa. Aby uzyskać dokładne dane dotyczące pojedynczej
                               firmy, należy kliknąć na nią na wykresie.", align = "left"),
                             hr(),
                             fluidRow(
                               plotlyOutput("p"),
                               tableOutput("table")
                             )
                            )
                    
                  ))))