gv <- function(dsn, layer = 1L, ..., options = NULL, quiet = TRUE, iGeomField = 1L, type = 0, 
               promote_to_multi = TRUE, stringsAsFactors = FALSE, int64_as_string = FALSE) {
  if (!is.character(layer)) {
   layer <- st_layers(dsn, options = as.character(options))$name[layer]
  }
  CPL_read_vector(dsn, layer, as.character(options), quiet, iGeomField - 1L, type, 
                   promote_to_multi, int64_as_string)
}


