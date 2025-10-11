\name{shinydiff}
\alias{shinydiff}
\title{Shiny Diff htmlwidget}
\description{Create a widget to visualize text differences using the JavaScript 'diff' library.}
\usage{shinydiff(text1, text2, width = NULL, height = NULL, elementId = NULL)}
\arguments{
  \item{text1}{First text string}
  \item{text2}{Second text string}
  \item{width}{Widget width}
  \item{height}{Widget height}
  \item{elementId}{Widget element id}
}
\value{An htmlwidget object}
\examples{
shinydiff("Hello world!", "Hello R world!")
}
