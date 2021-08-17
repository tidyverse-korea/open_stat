
server <- function(input, output, session) {
    output$data_table <- renderDataTable({
        random_table(10, 5)
    })
    output$image <- renderImage({
        random_image()
    })
    output$plot <- renderPlotly({
        random_ggplotly()
    })
    output$print <- renderPrint({
        random_print("model")
    })
    output$table <- renderTable({
        random_table(10, 5)
    })
    output$text <- renderText({
        random_text(nwords = 50)
    })
    output$hypo_text <- renderText({
        random_text(nwords = 50)
    })
}
