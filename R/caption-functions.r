#' @title Attach a table
#' @description Attach a table ...
#' @param cap Caption
#' @param object object to write to file
#' @param attach attach graph? if \code{NULL} then this parameter will
#' be taken from \code{opts_proh$get('attach_graph')}
#' @param label label to use (defaults to "tab:<chunk-label>")
#' @param ext extension for file
#' @export
tab_cap <- function(cap, object, attach = NULL, label = NULL,  ext = NULL){
    if(is.null(label)) {
        label <- paste0("tab:", knitr::opts_current$get("label"))
    }
    if(is.null(attach)) attach <- opts_attacher$get("attach_table")
    if(attach){
        if(is.null(ext)) ext <- opts_attacher$get("table_ext")
        label <- gsub(":", "_", label, fixed = TRUE)
        file <- paste0(label, ".", ext)
        path <- opts_attacher$get("table_path")
        if(!dir.exists(path)) dir.create(path)
        file_path <- file.path(path, file)
        fnc <- opts_attacher$get("table_fnc")
        fnc(object, file = file_path)
        paste0(cap, "\\attachfile{", file_path, "}")
    } else {
        cap
    }
}

#' @title Caption generator
#' @description Use this with chunk option \code{fig.cap} to attach a copy
#' of the produced graphic in the resulting pdf.
#' @param cap Caption
#' @param attach attach graph? if \code{NULL} then this parameter will
#' be taken from \code{opts_proh$get('attach_graph')}
#' @param ext what is the file extension? if \code{NULL} then this parameter will
#' be taken from \code{opts_proh$get('graph_dev')}
#' @param warn warn if extension does not seem available?
#' @note Beware if you want different extension in the attachment than
#'   appears in your pdf. LaTeX has a default order in which it chooses
#'   formats if a file name is not unique (knitr does not specify extension).
#'   E.g. you might want pdf:s in your pdf but .png in you attachment. Then
#'   you can specify something like
#'   \\DeclareGraphicsExtensions\{.pdf,.eps,.png,.jpg,jpeg\} in the preamble
#'   of you LaTeX document.
#' @export
fig_cap <- function(cap, attach = NULL, ext = NULL, warn = TRUE){
    if(is.null(attach)) attach <- opts_attacher$get("attach_graph")
    if(attach){
        lab <- knitr::opts_current$get('label')
        path <- opts_current$get('fig.path')
        if(is.null(ext)){
            ext <- opts_attacher$get("graph_dev")
        }
        if(!ext %in% knitr::opts_current$get('dev')){
            if(warn) warning("[attacher::fig_cap] the file extension may not exist")
        }
        paste0(cap, " \\attachfile{", path, lab,"-1.",ext,"}")
    } else {
        cap
    }
}
