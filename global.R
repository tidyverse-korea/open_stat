library(dplyr)
library(ggplot2)
library(glue)
library(leaflet)
library(plotly)
library(sass)
library(shiny)
library(shiny.fluent)
library(shiny.router)
library(statdata)
library(waffle)
library(gt)


# 1. Dataset ----

gender <- statdata::gender

gender_gt <- gender %>% 
    gt::gt()

# 2. Descriptive Statistics ----

gender_stat_gt <- gender %>% 
    count(성별, name = "명수") %>% 
    mutate(성비 = glue::glue("{명수 / sum(명수) * 100} %")) %>% 
    gt::gt()

# 3. Visualization -----

gender_tbl <- gender %>% 
    count(성별, name = "명수")

gender_barplot_gg <- gender_tbl %>% 
    ggplot(aes(x = 성별, y=명수)) +
    geom_col(width = 0.3, fill = "midnightblue") +
    scale_y_continuous(limits = c(0,10), labels = scales::number_format(accuracy = 1)) +
    labs(x = "성별",
         y = "명수",
         title = "중학교 성별 범주형 데이터") +
    theme_bw(base_family = "NanumGothic")

gender_piechart_gg <- gender_tbl %>% 
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

gender_waffle_gg <- gender_tbl %>% 
    ggplot(aes(fill = 성별, values=명수)) +
    geom_waffle(n_rows = 6, size = 0.33, colour = "white") +
    scale_fill_manual(name = NULL,
                      values = c("#BA182A", "#FF8288"),
                      labels = c("남자", "여자")) +
    coord_equal() +
    theme_void(base_family = "NanumGothic")

gender_image_gg <- gender_tbl %>% 
    mutate(image = list(
        magick::image_read_svg("https://raw.githubusercontent.com/tidyverse-korea/pkg_doc/master/fig/man-svgrepo-com.svg"),
        magick::image_read_svg("https://raw.githubusercontent.com/tidyverse-korea/pkg_doc/master/fig/woman-svgrepo-com.svg")
    )) %>% 
    ggplot(aes(x = 성별, y=명수, image = image)) +
    geom_isotype_col() +
    scale_fill_manual(name = NULL,
                      values = c("#BA182A", "#FF8288"),
                      labels = c("남자", "여자")) +
    theme_bw(base_family = "NanumGothic")  +
    scale_y_continuous(limits = c(0,10), labels = scales::number_format(accuracy = 1))
