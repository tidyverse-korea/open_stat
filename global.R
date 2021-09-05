# * 팩키지 ----------------------------------

library(tidyverse)
library(glue)
library(leaflet)
library(plotly)
library(sass)
library(shiny)
library(shiny.fluent)
library(shiny.router)
# library(statdata)
library(waffle)
library(gt)
library(ggtextures)

# * 도움 함수(Helper Function) ----------------------------------
## * 카드 제작 함수 ----------------------------------

makeCard <- function(title, content, size = 3, style = "") {
    div(
        class = glue::glue("card ms-depth-8 ms-sm{size} ms-xl{size}"),
        style = style,
        Stack(
            tokens = list(childrenGap = 5),
            Text(variant = "large", title, block = TRUE),
            content
        )
    )
}

## * 페이지 제작 함수 ----------------------------------

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

# * 데이터셋 ----------------------------------

# gender <- statdata::gender

gender <- read_csv("www/025원시_성별.csv") %>% 
    set_names("성별")


# * 홈페이지 ----------------------------------

card1 <- makeCard(
    "오픈 통계 팩키지를 소개합니다.",
    div(
        Text("코로나19로 인해 심화된 디지털 불평등과 디지털 경제 전환(Digital Transformation)으로 인해 시민의 필수 역량이 된 Data Literacy 역량 강화를 위해 컴퓨터를 처음 접하거나 데이터 작업이 처음인 대한민국 국민 누구나 쉽게 통계 팩키지를 접할 수 있도록 하고 데이터 프로그래밍 역량도 수준별로 강화할 수 있도록 새로운 형태의 블록 통계 분석을 포함한 초중등 오픈 통계 팩키지 개발을 금번 컨트리뷰션 아카데미 프로그램을 빌어 Tidyverse Korea 멘토와 멘티가 함께 2021년 새로운 여행을 함께 떠나가고자 합니다.")
    ))

card2 <- makeCard(
    "관련 정보",
    div(
        Text("공학 소프트웨어 현황: https://r2bit.com/onboard/tong.html", block = TRUE),
        Text("오픈 통계 팩키지 기여: https://r2bit.com/onboard/ojt.html", block = TRUE),
        Text("한국 R 컨퍼런스: https://use-r.kr/", block = TRUE)
    ))

? Text

home_page <- makePage(
    "다함께 참여하고 활용하는 오픈 소스 소프트웨어",
    "R 사용자회 + Open Up = 오픈 통계 팩키지",
    div(card1, card2)
)

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


# router -------------------------------------------------------------

router <- make_router(
    route("/", home_page),
    route("other", analysis_page))

# Add shiny.router dependencies manually: they are not picked up because they're added in a non-standard way.
shiny::addResourcePath("shiny.router", system.file("www", package = "shiny.router"))
shiny_router_js_src <- file.path("shiny.router", "shiny.router.js")
shiny_router_script_tag <- shiny::tags$script(type = "text/javascript", src = shiny_router_js_src)

