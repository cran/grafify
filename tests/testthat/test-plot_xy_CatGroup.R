test_that("XY plot and Cat groups works", {
  g1 <- plot_xy_CatGroup(mtcars, 
                        disp, hp,
                        cyl,
                        TextXAngle = 45)
  expect_s3_class(g1, "ggplot")
  #expect_equal(g1$theme$text$size, 20)
  #expect_equal(g1$labels$x[1], "disp")
  #expect_equal(g1$labels$y[1], "hp")
  #expect_equal(get_guide_angle(g1, "x"), 45)
})
