context("sf: gdal tests")


test_that("gdal can be loaded, unloaded, and loaded", {
  expect_silent({
  sf:::.onLoad()
  sf:::.onUnload()
  sf:::.onLoad()
  }
  )
})
