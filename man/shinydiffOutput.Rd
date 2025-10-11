
\name{shinydiffOutput}
\alias{shinydiffOutput}
	itle{Shiny bindings for shinydiff}
\description{Output function for using shinydiff in Shiny.}
\usage{shinydiffOutput(outputId, width = "100%", height = "400px")}
\arguments{
  \item{outputId}{Output variable to read from}
  \item{width}{Widget width}
  \item{height}{Widget height}
}
\value{A Shiny output binding}
\examples{
shinydiffOutput("diff")
}
