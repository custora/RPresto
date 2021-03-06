# Copyright (c) 2015-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.

#' @include PrestoDriver.R PrestoConnection.R
NULL

#' @param drv A driver object generated by \code{\link{Presto}}
#' @param catalog The catalog to be used
#' @param schema The schema to be used
#' @param user The current user
#' @param host The presto host to connect to
#' @param port Port to use for the connection
#' @param session.timezone Time zone to use for the connection. Presto returns
#'          timestamps without time zones with respect to this value. The time
#'          arithmetic (e.g. adding hours) will also be done in the given time
#'          zone. See the session.timezone tests for examples.
#' @param parameters A \code{\link{list}} of extra parameters to be passed in
#'          the \sQuote{X-Presto-Session} header
#' @param ... currently ignored
#' @return [dbConnect] A \code{\linkS4class{PrestoConnection}} object
#' @export
#' @rdname Presto
#' @examples
#' \dontrun{
#'   conn <- dbConnect(Presto(), catalog = 'hive', schema = 'default',
#'                     user = 'onur', host = 'localhost', port = 8080,
#'                     session.timezone='US/Eastern')
#'   dbListTables(conn, '%_iris')
#'   dbDisconnect(conn)
#' }
setMethod('dbConnect',
  'PrestoDriver',
  function(
    drv,
    catalog,
    schema,
    user,
    host = 'localhost',
    port = 8080,
    source = getPackageName(),
    session.timezone='UTC',
    parameters = list(),
    ...
  ) {
    port <- suppressWarnings(as.integer(port))
    if (!length(port) == 1 || is.na(port)) {
      stop("Please specify a port as an integer")
    }

    conn <- new('PrestoConnection',
      catalog=catalog,
      schema=schema,
      user=user,
      host=host,
      port=port,
      source=source,
      session.timezone=session.timezone,
      parameters=parameters
    )
    return(conn)
  }
)
