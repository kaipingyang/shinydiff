# shinydiff

An R htmlwidget and Shiny module for visualizing text differences using the JavaScript 'diff' library.

## Installation

Clone this repo and use `devtools::install()` or `remotes::install_local()`.

## Example

```r
library(shinydiff)
shinydiff("Hello world!", "Hello R world!")
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
