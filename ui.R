library(shiny)

ui <- fluidPage(
  titlePanel(""),
  
  sidebarLayout(
    sidebarPanel(
      h3("Dice Weights:"),
      sliderInput("weight1",
                  "1",
                  min = 0,
                  max = 1,
                  value = 1/6),
      sliderInput("weight2",
                  "2",
                  min = 0,
                  max = 1,
                  value = 1/6),
      sliderInput("weight3",
                  "3",
                  min = 0,
                  max = 1,
                  value = 1/6),
      sliderInput("weight4",
                  "4",
                  min = 0,
                  max = 1,
                  value = 1/6),
      sliderInput("weight5",
                  "5",
                  min = 0,
                  max = 1,
                  value = 1/6),
      sliderInput("weight6",
                  "6",
                  min = 0,
                  max = 1,
                  value = 1/6),
      actionButton("reset",
                   "RESET"),
      numericInput("nrolls",
                   "Number of rolls",
                   60,
                   1),
      numericInput("nsims",
                   "Number of Monte-Carlo simulations per p-value",
                   100,
                   0),
      numericInput("npvals",
                   "Number of p-values",
                   100,
                   0),
      selectInput("teststat",
                  "Test statistic",
                  c("Sum of frequency - 10 squared (Example given in Practical 2" = "teststat1",
                    "Mean of the difference of the observed frequency and the expected frequency squared" = "teststat2")),
      actionButton("run",
                   "RUN")
      
    ),
    mainPanel(
      h1("Monte Carlo Dice Testing"),
      h3("An application to demonstrate the power and limitations of Monte Carlo testing, as well as the importance of selecting an appropriate test statistic."),
      h5("See how the displayed histogram changes when you adjust the dice weights and chosen test statistic. Note how changing the number of rolls, simulations per p-value, and p-values change precision of the model."),
      h6("If you have any suggestions for test statistics or find a problem with the program, please email me at: finn.j.gallagher@durham.ac.uk"),
      plotOutput("mcplot")
      
    )
  )
  
)
