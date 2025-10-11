#' shinydiff htmlwidget
#'
#' @param text1 First text string
#' @param text2 Second text string
#' @param width Widget width
#' @param height Widget height
#' @param elementId Widget element id
#' @export
shinydiff <- function(text1, text2, width = NULL, height = NULL, elementId = NULL) {
  htmlwidgets::createWidget(
    name = 'shinydiff',
    x = list(text1 = text1, text2 = text2),
    width = width,
    height = height,
    package = 'shinydiff',
    elementId = elementId
  )
}

#' Shiny bindings for shinydiff
#' @param outputId Output variable to read from
#' @param width,height Must be a valid CSS unit
#' @export
shinydiffOutput <- function(outputId, width = '100%', height = '400px') {
  htmlwidgets::shinyWidgetOutput(outputId, 'shinydiff', width, height, package = 'shinydiff')
}

#' Render shinydiff widget
#'
#' @param expr An expression that generates a shinydiff widget.
#' @param env The environment in which to evaluate expr. Defaults to parent.frame().
#' @param quoted Logical, whether expr is a quoted expression (default FALSE).
#' @return A Shiny render function for use in server logic.
#' @export
renderShinydiff <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) }
  htmlwidgets::shinyRenderWidget(expr, shinydiffOutput, env, quoted = TRUE)
}

#' Shiny module UI for shinydiff
#' @param id Module id
#' @export
shinydiffModuleUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::uiOutput(ns('diff_ui'))
}

#' Shiny module server for shinydiff
#' @param id Module id
#' @param text1 Reactive for first text
#' @param text2 Reactive for second text
#' @export
shinydiffModuleServer <- function(id, text1, text2) {
  shiny::moduleServer(id, function(input, output, session) {
    output$diff_ui <- shiny::renderUI({
      shinydiffOutput(session$ns('diff'))
    })
    output$diff <- renderShinydiff({
      shinydiff(text1(), text2())
    })
  })
}
