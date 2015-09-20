# These function creates and handles overall attacher options.
# The options are stored in an environment 'attacher_defaults'

# @title attacher_defaults
# @description an environment

attacher_defaults <- new.env(parent = getNamespace("attacher"))

# @title attacher_get
# @description this function retrieves the proh settings
# @param name name of proh setting variable

attacher_get <- function(name){
    if(length(ls(envir=attacher_defaults))==0) attacher_restore()
    defaults <- get("defaults", envir=attacher_defaults)
    if (missing(name))
        defaults
    else {
        L <- as.list(NULL)
        for(k in name){
            L[[k]] <- defaults[[k]]
        }
        if(length(L) == 1) L[[1]] else L
    }
}

# @title attacher_set
# @description this function sets the attacher settings
# @param ... the names and values you want set, e.g. \code{"add_graph"=TRUE}

attacher_set <- function(...){
    if(length(ls(envir=attacher_defaults))==0) attacher_restore()
    dots <- list(...)
    value <- get("value", attacher_defaults)
    for(k in names(dots)) if(!(k %in% value)) dots[[k]] <- NULL
    current <- attacher_get()
    for(k in names(dots)) current[[k]] <- dots[[k]]
    assign(x="defaults", value=current, envir=attacher_defaults)
    invisible(NULL)
}

# @title attacher_restore
# @description this function restores the default attacher settings

attacher_restore <- function(){
    assign(x="defaults", value=list(
        attach_graph = FALSE,
        attach_table = FALSE,
        table_path = "attacher_tables",
        # attach_to_lists = FALSE, # NOT IMPLEMENTED YET
        graph_dev = "pdf",
        table_fnc = utils::write.csv,
        table_ext = "csv"
        #loft = list(figure = list(), table=list())
    ), envir=attacher_defaults)
    assign(x="value", value = names(get(x="defaults", envir=attacher_defaults)), envir=attacher_defaults)
    invisible(NULL)
}

#' @title attacher options
#' @description This list tries to mimic the behaviour of opts_chunk from knitr.
#' Currently these values are maintained with the functions in (the list)
#' \code{opts_attacher}:
#' \itemize{
#' \item attach_graph - use \code{figh} in \code{fig.caption}
#' (in a \code{knitr} chunk), i.e. \code{fig.caption = figh("My Caption")},
#' this forces \code{figh} to include an attach-statement
#' pointing to the relevant figure in 'figure/' .
#' \item attach_table - this .... needs documentation
#' \item table_path a subdirectory in which to store table files
#' \item graph_dev - graphical extension
#' \item table_ext the extension for the table files
#' \item table_fnc - this is the function to write the \code{tableh}-table
#' to file
#' }

#' @export

opts_attacher <- list(
    "get" = attacher_get,
    "set" = attacher_set,
    "restore" = attacher_restore
)
