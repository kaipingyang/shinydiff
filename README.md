# shinydiff

An R htmlwidget and Shiny module for visualizing text differences using the JavaScript [diff](https://github.com/kpdecker/jsdiff) library.

## Installation

You can install the development version of shinydiff from GitHub with:

```r
remotes::install_github("kaipingyang/shinydiff")
```

Or clone this repo and use `devtools::install()` or `remotes::install_local()`.


## diffType Choices
The diffType argument controls how the difference is computed:
- "words": Compare by word.
- "chars": Compare by character.
- "lines": Compare by line.
- "sentences": Compare by sentence.
- "trimmedlines": Compare by line, ignoring leading and trailing whitespace.
- "css": Compare using CSS syntax rules.

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
  selectInput(
    "diff_type", 
    "Diff Type", 
    choices = c("words", "chars", "lines", "sentences", "trimmedlines", "css"), 
    selected = "words"
  ),
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
