server <- function(input, output, session) {
    
    # 제어 결과 필터링 리액티브 데이터프레임 ----------------------------
    filtered_gender <- reactive({


        maleOnlyVal <- if (isTRUE(input$maleOnly)) 1 else 0 
        
        filtered_gender <- if(maleOnlyVal == 1) {
            gender %>%
                filter(성별 == "남")
        } else {
            gender
        }
    })
    
    # 1. show dataset ----
    output$datasetId <- render_gt(
        expr = filtered_gender(),
        height = px(600),
        width = px(600)
    )
    
    # Main 산출물 -------------------------------------------------------    
    output$analysis <- renderUI({
        
        Stack(
            tokens = list(childrenGap = 10), horizontal = TRUE,
            makeCard("Top results", div(style="max-height: 500px; overflow: auto", filtered_gender()))
        )
    })
    
}