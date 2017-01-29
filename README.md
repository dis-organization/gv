
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/mdsumner/gv.svg?branch=master)](https://travis-ci.org/mdsumner/gv) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdsumner/gv?branch=master&svg=true)](https://ci.appveyor.com/project/mdsumner/gv)

[![Coverage Status](https://img.shields.io/codecov/c/github/mdsumner/gv/master.svg)](https://codecov.io/github/mdsumner/gv?branch=master)

forked from sf 49504352e685702ee749a042e26476fc91b66014 2017-01-28

``` r
library(sf)
dsn <- system.file("shape/nc.shp", package="sf")
nc <- st_read(dsn)
#> Reading layer `nc' from data source `/perm_storage/home/mdsumner/R/x86_64-pc-linux-gnu-library/3.3/sf/shape/nc.shp' using driver `ESRI Shapefile'
#> converted into: MULTIPOLYGON
#> Simple feature collection with 100 features and 14 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -84.32385 ymin: 33.88199 xmax: -75.45698 ymax: 36.58965
#> epsg (SRID):    4267
#> proj4string:    +proj=longlat +datum=NAD27 +no_defs

wkt <- readLines(system.file("shape/nc.prj", package = "sf"))
#> Warning in readLines(system.file("shape/nc.prj", package = "sf")):
#> incomplete final line found on '/perm_storage/home/mdsumner/R/x86_64-pc-
#> linux-gnu-library/3.3/sf/shape/nc.prj'
sf:::CPL_crs_from_wkt(wkt)
#> $epsg
#> [1] 4267
#> 
#> $proj4string
#> [1] "+proj=longlat +ellps=clrk66 +no_defs"
#> 
#> attr(,"class")
#> [1] "crs"

mls <- "POINT (20 30)"
a <- sf::st_sfc(sf:::CPL_sfc_from_wkt(mls))

x <-  sf:::gv(dsn)
```

We need "agr.R", "sf.r" and "sp.R".

    nc <- st_read(system.file("shape/nc.shp", package="sf"))
    Reading layer `nc' from data source `/perm_storage/home/mdsumner/R/x86_64-pc-linux-gnu-library/3.3/sf/shape/nc.shp' using driver `ESRI Shapefile'
    converted into: MULTIPOLYGON
    Error in st_sf(x, ..., agr = agr) : object 'NA_agr_' not found
