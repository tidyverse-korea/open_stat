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
    
    count_gender <- reactive({
        filtered_gender() %>% 
            count(성별, name = "명수")
    })
    
    
    # 1. 데이터셋 보이기 ----
    output$datasetId <- render_gt(
        expr = filtered_gender(),
        height = px(600),
        width = px(600)
    )
    
    # 2. 기술통계량 ----
    output$gender_stat_gt <- render_gt(
        filtered_gender() %>% 
            count(성별, name = "명수") %>% 
            mutate(성비 = glue::glue("{명수 / sum(명수) * 100} %")) %>% 
            gt::gt()
    )
    
    # 3. 시각화 ----------------------------------------------------------
    ## 3.1. 막대그래프 ----------------------------------------------------------
    output$barPlotId <- renderPlot({
        count_gender() %>% 
            ggplot(aes(x = 성별, y=명수)) +
            geom_col(width = 0.3, fill = "midnightblue") +
            scale_y_continuous(limits = c(0,10), labels = scales::number_format(accuracy = 1)) +
            labs(x = "성별",
                 y = "명수",
                 title = "중학교 성별 범주형 데이터") +
            theme_bw(base_family = "NanumGothic")
    })
    
    ## 3.2. 원 그래프 ----------------------------------------------------------
    output$piePlotId <- renderPlot({
        count_gender() %>% 
            ggplot(aes(x = "", y=명수, fill = 성별)) +
            geom_bar(width = 1, stat = "identity", color = "white") +
            coord_polar("y", start = 0) +
            geom_text(aes(label = glue::glue("{성별} : {명수}")), 
                      position = position_stack(vjust = 0.5), 
                      family = "NanumGothic",
                      size = 10) +
            theme_void(base_family = "NanumGothic") +
            scale_fill_viridis_d() +
            theme(legend.position = "bottom") +
            labs(title = "중학교 성별 범주형 데이터")
        
    })
    
    ## 3.3. 와플 그래프 ----------------------------------------------------------
    output$wafflePlotId <- renderPlot({
        count_gender() %>% 
            ggplot(aes(fill = 성별, values=명수)) +
            geom_waffle(n_rows = 6, size = 0.33, colour = "white") +
            scale_fill_manual(name = NULL,
                              values = c("#BA182A", "#FF8288"),
                              labels = c("남자", "여자")) +
            coord_equal() +
            theme_void(base_family = "NanumGothic")
    })

    ## 3.4. 이미지 그래프 ----------------------------------------------------------
    output$imagePlotId <- renderPlot({

        count_gender() %>% 
            mutate(image = if_else( str_detect(성별, "남"), list(magick::image_read_svg("https://raw.githubusercontent.com/tidyverse-korea/pkg_doc/master/fig/man-svgrepo-com.svg")),
                                                            list(magick::image_read_svg("https://raw.githubusercontent.com/tidyverse-korea/pkg_doc/master/fig/woman-svgrepo-com.svg")))
            ) %>% 
            ggplot(aes(x = 성별, y=명수, image = image)) +
            geom_isotype_col()  +
            # scale_fill_manual(name = NULL,
            #                   values = c("#BA182A", "#FF8288"),
            #                   labels = c("남자", "여자")) +
            theme_bw(base_family = "NanumGothic")  +
            scale_y_continuous(limits = c(0,10), labels = scales::number_format(accuracy = 1))
        
    })
    
    
    # Main 산출물 -------------------------------------------------------    
    output$visualization <- renderUI({
        
        Stack(
            tokens = list(childrenGap = 10), 
            horizontal = TRUE,
            makeCard("막대 그래프", div(style="max-height: 500px; overflow: auto", plotOutput("barPlotId"))),
            makeCard("원 그래프", div(style="max-height: 500px; overflow: auto", plotOutput("piePlotId"))),
            makeCard("와플 그래프", div(style="max-height: 500px; overflow: auto", plotOutput("wafflePlotId"))),
            makeCard("이미지 그래프", div(style="max-height: 500px; overflow: auto", plotOutput("imagePlotId")))            
        )
    })
    
}

