#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyApp(ui = fluidPage( 
  # Change theme 
  
  #name title Panel
  titlePanel("Comparison of 2016 and 2020 Olympics marathon records for each rank"),
  
  # Sidebar
  sidebarLayout(
    
    # Widgets for selection
    sidebarPanel(
      # Explanatory text
      p("This Shiny apps allows you to use a slide bar to compare the time of each ranking across 2016 and 2020 Olympics, seperately for men and women."),
      
      br(),
      
      # Radio buttons that allows the user to choose a crime
      radioButtons(inputId = "sex", label = "Select men or women",
                   choices = c("Men", "Women")),
      
      # Input: rank slider with basic animation
      sliderInput("rank", "rank",
                  min = 1, max = 156,
                  value = 1, 
                  step = 1,
                  ticks = FALSE,  # don't show tick marks on slider bar
                  animate = animationOptions(interval = 800) # add play button to animate
      )),
    
    # Main panel
    mainPanel(
      # Plot
      plotOutput("plot"),
      br(), 
      # Message about the state with the most arrests per capita
      textOutput("diff")
    )
  )
),

# Define server logic
server = function(input, output){
  
  # Make the selected plot for the selected crime
  output$plot = renderPlot({
    # Scatterplot for the selected crime
    
    i <- 1
    n <- input$rank+1
    y_diff<- c()
    x_rank<- c()
    
    
    while (i< n) {
      dat_diff <- dat %>% filter(sex == input$sex & rank == i) 
      y_diff <- c(y_diff,  diff(dat_diff$time_sec))
      x_rank <- c(x_rank, i)
      i <- i+1
    }
    
    ggplot() +
      geom_line(aes(x = x_rank, y=y_diff), color = 'blue') +
      scale_y_continuous(limits = c(-1000,1000)) +
      xlab("rank") +
      ylab("difference, Rio time minus Tokyo time")
    
    
  })
  
  # Identify the state with the most arrests per capita for the selected crime
  output$diff = renderText({
    dat_diff <- dat %>% filter(sex == input$sex & rank == input$rank) 
    paste0("For rank ", input$rank, " in ",input$sex, "'s Marathon , ", diff(dat_diff$time_sec) )#ifelse(diff(dat_diff$time_sec)>0, "Tokyo 2020 has a faster record", "Rio 2016 has a faster record"))
  })
})