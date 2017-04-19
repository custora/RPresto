.trace <- function(label) {
  path <- Sys.getenv("RPRESTO_TRACE_PATH")
  if (path == "")
    return()

  timestamp <- format(as.numeric(Sys.time()), digits=20)
  line <- paste0(timestamp, ": ", label)
  write(line, file=path, append=TRUE)
}
