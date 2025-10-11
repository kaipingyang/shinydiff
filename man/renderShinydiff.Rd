\name{renderShinydiff}
\alias{renderShinydiff}
\title{Render function for shinydiff}
\description{Render function for using shinydiff in Shiny.}
\usage{renderShinydiff(expr, env = parent.frame(), quoted = FALSE)}
\arguments{
  \item{expr}{Expression to render}
  \item{env}{Environment}
  \item{quoted}{Is expression quoted?}
}
\value{A Shiny render function}
\examples{
renderShinydiff({ shinydiff("a", "b") })
}
