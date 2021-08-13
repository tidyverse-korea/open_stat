#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Open Statistical Package"),

    # Sidebar with a slider input for number of bins 
    fluidPage( 
        tabsetPanel( 
            tabPanel("Data",  gt_output(outputId = "datasetId")), 
            tabPanel("Statistics", gt_output(outputId = "statisticsId")), 
            tabPanel("Visualization", plotOutput(outputId = "ggplotId"))
        )
    ),

    # Show a plot of the generated distribution
    mainPanel(
        
    )
)

