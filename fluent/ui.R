filters <- tagList(
    DatePicker.shinyInput("fromDate", value = as.Date('2020/01/01'), label = "시작일"),
    DatePicker.shinyInput("toDate", value = as.Date('2020/12/31'), label = "종료일")
)

makeCard <- function(title, content, size = 12, style = "") {
    div(
        class = glue("card ms-depth-8 ms-sm{size} ms-xl{size}"),
        style = style,
        Stack(
            tokens = list(childrenGap = 5),
            Text(variant = "large", title, block = TRUE),
            content
        )
    )
}

makePage <- function (title, subtitle, contents) {
    tagList(div(
        class = "page-title",
        span(title, class = "ms-fontSize-32 ms-fontWeight-semibold", style =
                 "color: #323130"),
        span(subtitle, class = "ms-fontSize-14 ms-fontWeight-regular", style =
                 "color: #605E5C; margin: 14px;")
    ),
    contents)
}

analysis_page <- makePage(
    "주요 기능",
    "단변량 범주형 변수",
    div(
        Stack(
            horizontal = TRUE,
            tokens = list(childrenGap = 10),
            makeCard("기간 설정", filters, size = 4, style = "max-height: 320px"),
            makeCard("정적 테이블(표)", tableOutput("table"), size = 8, style = "max-height: 320px")
        ),
        plotlyOutput("analysis"),
        Stack(
            horizontal = TRUE,
            tokens = list(childrenGap = 100),
            plotOutput("image"),
            dataTableOutput("data_table")
        ),
        verbatimTextOutput("print")
    )
)



header <- tagList(
    img(src = "r2bit.png", class = "logo", width = "50"),
    div(Text(variant = "xLarge", "한국형 오픈 통계 팩키지"), class = "title"),
    CommandBar(
        items = list(
            CommandBarItem("New", "Add", subitems = list(
                CommandBarItem("Email message", "Mail", key = "emailMessage", href = "mailto:me@example.com"),
                CommandBarItem("Calendar event", "Calendar", key = "calendarEvent")
            )),
            CommandBarItem("데이터 가져오기", "Upload"),
            CommandBarItem("분석과 시각화", "Share"),
            CommandBarItem("보고서 다운로드", "Download")
        ),
        farItems = list(
            CommandBarItem("Grid view", "Tiles", iconOnly = TRUE),
            CommandBarItem("Info", "Info", iconOnly = TRUE)
        ),
        style = list(width = "100%"))
    )

navigation <- Nav(
    groups = list(
        list(links = list(
            list(name = '홈', url = '#!/', key = 'home', icon = 'Home'),
            list(name = 'Analysis', url = '#!/other', key = 'analysis', icon = 'AnalyticsReport'),
            list(name = 'shiny.fluent', url = 'http://github.com/Appsilon/shiny.fluent', key = 'repo', icon = 'GitGraph'),
            list(name = 'shiny.react', url = 'http://github.com/Appsilon/shiny.react', key = 'shinyreact', icon = 'GitGraph'),
            list(name = 'bit2R', url = 'https://r2bit.com/', key = 'bit2r', icon = 'WebAppBuilderFragment')
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
    Text(variant = "medium", "Built with ❤ by Appsilon", block=TRUE),
    Text(variant = "medium", nowrap = FALSE, "문의사항이나 의견이 계시면 admin@bit2r.com 으로 연락주세요."),
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

ui <- fluentPage(
    layout(analysis_page),
    tags$head(
        tags$link(href = "open_stat_style.css", rel = "stylesheet", type = "text/css")
    )
)



