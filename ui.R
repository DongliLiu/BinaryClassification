library(shiny)

# Define UI for Binary Classfication Application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Binary Classification"),
  
  sidebarLayout(
    sidebarPanel(
      
      # This part is to show the backgroud info. for the users
      h2("Overview"),
      p("This application is to illustrate the basic idea of Binary Classification, with the data from Coursera Course ", 
        a("Master Data Analysis in Excel", 
          href = "https://www.coursera.org/learn/analytics-excel/home/welcome"), "."),
      
      br(),
      
      p("There are totally 20 samples here and sorted descently, you could click ", 
        em("Overview", style = "color:blue"), "tab to have an overview."),
      
      br(),
      
      # Now user shall define the threshold
      sliderInput("t", 
                  "Define Threshold here:", 
                  value = 80,
                  min = 0, 
                  max = 100)
    ),
    
    # Show a tabset
    mainPanel(
      tabsetPanel(type = "tabs", 
                  
                  tabPanel("ConfusionMatrix", 
                           br(),
                           p("Below are key metrics out of confusion matrix:"),
                           tableOutput("confusionmatrix"), 
                           p("For detailed definition and calculation of Confusion Matirx, you could visit",
                             a("Wikipedia", 
                               href = "https://en.wikipedia.org/wiki/Confusion_matrix")), "as well."
                           ),
                  
                  tabPanel("Classified As", 
                           br(),
                           p("The classification result (1 means '+', 0 means '-') according to threshold input are added:"),
                           tableOutput("classified")), 
                  
                  tabPanel("Overview", 
                           br(), 
                           p("Here 1 stands for bomber (i.e. positive, '+'), 0 means seagull (i.e., negative, '-') :"),
                           tableOutput("overview"))
      )
    )
  )
))