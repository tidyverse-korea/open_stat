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

# 카드 제작 함수 ----------------------------------

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

# 페이지 제작 함수 ----------------------------------

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

# 1. Dataset ----

# gender <- statdata::gender

gender <- read_csv("www/025원시_성별.csv") %>% 
    set_names("성별")




