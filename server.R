# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # 1. show dataset ----
    output$datasetId <- render_gt(
        expr = gender_gt,
        height = px(600),
        width = px(600)
    )
    
    # 2. show descriptive statistics ----
    output$statisticsId <- render_gt(
        expr = gender_stat_gt,
        height = px(600),
        width = px(600)
    )
    
    # 3. show basic ggplot ----
    output$ggplotId <- renderPlot(
        ( gender_barplot_gg + gender_piechart_gg ) / (gender_waffle_gg + gender_image_gg)
    )
}

