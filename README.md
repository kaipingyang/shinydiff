# shinydiff

An R htmlwidget and Shiny module for visualizing text differences using the JavaScript 'diff' library.

## Installation

You can install the development version of shinydiff from GitHub with:

```r
remotes::install_github("kaipingyang/shinydiff")
```

Or clone this repo and use `devtools::install()` or `remotes::install_local()`.


## Example

```r
library(shinydiff)
shinydiff("Hello world!", "Hello R world!")
```

## Shiny UI Example

You can use `shinydiffOutput` directly in your Shiny UI:

```r
library(shiny)
library(shinydiff)

ui <- fluidPage(
  shinydiffOutput("diff1")
)

server <- function(input, output, session) {
  output$diff1 <- renderShinydiff({
    shinydiff("Hello world!", "Hello R world!")
  })
}

shinyApp(ui, server)
```

## get_diff Function

```r
library(shiny)
library(shinydiff)
text1 <- "Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!"
text2 <- "Hello R world!Hello world!Hello world!Hello world!Hello world!"

ui <- fluidPage(
  selectInput("diff_type", "Diff Type", choices = c("words", "chars", "lines"), selected = "words"),
  shinydiffOutput("diff1", width = "100%"),
  tableOutput("diff1_content")
)

server <- function(input, output, session) {

  output$diff1 <- renderShinydiff({
    shinydiff(text1, text2, diffType = input$diff_type)
  })

  output$diff1_content <- renderTable({
    req(input$diff1_diff)
    get_diff("diff1")
  })
}

shinyApp(ui, server)
```

## Shiny Module Example

```r
library(shiny)
library(shinydiff)

ui <- fluidPage(
  shinydiffModuleUI("diff1")
)

server <- function(input, output, session) {
  shinydiffModuleServer("diff1",
    text1 = reactive({"Hello world!"}),
    text2 = reactive({"Hello R world!"})
  )
}

shinyApp(ui, server)
```
