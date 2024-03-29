#' Plot a dotplot on a boxplot with two variables.
#'
#' There are three types of `plot_dot_` functions that plot data as "dots" using the \code{\link[ggplot2]{geom_dotplot}} geometry. They all take a data table, a categorical X variable and a numeric Y variable. 
#' 1. \link{plot_dotbar_sd} (bar & SD, SEM or CI95 error bars)
#' 2. \link{plot_dotbox} (box & whiskers)
#' 3. \link{plot_dotviolin} (box & whiskers, violin)
#' 
#' Related `plot_scatter_` variants show data symbols using the \code{\link[ggplot2]{geom_point}} geometry. These are \link{plot_scatterbar_sd} (or SEM or CI95 error bars), \link{plot_scatterbox} and \link{plot_scatterviolin}. Over plotting in `plot_scatter` variants can be reduced with the `jitter` argument.
#' 
#' The X variable is mapped to the \code{fill} aesthetic of dots, symbols, bars, boxes and violins.
#' 
#' Colours can be changed using `ColPal`, `ColRev` or `ColSeq` arguments. Colours available can be seen quickly with \code{\link{plot_grafify_palette}}. 
#' `ColPal` can be one of the following: "okabe_ito", "dark", "light", "bright", "pale", "vibrant,  "muted" or "contrast".
#' `ColRev` (logical TRUE/FALSE) decides whether colours are chosen from first-to-last or last-to-first from within the chosen palette. 
#' `ColSeq` decides whether colours are picked by respecting the order in the palette or the most distant ones using \code{\link[grDevices]{colorRampPalette}}.
#' 
#' If you prefer a single colour for the graph, use the `SingleColour` argument.
#' 
#' @param data a data table object, e.g. data.frame or tibble.
#' @param xcol name of the column to plot on X axis. This should be a categorical variable.
#' @param ycol name of the column to plot on quantitative Y axis. This should be a quantitative variable.
#' @param facet add another variable from the data table to create faceted graphs using \code{ggplot2}[facet_wrap].
#' @param dotsize size of dots relative to binwidth used by \code{geom_dotplot}. Default set to 1.5, increase/decrease as needed.
#' @param d_alpha fractional opacity of dots, default set to 0.8 (i.e., 80% opacity).
#' @param b_alpha fractional opacity of boxes, default set to 1.
#' @param bwid width of boxplots; default 0.5.
#' @param TextXAngle orientation of text on X-axis; default 0 degrees. Change to 45 or 90 to remove overlapping text.
#' @param LogYTrans transform Y axis into "log10" or "log2"
#' @param LogYBreaks argument for \code{ggplot2[scale_y_continuous]} for Y axis breaks on log scales, default is `waiver()`, or provide a vector of desired breaks.
#' @param LogYLabels argument for \code{ggplot2[scale_y_continuous]} for Y axis labels on log scales, default is `waiver()`, or provide a vector of desired labels. 
#' @param LogYLimits a vector of length two specifying the range (minimum and maximum) of the Y axis.
#' @param facet_scales whether or not to fix scales on X & Y axes for all facet facet graphs. Can be `fixed` (default), `free`, `free_y` or `free_x` (for Y and X axis one at a time, respectively).
#' @param fontsize parameter of \code{base_size} of fonts in \code{theme_classic}, default set to size 20.
#' @param dotthick thickness of dot border (`stroke` parameter of `geom_dotplot`), default set to `fontsize`/22.
#' @param bthick thickness (in 'pt' units) of boxplot lines; default = `fontsize`/22.
#' @param ColPal grafify colour palette to apply, default "okabe_ito"; see \code{\link{graf_palettes}} for available palettes.
#' @param ColRev whether to reverse order of colour within the selected palette, default F (FALSE); can be set to T (TRUE).
#' @param ColSeq logical TRUE or FALSE. Default TRUE for sequential colours from chosen palette. Set to FALSE for distant colours, which will be applied using  \code{scale_fill_grafify2}.
#' @param SingleColour a colour hexcode (starting with #), a number between 1-154, or names of colours from `grafify` or base R palettes to fill along X-axis aesthetic. Accepts any colour other than "black"; use `grey_lin11`, which is almost black.
#' @param ... any additional arguments to pass to \code{ggplot2}[geom_boxplot] or \code{ggplot2}[geom_dotplot].
#'
#' @return This function returns a \code{ggplot2} object of class "gg" and "ggplot".
#' @export plot_dotbox
#' @import ggplot2
#'
#' @examples
#' plot_dotbox(data = data_1w_death, 
#' xcol = Genotype, ycol = Death)
#' 
#' plot_dotbox(data = data_1w_death, 
#' xcol = Genotype, ycol = Death, 
#' ColPal = "vibrant", b_alpha = 0.5)
#' plot_dotbox(data = data_1w_death, 
#' xcol = Genotype, ycol = Death, 
#' SingleColour = "safe_bluegreen", b_alpha = 0.5) 

