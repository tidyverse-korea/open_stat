# 제어를 위한 필터 ---------------------------------

filters <- Stack(
    
    tokens = list(childrenGap = 10),
    Toggle.shinyInput("maleOnly", value = TRUE, label = "남성만?")
)

# analysis 페이지 ----------------------------------------------------------

analysis_page <- makePage(
    "단변량 데이터셋",
    "범주형 변수",
    div(
        Stack(
            tokens = list(childrenGap = 10), horizontal = TRUE,
            makeCard("데이터 탐색", filters, size = 4, style = "max-height: 320px"),
            makeCard("데이터셋", gt_output(outputId = "datasetId"), size = 8, style = "max-height: 320px; overflow: auto")
        ),
        uiOutput("visualization"),
        Stack(
            tokens = list(childrenGap = 10), horizontal = TRUE,
            makeCard("기술통계", gt_output(outputId = "gender_stat_gt"), size = 8, style = "max-height: 320px")
        )
    )
)

# UI Structure - Layout ----------------------------------------------------------

header <- tagList(
    img(src = "logo.jpg", width = "100px", class = "logo"),
    div(Text(variant = "xLarge", "오픈 통계 팩키지"), class = "title"),
    CommandBar(
        items = list(
            CommandBarItem("초등", "Upload"),
            CommandBarItem("중등", "Upload"),
            CommandBarItem("고등", "Upload")
        ),
        farItems = list(
            CommandBarItem("Grid view", "Tiles", iconOnly = TRUE),
            CommandBarItem("Info", "Info", iconOnly = TRUE)
        ),
        style = list(width = "100%")))

navigation <- navigation <- Nav(
    groups = list(
        list(links = list(
            list(name = 'Home', url = '#!/', key = 'home', icon = 'Home'),
            list(name = '범주형', url = '#!/other', key = 'analysis', icon = 'AnalyticsReport'),
            list(name = 'bit2r', url = 'https://r2bit.com/', key = 'bit2r', icon = 'GitGraph'),
            list(name = 'R 컨퍼런스', url = 'http://use-r.kr', key = 'rconf', icon = 'WebAppBuilderFragment')
        ))
    ),
    initialSelectedKey = 'home',
    styles = list(
        root = list(
            height = '100%',
            boxSizing = 'border-box',
            overflowY = 'auto'
        )
    )
)

footer <- Stack(
    horizontal = TRUE,
    horizontalAlign = 'space-between',
    tokens = list(childrenGap = 20),
    Text(variant = "medium", "Built with Shiny and Fluent UI", block=TRUE),
    Text(variant = "medium", nowrap = FALSE, "If you'd like to learn more, reach out to us at admin@r2bit.com"),
    Text(variant = "medium", nowrap = FALSE, "All rights reserved.")
)

layout <- function(mainUI){
    div(class = "grid-container",
        div(class = "header", header),
        div(class = "sidenav", navigation),
        div(class = "main", mainUI),
        div(class = "footer", footer)
    )
}


# UI 페이지 ----------------------------------------------------------

ui <- fluentPage(
    tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
    layout(analysis_page),
    tags$head(
        tags$link(href = "style.css", rel = "stylesheet", type = "text/css"))
)

