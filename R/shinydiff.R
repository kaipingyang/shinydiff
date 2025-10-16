#' shinydiff htmlwidget
#'
#' @param text1 First text string
#' @param text2 Second text string
#' @param diffType Type of diff: "chars", "words", or "lines"
#' @param width Widget width
#' @param height Widget height
#' @param elementId Widget element id
#' @export
shinydiff <- function(text1, text2, diffType = "words", width = NULL, height = NULL, elementId = NULL) {
  htmlwidgets::createWidget(
    name = 'shinydiff',
    x = list(text1 = text1, text2 = text2, diffType = diffType),
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

#' Get the diff result from a shinydiff widget
#'
#' @param outputId The outputId used in shinydiffOutput.
#' @param session The shiny session (defaults to current reactive domain).
#' @param as (optional) "data.frame" (default) or "list" for return type.
#' @return A data.frame or list of diff segments, or NULL if not available.
#' @export
get_diff <- function(outputId, session = NULL, as = c("data.frame", "list")) {
  as <- match.arg(as)
  if (is.null(session)) {
    if (requireNamespace("shiny", quietly = TRUE)) {
      session <- shiny::getDefaultReactiveDomain()
    }
    if (is.null(session)) return(NULL)
  }
  if (!is.character(outputId) || length(outputId) != 1) {
    stop("`outputId` must be a single character string")
  }
  input_name <- paste0(outputId, "_diff")
  diff_json <- session$input[[input_name]]
  # print(diff_json)
  # if (is.null(diff_json) || !nzchar(diff_json)) return(NULL)
  if (is.null(diff_json) || !(is.character(diff_json) && length(diff_json) == 1 && nzchar(diff_json))) return(NULL)
  diff <- jsonlite::fromJSON(diff_json)
  if (as == "data.frame") {
    as.data.frame(diff)
  } else {
    diff
  }
}