.trace <- function(label) {
  path <- Sys.getenv("RPRESTO_TRACE_PATH")
  if (path == "")
    return()

  time <- as.integer(Sys.time())
  line <- paste0(as.character(time), ": ", label)
  write(line, file=path, append=TRUE)
}
