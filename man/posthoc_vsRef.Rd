% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/posthoc_vsRef.R
\name{posthoc_vsRef}
\alias{posthoc_vsRef}
\title{Post-hoc comparisons to a control or reference group.}
\usage{
posthoc_vsRef(Model, Fixed_Factor, Ref_Level = 1, P_Adj = "fdr", Factor, ...)
}
\arguments{
\item{Model}{a model object fit using \code{\link{simple_model}} or \code{\link{mixed_model}} or related.}

\item{Fixed_Factor}{Fixed_Factor one or  more categorical variables, provided as a vector (see Examples), whose levels you wish to compare pairwise. Names of Fixed_Factor should match Fixed_Factor used to fit the model. When more than one factor is provided e.g. \code{Fixed_factor = c("A", "B")}, this function passes this on as \code{specs = A|B} (note the vertical | between the two Fixed_Factor) to \code{\link[emmeans]{emmeans}}. The specification internally is set to \code{specs = trt.vs.ctrl, Ref_Level = 1} to compare each group in A to the reference first group in A, separately at each level of B.}

\item{Ref_Level}{the level within that factor to be considered the reference or control to compare other levels to (to be provided as a number - by default R orders levels alphabetically); default \code{Ref_Level = 1}.}

\item{P_Adj}{method for correcting P values for multiple comparisons. Default is set to false discovery rate ("fdr"), can be changed to "none", "tukey", "bonferroni", "sidak". See Interaction analysis in emmeans in the \href{https://CRAN.R-project.org/package=emmeans}{manual} for \code{emmeans}.}

\item{Factor}{old argument name for \code{Fixed_Factor}; retained for backward compatibility.}

\item{...}{additional arguments for \code{\link[emmeans]{emmeans}} such as \code{lmer.df} or others. See help for sophisticated models in \href{https://CRAN.R-project.org/package=emmeans}{emmeans}.}
}
\value{
returns an "emm_list" object containing contrasts and emmeans through  \code{\link[emmeans]{emmeans}}.
}
\description{
This function is a wrapper based on \code{\link[emmeans]{emmeans}}, and needs a ordinary linear model produced by \code{\link{simple_model}} or a mixed effects model produced by \code{\link{mixed_model}} or \code{\link{mixed_model_slopes}} (or generated directly with \code{lm},  \code{lme4} or \code{lmerTest} calls). It also needs to know the fixed factor(s), which should match those in the model and data table.
}
\details{
The function will generate \href{https://CRAN.R-project.org/package=emmeans}{treatment vs control type of comparisons} (as described in Comparisons and contrasts in emmeans), i.e. comparison of each level of a factor to a reference level, which is set by default to the first level in the factor (\code{Ref_Level = 1}).
By default, P values are corrected by the FDR method (which can be changed). If the model was fit by transforming the quantitative response variable using "log", "logit", "sqrt" etc., results will still be on the original scale, i.e. \code{type = "response"} is the default; data will be back-transformed (check results to confirm this), and for log or logit see Transformations and link functions in emmeans, \href{https://CRAN.R-project.org/package=emmeans}{ratios will be compared}.
The first part of the \code{\link{emmeans}} results has the estimated marginal means, SE and CI (\code{$emmeans}), which are generated from the fitted model, and \strong{not} the original data table. The second part has the results of the comparisons (\code{$contrasts}).
}
\examples{
#make linear models first
DoublMod <- simple_model(data = data_doubling_time,
Y_value =  "Doubling_time", 
Fixed_Factor =  "Student") 

CholMod <- mixed_model(data = data_cholesterol, 
Y_value =  "Cholesterol", 
Fixed_Factor = c("Hospital", "Treatment"),
Random_Factor = "Subject") 

#to compare all students with student #9
posthoc_vsRef(Model = DoublMod, 
Fixed_Factor = "Student", Ref_Level = 9)

#for comparison between hospital_a to every other hospital, separately at levels of Treatment
posthoc_vsRef(Model = CholMod, 
Fixed_Factor = c("Hospital", "Treatment"), Ref_Level = 1)

}
