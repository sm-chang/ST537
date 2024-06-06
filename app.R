library(shiny)
library(bslib)
library(tidyverse)
library(readr)
library(RCurl)


#file <- "https://github.com/sm-chang/ST537/blob/be9307d3c51363a26deea531b86c8307740ea794/NHANES_SC.RData"
#destfile <- "nhanes.RData"
#temp <- tempfile()
#download.file(file,destfile)

nhanes <- load("NHANES_SC.RData")

#read.csv('nhanes_permalink.RData')
#getwd()

#view(nhanes)


# Define UI
ui <- page_sidebar(
  sidebar = sidebar(
    # Select variable for y-axis
    selectInput(
      inputId = "y",
      label = "Y-axis:",
      choices = c("deptotcheck", "age", "logfrsum", "logfr1", "logfr2", "logfr3", "logfr4", "logfr5", "logfr6"),
      selected = "deptotcheck"
    ),
    # Select variable for x-axis
    selectInput(
      inputId = "x",
      label = "X-axis:",
      choices = c("deptotcheck", "age", "logfrsum", "logfr1", "logfr2", "logfr3", "logfr4", "logfr5", "logfr6"),
      selected = "age"
    )
  ),
  # Output: Show scatterplot
  card(plotOutput(outputId = "scatterplot"))
)



# Define server
server <- function(input, output, session) {
  output$scatterplot <- renderPlot({
    ggplot(data = nhanes, aes_string(x = input$x, y = input$y)) +
      geom_point()
  })
}



# Create a Shiny app object
shinyApp(ui = ui, server = server)


