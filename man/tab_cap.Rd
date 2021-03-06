% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/caption-functions.r
\name{tab_cap}
\alias{tab_cap}
\title{Attach a table}
\usage{
tab_cap(cap, object, attach = NULL, label = NULL, ext = NULL)
}
\arguments{
\item{cap}{Caption}

\item{object}{object to write to file}

\item{attach}{attach graph? if \code{NULL} then this parameter will
be taken from \code{opts_proh$get('attach_graph')}}

\item{label}{label to use (defaults to "tab:<chunk-label>")}

\item{ext}{extension for file}
}
\description{
Attach a table ...
}
