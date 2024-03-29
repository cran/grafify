% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{data_2w_Festing}
\alias{data_2w_Festing}
\title{Data from two-way ANOVA with randomised block design of treatments of strains of mice.}
\format{
data.frame:	16 obs. of  4 variables:

\describe{
\item{Block}{A random factor with 2 levels "A" and "B".}
\item{Treatment}{A fixed factor with 2 levels: "Control" & "Treated"}
\item{Strain}{A fixed factor with 4 levels: "129Ola", "A/J", "NIH" & "BALB/C"}
\item{GST}{Numerical dependent variable indicating GST activity measurement}
}
}
\usage{
data_2w_Festing
}
\description{
Data from Festing, ILAR Journal (2014) 55, 472--476 <doi: 10.1093/ilar/ilu045>. These data are suitable for two-way linear mixed effects modelling.
The activity of GST (numerical dependent variable) was measured in 4 strains of mice (levels with the fixed factor Strain) either treated or controls (levels within the fixed factor Treatment). Once mouse each was used in two randomised blocks, which is the random factor (Block).
}
\keyword{datasets}
