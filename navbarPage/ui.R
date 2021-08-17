ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            navbarPage(
                title = "오픈 통계 팩키지",
                shinythemes::themeSelector(),
                includeCSS("www/open_stat_font.css"),
                navlistPanel(
                    "초등",
                    tabPanel("초등"),
                    "중등",
                    tabPanel("중학교"),
                    tabPanel("고등학교"),
                    "-----",
                    "고등",
                    tabPanel("대학교"),
                    tabPanel("대학원")
                )
            )
        ),
        mainPanel(
            navbarPage(title = "",
                       navbarMenu("주요기능",
                                  tabPanel("Image / 이미지",
                                           h2("A Random Image / 이미지"),
                                           plotOutput("image")),
                                  tabPanel("Print / 출력 결과",
                                           p("A Random Print / 출력 결과"),
                                           verbatimTextOutput("print")),
                                  tabPanel("Text / 일반 텍스트",
                                           p("A Random Text/ 일반 텍스트"),
                                           tableOutput("text"))),
                       navbarMenu("단변량",
                                  tabPanel("DT / 인터랙티브 표",
                                           h1("A Random DT / 인터랙티브 표"),
                                           dataTableOutput("data_table")),
                                  tabPanel("Plot / 그래프",
                                           h3("A Random Plot / 그래프"),
                                           plotlyOutput("plot")),
                                  tabPanel("Table / 정적 표",
                                           p("A Random Table / 정적 표"),
                                           tableOutput("table"))),
                      tabPanel("가설 검정",
                               h2("일반 텍스트"),
                               verbatimTextOutput("hypo_text"))))))

    