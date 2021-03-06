% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BASiCS_DiagHist.R
\name{BASiCS_DiagHist}
\alias{BASiCS_DiagHist}
\alias{BASiCS_diagHist}
\title{Create diagnostic plots of MCMC parameters}
\usage{
BASiCS_DiagHist(
  object,
  Parameter = NULL,
  Measure = c("ess", "geweke.diag"),
  na.rm = TRUE
)

BASiCS_diagHist(...)
}
\arguments{
\item{object}{an object of class \code{\linkS4class{BASiCS_Summary}}}

\item{Parameter}{Optional name of a chain parameter to restrict the histogram;
if not supplied, all parameters will be assessed.
Possible values: \code{'mu'}, \code{'delta'}, \code{'phi'},
\code{'s'}, \code{'nu'}, \code{'theta'}, \code{'beta'},
\code{'sigma2'} and \code{'epsilon'}. Default \code{Parameter = NULL}.}

\item{Measure}{Character scalar specifying the diagnostic measure to plot.
Current options are effective sample size and the Geweke diagnostic
criterion.}

\item{na.rm}{Logical value indicating whether NA values should be removed
before calculating effective sample size.}

\item{...}{Unused.}
}
\value{
A ggplot object.
}
\description{
Plot a histogram of effective sample size or Geweke's diagnostic
z-statistic. See \link[coda]{effectiveSize} and \link[coda]{geweke.diag} for
more details.
}
\examples{

# Built-in example chain
data(ChainSC)

# See effective sample size distribution across all parameters
BASiCS_DiagHist(ChainSC)
# For mu only
BASiCS_DiagHist(ChainSC, Parameter = "mu")

}
\references{
Geweke, J. Evaluating the accuracy of sampling-based approaches to
 calculating posterior moments. In _Bayesian Statistics 4_ (ed JM
 Bernado, JO Berger, AP Dawid and AFM Smith). Clarendon Press,
 Oxford, UK.
}
\seealso{
\code{\linkS4class{BASiCS_Chain}}
}
\author{
Alan O'Callaghan
}
