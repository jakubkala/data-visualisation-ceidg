
library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme=shinytheme('paper'),
  
  # Application title
  titlePanel("title to be considered"),
  
  sidebarLayout(
    sidebarPanel(
       h1("Lorem ipsum"),
       sliderInput("var1",
                   "Var1:",
                   min = 1,
                   max = 50,
                   value = 30),
       
       sliderInput("var2",
                   "Var2:",
                   min = 1,
                   max = 10,
                   value = 1),
       
       sliderInput("var3",
                   "Var3:",
                   min = 1,
                   max = 10,
                   value = 1),
    ),
    
    mainPanel(tabsetPanel(
      tabPanel("Tab1", plotOutput("distPlot")),
      
      tabPanel("Tab2", verbatimTextOutput("var2")),
      
      tabPanel("Tab3")
      
    )
    )
       
  )
))
