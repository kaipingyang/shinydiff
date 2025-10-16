library(devtools)
library(usethis)

 Sys.getenv("GITHUB_PAT")

usethis::edit
usethis::use_description()
usethis::use_mit_license("Kaiping Yang")

usethis::use_package("shiny")
usethis::use_package("htmlwidgets")
usethis::use_package("jsonlite")

devtools::document()
devtools::check()

devtools::load_all()

# devtools::install()

library(shiny)
library(shinydiff)
text1 <- "Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!"
text2 <- "Hello R world!Hello world!Hello world!Hello world!Hello world!"

ui <- fluidPage(
  selectInput("diff_type", "Diff Type", choices = c("words", "chars", "lines","sentences","trimmedlines","css"), selected = "lines"),
  shinydiffOutput("diff1", width = "50%"),
  tableOutput("diff1_content")
)

server <- function(input, output, session) {
  print(1)
  output$diff1 <- renderShinydiff({
    shinydiff(text1, text2, diffType = input$diff_type)
  })

  observe({
    req(input$diff1_diff)
    # input$diff1_diff 是一个列表，包含每段的 value、added、removed
    # 你可以在这里处理或输出
    # print(input$diff1_diff)
    input_diff1_diff <<- input$diff1_diff
    input_diff1_diff2 <<-get_diff("diff1")
    output$diff1_content <- renderTable({
      get_diff("diff1")
    })
  })
}

shinyApp(ui, server)