% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_4d_point_sd.R
\name{plot_4d_point_sd}
\alias{plot_4d_point_sd}
\title{Plot mean & error bars for 2-way ANOVAs with or without a blocking factor.}
\usage{
plot_4d_point_sd(
  data,
  xcol,
  ycol,
  points,
  shapes,
  facet,
  ErrorType = "SD",
  symsize = 3.5,
  s_alpha = 1,
  symshape = 22,
  all_alpha = 0.3,
  all_size = 2.5,
  all_shape = 0,
  all_jitter = 0,
  ewid = 0.2,
  group_wid = 0.8,
  TextXAngle = 0,
  LogYTrans,
  LogYBreaks = waiver(),
  LogYLabels = waiver(),
  LogYLimits = NULL,
  facet_scales = "fixed",
  fontsize = 20,
  symthick,
  ethick,
  ColPal = c("okabe_ito", "all_grafify", "bright", "contrast", "dark", "fishy", "kelly",
    "light", "muted", "pale", "r4", "safe", "vibrant"),
  ColSeq = TRUE,
  ColRev = FALSE,
  ...
)
}
\arguments{
\item{data}{a data table, e.g. data.frame or tibble.}

\item{xcol}{name of the column with the variable to plot on X axis (will be converted to a factor/categorical variable).}

\item{ycol}{name of the column to plot on quantitative variable on the Y axis.}

\item{points}{name of the column with grouping within the factor plotted on X-axis (will be converted to a factor/categorical variable).}

\item{shapes}{name of the column that contains matched observations (e.g. subject IDs, experiment number) or another variable to pass on to symbol shapes (will be converted to a factor/categorical variable). If not provided, the shapes for all groups is the same, and can be changed with \code{all_shapes}, \code{all_alpha}, \code{all_size} etc.}

\item{facet}{add another variable from the data table to create faceted graphs using \code{ggplot2}\link{facet_wrap}.}

\item{ErrorType}{select the type of error bars to display. Default is "SD" (standard deviation). Other options are "SEM" (standard error of the mean) and "CI95" (95\% confidence interval based on t distributions).}

\item{symsize}{size of symbols, default set to 3.5.}

\item{s_alpha}{fractional opacity of symbols, default set to 1 (i.e. fully opaque).}

\item{symshape}{The mean is shown with symbol of the shape number 21 (default, filled circle). Pick a number between 0-25 to pick a different type of symbol from ggplot2.}

\item{all_alpha}{fractional opacity of all data points (default = 0.3).}

\item{all_size}{size of symbols of all data points, if shown (default = 2.5).}

\item{all_shape}{all data points are shown with symbols of the shape number 0 (default, open square). Pick a number between 0-25 to pick a different type of symbol from ggplot2. This argument only has an effect if \code{shapes} argument is used.}

\item{all_jitter}{reduce overlap of all data points, if shown, by setting a value between 0-1 (default = 0).}

\item{ewid}{width of error bars, default set to 0.2.}

\item{group_wid}{space between the factors along X-axis, i.e., dodge width. Default \code{group_wid = 0.8} (range 0-1), which can be set to 0 if you'd like the two plotted as \code{position = position_identity()}.}

\item{TextXAngle}{orientation of text on X-axis; default 0 degrees. Change to 45 or 90 to remove overlapping text.}

\item{LogYTrans}{transform Y axis into "log10" or "log2"}

\item{LogYBreaks}{argument for \code{ggplot2[scale_y_continuous]} for Y axis breaks on log scales, default is \code{waiver()}, or provide a vector of desired breaks.}

\item{LogYLabels}{argument for \code{ggplot2[scale_y_continuous]} for Y axis labels on log scales, default is \code{waiver()}, or provide a vector of desired labels.}

\item{LogYLimits}{a vector of length two specifying the range (minimum and maximum) of the Y axis.}

\item{facet_scales}{whether or not to fix scales on X & Y axes for all facet facet graphs. Can be \code{fixed} (default), \code{free}, \code{free_y} or \code{free_x} (for Y and X axis one at a time, respectively).}

\item{fontsize}{parameter of \code{base_size} of fonts in \code{theme_classic}, default set to size 20.}

\item{symthick}{size (in 'pt' units) of outline of symbol lines (\code{stroke}), default = \code{fontsize}/22.}

\item{ethick}{thickness of error bar lines; default \code{fontsize}/22.}

\item{ColPal}{grafify colour palette to apply, default "okabe_ito"; see \code{\link{graf_palettes}} for available palettes.}

\item{ColSeq}{logical TRUE or FALSE. Default TRUE for sequential colours from chosen palette. Set to FALSE for distant colours, which will be applied using  \code{scale_fill_grafify2}.}

\item{ColRev}{whether to reverse order of colour within the selected palette, default F (FALSE); can be set to T (TRUE).}

\item{...}{any additional arguments to pass to \code{ggplot2}\link{stat_summary} or \code{ggplot2}\link{geom_point}.}
}
\value{
This function returns a \code{ggplot2} object of class "gg" and "ggplot".
}
\description{
There are 4 related functions for 2-way ANOVA type plots. In addition to a categorical variable along the X-axis, a grouping factor is passed to either \code{points}, \code{bars} or \code{boxes} argument in these functions. A blocking factor (or any other categorical variable) can be optionally passed to the \code{shapes} argument.
\enumerate{
\item \code{\link{plot_4d_point_sd}} (mean & SD, SEM or CI95 error bars)
\item \code{\link{plot_4d_scatterbar}} (bar & SD, SEM or CI95 error bars)
\item \code{\link{plot_4d_scatterbox}} (box & whiskers)
\item \code{\link{plot_4d_scatterviolin}} (box & whiskers, violin)
}
}
\details{
These can be especially useful when the fourth variable \code{shapes} is a random factor or blocking factor (up to 25 levels are allowed; there will be an error with more levels). The \code{shapes} argument can be left blank to plot ordinary 2-way ANOVAs without blocking.

In \code{plot_4d_point_sd} and \code{plot_4d_scatterbar}, the default error bar is SD (can be changed to SEM or CI95). In \code{plot_4d_point_sd}, a large coloured symbol is plotted at the mean, all other data are shown as smaller symbols. Boxplot uses \code{\link[ggplot2]{geom_boxplot}} to depict median (thicker line), box (interquartile range (IQR)) and the whiskers (1.5*IQR).

Colours can be changed using \code{ColPal}, \code{ColRev} or \code{ColSeq} arguments.
\code{ColPal} can be one of the following: "okabe_ito", "dark", "light", "bright", "pale", "vibrant,  "muted" or "contrast".
\code{ColRev} (logical TRUE/FALSE) decides whether colours are chosen from first-to-last or last-to-first from within the chosen palette.
\code{ColSeq} (logical TRUE/FALSE) decides whether colours are picked by respecting the order in the palette or the most distant ones using \code{\link[grDevices]{colorRampPalette}}.

The resulting \code{ggplot2} graph can take additional geometries or other layers.
}
\examples{
#4d version for 2-way data with blocking
plot_4d_point_sd(data = data_2w_Tdeath, 
xcol = Genotype, 
ycol = PI, 
points = Time, 
shapes = Experiment)

#4d version without blocking factor
#`shapes` can be left blank
plot_4d_point_sd(data = data_2w_Festing, 
xcol = Strain, 
ycol = GST, 
points = Treatment)

}
