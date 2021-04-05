test_that("get_hurwitz_color() returns correct colors", {
  expect_equal("#F5811F", get_hurwitz_colors("orange"), ignore_attr = TRUE)
  expect_equal("#008D98", get_hurwitz_colors("blue"), ignore_attr = TRUE)
  expect_equal("#C9C9C9", get_hurwitz_colors("light_gray"), ignore_attr = TRUE)
  expect_equal("#616161", get_hurwitz_colors("dark_gray"), ignore_attr = TRUE)
})

test_that("get_hurwitz_color() accepts alternate spelling of grey/gray", {
  expect_equal(get_hurwitz_colors("light_grey"),
               get_hurwitz_colors("light_gray"), ignore_attr = TRUE)
  expect_equal(get_hurwitz_colors("dark_grey"),
               get_hurwitz_colors("dark_gray"), ignore_attr = TRUE)
  expect_equal(get_hurwitz_colors("orange", "dark_grey"),
               get_hurwitz_colors("orange", "dark_gray"), ignore_attr = TRUE)
})

test_that("get_hurwitz_color() throws error on invalid colors", {
  expect_error(get_hurwitz_colors("foo"), "color: 'foo' not found.")
})

test_that("get_hurwitz_pal() returns valid palettes", {

  # Original palette
  gray_pal <- get_hurwitz_colors("light_gray", "dark_gray")
  expect_equal(get_hurwitz_pal("gray")(2), gray_pal, ignore_attr = TRUE)

  # Interpolated palette
  gray_interp <- get_hurwitz_pal("gray")(3)
  expect_equal(gray_interp, c("#C9C9C9", "#949494", "#616161"),
               ignore_attr = TRUE)

  # Robustness with gray/grey
  expect_equal(get_hurwitz_pal("grey")(2), gray_pal, ignore_attr = TRUE)
})

test_that("get_hurwitz_pal() throws error on invalid palette", {
  expect_error(get_hurwitz_pal("foo"), "palette: 'foo' not found.")
})

test_that("scales work properly", {

  # Defaults

  fill_scale <- scale_fill_hurwitz()
  expect_equal(fill_scale$scale_name, "hurwitz_main")
  expect_equal(fill_scale$is_discrete(), TRUE)

  color_scale <- scale_color_hurwitz()
  expect_equal(color_scale$scale_name, "hurwitz_main")
  expect_equal(color_scale$is_discrete(), TRUE)

  # Can make continuous

  fill_scale <- scale_fill_hurwitz(discrete = FALSE)
  expect_equal(fill_scale$is_discrete(), FALSE)

  color_scale <- scale_color_hurwitz(discrete = FALSE)
  expect_equal(color_scale$is_discrete(), FALSE)
})
