
ui <- navbarPage(
    "A random App / 웹앱",
    shinythemes::themeSelector(),
    includeCSS("www/open_stat_font.css"),
    tabPanel(
            "DT / 인터랙티브 표",
            h1("A Random DT / 인터랙티브 표"),
            dataTableOutput("data_table")),
    tabPanel("Image / 이미지",
             h2("A Random Image / 이미지"),
             plotOutput("image")),
    tabPanel("Plot / 그래프",
             h3("A Random Plot / 그래프"),
             plotlyOutput("plot")),
    tabPanel("Print / 출력 결과",
             p("A Random Print / 출력 결과"),
             verbatimTextOutput("print")),
    tabPanel("Table / 정적 표",
             p("A Random Table / 정적 표"),
             tableOutput("table")),
    tabPanel("Text / 일반 텍스트",
             p("A Random Text/ 일반 텍스트"),
             tableOutput("text"))
)
