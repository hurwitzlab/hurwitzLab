hurwitz_colors <- c(
  "orange" = "#F5811F",
  "teal" = "#018D97",
  "gold" = "#FFD900",
  "viking" = "#61CDDC",
  "dark_gray" = "#6A6A6A",
  "red" = "#8B3726",
  "tan" = "#D2B48C",
  "cyan" = "#97FFFF",
  "charcoal" = "#333333",
  "light_gray" = "#CCCCCC",
  "brown" = "#8B7355"
)

#' Extract colors as hex codes
#'
#' @param ... Character names of hurwitz_colors
#'
#' @export
get_hurwitz_colors <- function(...) {
  colors <- c(...)

  if (is.null(colors))
    return(hurwitz_colors)

  colors <- stringr::str_replace(colors, "grey", "gray")

  if (any(!colors %in% names(hurwitz_colors)))
    for (col in colors) {
      if (!col %in% names(hurwitz_colors)) {
        stop(paste0("color: '", col, "' not found."))
      }
    }

  hurwitz_colors[colors]
}

#' Extract colors as hex codes
#'
#' @param ... Character names of hurwitz_colours
#'
#' @export
get_hurwitz_colours <- get_hurwitz_colors

hurwitz_palettes <- list(
  "all" = get_hurwitz_colors("orange", "teal", "gold", "viking",
                             "dark_gray", "red", "tan", "cyan",
                             "charcoal", "light_gray", "brown"),
  "main"  = get_hurwitz_colors("teal", "dark_gray", "orange"),
  "classic"  = get_hurwitz_colors("teal", "orange"),
  "gray"  = get_hurwitz_colors("light_gray", "dark_gray"),
  "distinguish" = get_hurwitz_colors("teal", "gold", "dark_gray", "orange"),
  "distinguish2" = get_hurwitz_colors("viking", "gold", "dark_gray", "orange"),
  "shallow_ocean" = get_hurwitz_colors("gold", "tan", "light_gray", "viking"),
  "deep_ocean" = get_hurwitz_colors("teal", "dark_gray", "brown", "light_gray"),
  "contrast" = get_hurwitz_colors("teal", "gold", "red")
)

#' Print hex codes of colors in a palette
#'
#' @param name Palette name
#'
#' @export
hurwitz_pal <- function(name) {
  if (!(name %in% names(hurwitz_palettes))) {
    stop(paste(name, "is not a valid palette name for hurwitz_palettes\n"))
  }

  return(hurwitz_palettes[[name]])
}

#' Preview color palette for Hurwitz Lab colors
#'
#' @param n Number of colors to display
#' @param name Palette name
#'
#' @export
display_hurwitz_pal <- function(name, n = length(hurwitz_palettes[[name]])) {
  pal_colors <- hurwitz_pal(name)

  if (n < 2) {
    warning("minimal value for n is 2, displaying requested
            palette with 2 different levels\n")
    return(display_hurwitz_pal(name, 2))
  }
  if (n > length(hurwitz_palettes[[name]])) {
    warning(paste("n too large, allowed maximum for palette",
                  name, "is", length(hurwitz_palettes[[name]])),
            "\nDisplaying the palette you asked for with that many colors\n")
    return(display_hurwitz_pal(name, length(hurwitz_palettes[[name]])))
  }

  image(1:n, 1, as.matrix(1:n),
        col = pal_colors,
        xlab = name, ylab = "",
        xaxt = "n", yaxt = "n", bty = "n")
}

#' Return function to interpolate a color palette
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
#'
get_hurwitz_pal <- function(palette = "all", reverse = FALSE, ...) {
  palette <- stringr::str_replace(palette, "grey", "gray")

  if (!palette %in% names(hurwitz_palettes))
    stop(paste0("palette: '", palette, "' not found."))

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
#'            scale_color_gradientn(), used respectively when discrete is
#'            TRUE or FALSE
#'
#' @export
scale_color_hurwitz <- function(palette = "all", discrete = TRUE,
                                reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("hurwitz_", palette),
                            palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Colour scale constructor for Hurwitz Lab colors
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is
#'            TRUE or FALSE
#'
#' @export
scale_colour_hurwitz <- scale_color_hurwitz

#' Fill scale constructor for Hurwitz Lab colors
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is
#'            TRUE or FALSE
#'
#' @export
scale_fill_hurwitz <- function(palette = "all", discrete = TRUE,
                               reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("hurwitz_", palette),
                            palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}
