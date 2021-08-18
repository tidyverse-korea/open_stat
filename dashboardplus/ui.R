
# 1. Header ------
header <- dashboardHeader(title = "오픈 통계 팩키지",
                          dropdownMenu(type = "messages",
                                       messageItem(
                                           from = "Sales Dept",
                                           message = "Sales are steady this month."
                                       )
                          ),
                          dropdownMenu(type = "notifications",
                                       notificationItem(
                                           text = "5 new users today",
                                           icon("users")
                                       )
                          ),
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 90, color = "green",
                                                "Documentation"
                                       )
                          ))

# 2. Sidebar ------
sidebar <- dashboardSidebar(
    sidebarMenu(
        "초등",
        menuItem("초등"),
        "중등",
        menuItem("중학교"),
        menuItem("고등학교"),
        "고등",
        menuItem("대학교"),
        menuItem("대학원")
    )
)

# 3. Body ------
body <- dashboardBody(
    
    navbarPage("상세",
               tabPanel("Plot"),
               navbarMenu("More",
                          tabPanel("Summary"),
                          "----",
                          "Section header",
                          tabPanel("Table")
               )
    )

)

ui <- dashboardPage(header, sidebar, body)