plot_dotbox <- function(data, xcol, ycol, facet, dotsize = 1.5, d_alpha = 0.8, b_alpha = 1, bwid = 0.5,  TextXAngle = 0, LogYTrans, LogYBreaks = waiver(), LogYLabels = waiver(), LogYLimits = NULL, facet_scales = "fixed", fontsize = 20, dotthick, bthick, ColPal = c("okabe_ito", "all_grafify", "bright",  "contrast",  "dark",  "fishy",  "kelly",  "light",  "muted",  "pale",  "r4",  "safe",  "vibrant"), ColSeq = TRUE, ColRev = FALSE, SingleColour = "NULL", ...){
  ColPal <- match.arg(ColPal)
  if (missing(bthick)) {bthick = fontsize/22}
  if (missing(dotthick)) {dotthick = fontsize/22}
  #data[[deparse(substitute(xcol))]] <- factor(#data[[deparse(substitute(xcol))]])
  if (missing(SingleColour)) {
    suppressWarnings(P <- ggplot2::ggplot(data, aes(x = factor({{ xcol }}),
                                                    y = {{ ycol }}))+
                       geom_boxplot(aes(fill = factor({{ xcol }})), 
                                    linewidth = bthick,
                                    alpha = b_alpha,
                                    outlier.alpha = 0,
                                    width = bwid,
                                    ...)+
                       geom_dotplot(stackdir = "center", 
                                    stroke = dotthick,
                                    alpha = d_alpha,
                                    binaxis = 'y', 
                                    dotsize = dotsize,
                                    aes(fill = factor({{ xcol }})),
                                    ...))
  } else {
    ifelse(grepl("#", SingleColour), 
           a <- SingleColour,
           ifelse(isTRUE(get_graf_colours(SingleColour) != 0), 
                  a <- unname(get_graf_colours(SingleColour)), 
                  a <- SingleColour))
    suppressWarnings(P <- ggplot2::ggplot(data, aes(x = factor({{ xcol }}),
                                                    y = {{ ycol }}))+
                       geom_boxplot(linewidth = bthick,
                                    alpha = b_alpha,
                                    outlier.alpha = 0,
                                    width = bwid,
                                    fill = a,
                                    ...)+
                       geom_dotplot(stackdir = "center", 
                                    stroke = dotthick,
                                    alpha = d_alpha,
                                    binaxis = 'y', 
                                    dotsize = dotsize,
                                    fill = a,
                                    ...))
  }
  if(!missing(facet)) {
    P <- P + facet_wrap(vars({{ facet }}), 
                        scales = facet_scales, 
                        ...)
  }
  if (!missing(LogYTrans)) {
    if (!(LogYTrans %in% c("log2", "log10"))) {
      stop("LogYTrans only allows 'log2' or 'log10' transformation.")
    }
    if (LogYTrans == "log10") {
      P <- P + 
        scale_y_continuous(trans = "log10", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)+
        annotation_logticks(sides = "l", 
                            outside = TRUE,
                            base = 10, color = "grey20",
                            long = unit(7*fontsize/22, "pt"), size = unit(fontsize/22, "pt"),# 
                            short = unit(4*fontsize/22, "pt"), mid = unit(4*fontsize/22, "pt"),#
                            ...)+ 
        coord_cartesian(clip = "off", ...)
    }
    if (LogYTrans == "log2") {
      P <- P + 
        scale_y_continuous(trans = "log2", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)}
  }
  P <- P + 
    labs(x = enquo(xcol),
         fill = enquo(xcol))+
    theme_grafify(base_size = fontsize)+
    guides(x = guide_axis(angle = TextXAngle))+
    scale_fill_grafify(palette = ColPal, 
                       reverse = ColRev, 
                       ColSeq = ColSeq)
  P
}
