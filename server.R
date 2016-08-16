library(shiny)

shinyServer(function(input, output) {
  
  # Firstly, define the raw data
  
  Score <- c(97, 93, 90, 86, 83, 80, 77, 75, 74, 70, 66, 62, 60, 55, 50, 44, 39, 33, 20, 11)
  BinaryOutcome <- c(0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  
  BinaryTable <- data.frame(Score, as.character(BinaryOutcome))
  names(BinaryTable) <-  c("Score", "Outcome")
  
  Classification <- rep(0, times = 20)
  
  # Secondly, define the Classification result
  BinaryClassification <- reactive({
    Classification[Score >= input$t] = 1
    BinaryClassification <- cbind(BinaryTable, as.factor(Classification))
    names(BinaryClassification) <- c("Score", "Outcome", "Classification")
    BinaryClassification
  })
  
  # Thirdly, define the metrics out of Confusion Matrix
  Metrics <- reactive({
    Classification[Score >= input$t] = 1
    TotalPredictPositive <- sum(Classification)
    
    TotalPositive <- sum(BinaryOutcome)
    TotalNegative <- length(BinaryOutcome) - TotalPositive
    TotalEvent <- TotalPositive + TotalNegative
    TotalPredictNegative <- TotalEvent - TotalPredictPositive
    
    TruePositive <- sum(BinaryOutcome[1:TotalPredictPositive])
    FalsePositive <- TotalPredictPositive - TruePositive
    TrueNegative <- TotalNegative - FalsePositive
    FalseNegative <- TotalPositive - TruePositive
    
    FPrate <- FalsePositive/TotalNegative
    TPrate <- TruePositive/TotalPositive
    TNrate <- TrueNegative/TotalNegative
    FNrate <- FalseNegative/TotalPositive
    PPV <- TruePositive/TotalPredictPositive
    NPV <- TrueNegative/TotalPredictNegative
    
    rbind(FPrate, TPrate, TNrate, FNrate, PPV, NPV)
  })
  
  # Finally, generate the outputs accordingly
  output$classified <- renderTable({
    data.frame(BinaryClassification())
  })
  
  output$confusionmatrix <- renderTable({
    data.frame(Metrics())
  })
  
  output$overview <- renderTable({
    data.frame(BinaryTable)
               })
  
})