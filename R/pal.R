hurwitz_colors <- c(
  'orange' = "#fc850b",
  'blue' = "#2099a4",
  'light_gray' = "#c9c9c9",
  'dark_gray' = "#616161"
)

#' Extract colors as hex codes
#'
#' @param ... Character names of hurwitz_colors
#'
get_hurwitz_colors <- function(...) {
  colors <- c(...)

  if (is.null(colors))
    return (hurwitz_colors)

  if (any(!colors %in% names(hurwitz_colors)))
    for (col in colors) {
      if (!col %in% names(hurwitz_colors))
        stop(paste0("color: '", col, "' not found."))
    }

  hurwitz_colors[colors]
}

hurwitz_palettes <- list(
  'main'  = get_hurwitz_colors("blue", "orange", "light_gray"),
  'classic'  = get_hurwitz_colors("blue", "orange"),
  'gray'  = get_hurwitz_colors("light_gray", "dark_gray")
)

#' Return function to interpolate a color palette
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
get_hurwitz_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- hurwitz_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' Color scale constructor for Hurwitz Lab colors
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_hurwitz <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("hurwitz_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for Hurwitz Lab colors
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_fill_hurwitz <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("hurwitz_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
