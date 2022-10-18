library(shiny)

prevweights <- rep(1/6, 6)

returnteststat <- function(sim, teststat, nrolls){
  val <- switch(teststat,
                "teststat1" = sum((sim-10)^2),
                "teststat2" = mean((nrolls/6-sim)^2))
  return(val)
}


montecarlo <- function(nrolls, nsims, npvals, weights, teststat){
  pvals <- rep(0, npvals)
  obs.sample <- table(sample(1:6, nrolls, TRUE, weights))
  print(obs.sample)
  print(sum(obs.sample))
  obs.test.stat <- returnteststat(obs.sample, teststat, nrolls)
  for(i in 1:npvals){
    test.stat <- rep(0, nsims)
    for(j in 1:nsims){
      sim <- table(sample(1:6, nrolls, TRUE))
      test.stat[j] <- returnteststat(sim, teststat, nrolls)
    }
    pvals[i] <- mean(test.stat <= obs.test.stat)
  }
  return(pvals)
}

server = function(input, output, session){
  observe({
    weights <- c(input$weight1, input$weight2, input$weight3, input$weight4, input$weight5, input$weight6)
    change <- weights - prevweights
    weights <- weights-(sum(change)-change)/5
    weights <- weights/sum(weights)
    updateSliderInput(session, "weight1", value = weights[1])
    updateSliderInput(session, "weight2", value = weights[2])
    updateSliderInput(session, "weight3", value = weights[3])
    updateSliderInput(session, "weight4", value = weights[4])
    updateSliderInput(session, "weight5", value = weights[5])
    updateSliderInput(session, "weight6", value = weights[6])
    prevweights <<- weights
  })
  
  observeEvent(input$reset, {
    weights <- rep(1/6, 6)
    updateSliderInput(session, "weight1", value = weights[1])
    updateSliderInput(session, "weight2", value = weights[2])
    updateSliderInput(session, "weight3", value = weights[3])
    updateSliderInput(session, "weight4", value = weights[4])
    updateSliderInput(session, "weight5", value = weights[5])
    updateSliderInput(session, "weight6", value = weights[6])
    prevweights <<- weights
  })
  
  observeEvent(input$run, {
    teststat <- input$teststat
    nrolls <- input$nrolls
    nsims <- input$nsims
    npvals <- input$npvals
    weights <- c(input$weight1, input$weight2, input$weight3, input$weight4, input$weight5, input$weight6)
    pvals <- montecarlo(nrolls, nsims, npvals, weights, teststat)
    output$mcplot <- renderPlot(hist(pvals, xlim = c(min(pvals), max(pvals))))
  })
  
  
}
