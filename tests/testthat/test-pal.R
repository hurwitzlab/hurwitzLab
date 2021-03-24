test_that("get_hurwitz_color() returns correct colors", {
  expect_equal("#fc850b", get_hurwitz_colors("orange"), ignore_attr = TRUE)
  expect_equal("#2099a4", get_hurwitz_colors("blue"), ignore_attr = TRUE)
  expect_equal("#c9c9c9", get_hurwitz_colors("light_gray"), ignore_attr = TRUE)
  expect_equal("#616161", get_hurwitz_colors("dark_gray"), ignore_attr = TRUE)
})

test_that("get_hurwitz_color() throws error on invalid colors", {
  expect_error(get_hurwitz_colors("foo"), "color: 'foo' not found.")
})
