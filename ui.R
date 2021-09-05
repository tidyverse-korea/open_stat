# 제어를 위한 필터 ---------------------------------

filters <- Stack(
    
    tokens = list(childrenGap = 10),
    Toggle.shinyInput("maleOnly", value = TRUE, label = "남성만?")
)

# UI 페이지 ----------------------------------------------------------

ui <- fluentPage(
    tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
    Stack(
        tokens = list(childrenGap = 10), horizontal = TRUE,
        makeCard("데이터 탐색", filters, size = 4, style = "max-height: 320px"),
        makeCard("데이터셋", gt_output(outputId = "datasetId"), size = 8, style = "max-height: 320px")
    ),
    uiOutput("analysis")
)
