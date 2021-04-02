hurwitz_colors <- c(
  'orange' = "#F5811F",
  'blue' = "#008D98",
  'light_gray' = "#C9C9C9",
  'dark_gray' = "#616161"
)

#' Extract colors as hex codes
#'
#' @param ... Character names of hurwitz_colors
#'
#' @export
get_hurwitz_colors <- function(...) {
  colors <- c(...)

  if (is.null(colors))
    return (hurwitz_colors)

  if (any(!colors %in% names(hurwitz_colors)))
    for (col in colors) {
      if (col == "light_grey") {
        colors[colors == "light_grey"] <- "light_gray"
      } else if (col == "dark_grey") {
        colors[colors == "dark_grey"] <- "dark_gray"
      } else if (!col %in% names(hurwitz_colors)) {
        stop(paste0("color: '", col, "' not found."))
      }
    }

  hurwitz_colors[colors]
}

hurwitz_palettes <- list(
  'main'  = get_hurwitz_colors("blue", "dark_gray", "orange"),
  'classic'  = get_hurwitz_colors("blue", "orange"),
  'gray'  = get_hurwitz_colors("light_gray", "dark_gray")
)

#' Return function to interpolate a color palette
#'
#' @param palette Character name of palette in hurwitz_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
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
#' @export
scale_color_hurwitz <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("hurwitz_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
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
#' @export
scale_fill_hurwitz <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_hurwitz_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("hurwitz_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}

#' Preview color palette for Hurwitz Lab colors
#'
#' @param n Number of colors to display
#' @param name Palette name
#'
#' @export
display_hurwitz_pal <- function(n, name) {
  if(!(name %in% names(hurwitz_palettes))){
    stop(paste(name,"is not a valid palette name for hurwitz_palettes\n"))
  }
  if(n<2){
    warning("minimal value for n is 2, displaying requested palette with 2 different levels\n")
    return(display_hurwitz_pal(2, name))
  }
  if(n > length(hurwitz_palettes[[name]])){
    warning(paste("n too large, allowed maximum for palette",
                  name,"is",length(hurwitz_palettes[[name]])),
            "\nDisplaying the palette you asked for with that many colors\n")
    return(display_hurwitz_pal(length(hurwitz_palettes[[name]]),name))
  }


  image(1:n, 1, as.matrix(1:n),
        col = hurwitz_palettes[[name]],
        xlab = name, ylab = "",
        xaxt = "n", yaxt = "n", bty = "n")

}
