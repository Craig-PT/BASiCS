.VG <- function(x) {
  x@Table[[x@Name]]
}

.HeaderDetectHVG_LVG <- function(Chain,
                                 PercentileThreshold,
                                 VarThreshold,
                                 EpsilonThreshold,
                                 Plot) {
  
  if (!is(Chain, "BASiCS_Chain")) 
    stop("'Chain' is not a BASiCS_Chain class object.")
  
  if(is.null(PercentileThreshold) 
    & is.null(VarThreshold) 
    & is.null(EpsilonThreshold)) {
    stop("A value must be provided for 'PercentileThreshold', 'VarThreshold' or 'EpsilonThreshold'")
  }
  
  # Test if the chain does not contain epsilon parameters
  if (is.null(Chain@parameters$epsilon)) {
    
    if(!is.null(PercentileThreshold)) {
      stop("'Chain' does not include residual over-dispersion parameters.
           'PercentileThreshold' will be ignored.
           'VarThreshold' must be provided instead.")
    } 
    if(!is.null(EpsilonThreshold)) {
      stop("'Chain' does not include residual over-dispersion parameters.
           'EpsilonThreshold' will be ignored.
           'VarThreshold' must be provided instead.")
    }

    if (!is.null(VarThreshold)) {
      if (VarThreshold < 0 | VarThreshold > 1 | !is.finite(VarThreshold))
        stop("Variance contribution threshold must be in (0,1)")
    }
  }
  
  # Test if the chain contains beta parameters
  if (!is.null(Chain@parameters$epsilon)) {
    
    if(!is.null(VarThreshold)) 
      stop("'Chain' includes residual over-dispersion parameters.\n
           'VarThreshold' will be ignored. \n
           'PercentileThreshold'must be provided instead. \n")
    
    if(!is.null(PercentileThreshold)) {
      if(PercentileThreshold < 0 | PercentileThreshold > 1 | 
         !is.finite(PercentileThreshold)) 
        stop("Percentile threshold must be in (0,1)")
    }
  }
  
  if(!is.logical(Plot)) 
    stop("`Plot` must be TRUE or FALSE")
}

.VGGridPlot <- function(ProbThresholds, EFDRgrid, EFNRgrid, EFDR) {
  ggplot2::ggplot() +
    ggplot2::geom_line(
      ggplot2::aes(ProbThresholds, EFDRgrid, color = "EFDR")
    ) +
    ggplot2::geom_line(
      ggplot2::aes(ProbThresholds, EFNRgrid, color = "EFNR")
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(color = "Target EFDR", yintercept = EFDR)
    ) +
    ggplot2::scale_color_brewer(palette = "Set1", name = NULL) +
    ggplot2::labs(x = "Probability threshold", y = "Error rate") +
    ggplot2::ylim(c(0, 1)) + 
    theme_classic()
}


.VGPlot <- function(
  Task,
  Mu,
  Prob,
  OptThreshold,
  Hits,
  ylim = c(0, 1),
  xlim = c(min(Mu), max(Mu)),
  cex = 1.5,
  pch = 16,
  col = 8,
  bty = "n",
  xlab = "Mean expression",
  ylab = paste(Task, "probability"),
  title = ""
) {
  
  df <- data.frame(Mu, Prob)
  ggplot2::ggplot(df, ggplot2::aes_string(x = "Mu", y = "Prob")) +
    ggplot2::geom_point(
      ggplot2::aes(color = ifelse(Hits, Task, "Other")), 
      pch = pch, cex = cex) +
    ggplot2::scale_color_brewer(palette = "Set1", name = "") +
    ggplot2::geom_hline(
      yintercept = OptThreshold[[1]], lty = 2, col = "black"
    ) +
    ggplot2::scale_x_log10() +
    ggplot2::labs(
      x = xlab,
      y = ylab,
      title = title
    ) +
    theme_classic()
}
