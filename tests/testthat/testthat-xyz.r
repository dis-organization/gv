p <- st_point(c(0, 0))
pz <- st_point(c(0, 0, 0))

mp <- st_multipoint(rbind(p, p * 2))
mpz <- st_multipoint(rbind(pz, pz * 2))

l1 <- cbind(0:1, 0:1)
l1z <- cbind(0:1, 0:1, 0:1)

l <- st_linestring(l1)
lz <- st_linestring(l1z)

ml <- st_multilinestring(replicate(2, l1, simplify = FALSE))
mlz <- st_multilinestring(replicate(2, l1z, simplify = FALSE))

p1 <- rbind(c(0,0), c(1,0), c(3,2), c(2,4), c(1,4), c(0,0))
p2 <- rbind(c(1,1), c(1,2), c(2,2), c(1,1))
pol1 <- list(p1,p2)
pol1z <- list(cbind(p1, 0), cbind(p2, 0))

pol <- st_polygon(pol1)
polz <- st_polygon(pol1z)

mpol <- st_multipolygon(list(pol1, pol1))
mpolz <- st_multipolygon(list(pol1z, pol1z))

## https://github.com/edzer/sfr/issues/103#issuecomment-266014403
do_vertical <- function(x) st_transform(st_sfc(x, crs = 4326), crs = 7421)
do_planar <- function(x) st_transform(st_sfc(x, crs = 4326), crs = "+proj=laea")
do_geo <- function(x) st_transform(st_sfc(x, crs = 4326), crs = "+proj=geocent")
hasz <- function(x) UseMethod("hasz")  
hasz.sfg <- function(x) grepl("Z", rev(class(x))[3L])
## only for single length columns
hasz.sfc <- function(x) hasz(x[[1]])

## all as expected 
test_that("test the hasz test", {
  expect_false(hasz(p))
  expect_false(hasz(mp))
  expect_false(hasz(l))
  expect_false(hasz(ml))
  expect_false(hasz(pol))
  expect_false(hasz(mpol))
  
  expect_true(hasz(pz))
  expect_true(hasz(mpz))
  expect_true(hasz(lz))
  expect_true(hasz(mlz))
  expect_true(hasz(polz))
  expect_true(hasz(mpolz))
  
})

## only the m-kinds match expection
test_that("planar transformations preserve Z", {
  expect_true(hasz(do_planar(pz)))
  expect_true(hasz(do_planar(mpz)))
  expect_true(hasz(do_planar(lz)))
  expect_true(hasz(do_planar(mlz)))
  expect_true(hasz(do_planar(polz)))
  expect_true(hasz(do_planar(mpolz)))
}
)

## only the m-kinds match expection
test_that("vertical transformations preserve Z", {
  expect_true(hasz(do_vertical(pz)))
  expect_true(hasz(do_vertical(mpz)))
  expect_true(hasz(do_vertical(lz)))
  expect_true(hasz(do_vertical(mlz)))
  expect_true(hasz(do_vertical(polz)))
  expect_true(hasz(do_vertical(mpolz)))
}
)

## only the m-kinds match expection
test_that("geocentric transformations preserve Z", {
  expect_true(hasz(do_geo(pz)))
  expect_true(hasz(do_geo(mpz)))
  expect_true(hasz(do_geo(lz)))
  expect_true(hasz(do_geo(mlz)))
  expect_true(hasz(do_geo(polz)))
  expect_true(hasz(do_geo(mpolz)))
}
)

## wishful thinking?
test_that("geocentric transformations add Z", {
  expect_true(hasz(do_geo(p)))
  expect_true(hasz(do_geo(mp)))
  expect_true(hasz(do_geo(l)))
  expect_true(hasz(do_geo(ml)))
  expect_true(hasz(do_geo(pol)))
  expect_true(hasz(do_geo(mpol)))
}
)
