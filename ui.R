

# UI 페이지 ----------------------------------------------------------

ui <- fluentPage(
    layout(router$ui),
    tags$head(
        tags$link(href = "style.css", rel = "stylesheet", type = "text/css"),
        shiny_router_script_tag
    )
)

