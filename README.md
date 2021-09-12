
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hurwitzLab

<!-- badges: start -->
<!-- badges: end -->

In Hurwitz Lab, we take pride in conveying information with elegant
figures. We also like a level of consistency in the work produced by our
group. This package provide color palettes and themes to be used when
producing figures in R.

## Installation

You can install hurwitzLab with:

``` r
devtools::install_github("schackartk/hurwitzLab")
```

However, I would suggest installing with

``` r
devtools::install_github("schackartk/hurwitzLab", build_vignettes = TRUE)
```

This will build and make the vignettes available to you, which are very
helpful for learning how to use this package. The drawback is that you
may need to install other packages to make it work.

You can then access the vignettes with

``` r
vignette("hurwitzLab")
```

If the package is installed without the `build_vignettes = TRUE` option,
the vignette can be built with

``` r
devtools::build_vignettes("hurwitzLab")
```

## What’s here?

-   Colors
-   Several pre-defined palettes
-   Scaling functions for implementation in `ggplot2`
