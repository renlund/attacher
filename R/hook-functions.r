#' @title Chunk Tag \code{tab.cap} Extension for package:knitr
#'
#' @description \pkg{knitr} hook functions are called when the corresponding
#'   chunk options are not \code{NULL} to do additional jobs beside the R code
#'   in chunks. \pkg{enumeratermd} provides the hook \code{tab.cap} which adds a
#'   Pandoc table caption after the chunk. It is meant to be analogous to chunk
#'   option \code{fig.cap}.
#'
#' @details the function hook_tab.cap is set as a hook in \pkg{knitr} when
#'   \pkg{attacher} is attached (and removed when \pkg{attacher} is
#'   detached).This hook creates an \\begin{table} environment before
#'   the chunk output and a \\end{table} after the chunk output (+ label, etc.)
#'
#' @references \url{http://yihui.name/knitr/hooks#chunk_hooks}
#' @import knitr

hook_tab.cap <- function(){
    hook_chunk <- knit_hooks$get("chunk")
    function(x, options) {
        x <- hook_chunk(x, options)
        if(!is.null(val <- options$tab.cap)){
            #attach <- if(!is.na(val[2])) val[2] else opts_attacher$get("attach_table")
            long <- val[1]
            where <- if(!is.na(val['where'])) val['where'] else "htb"
            label <- if(!is.na(val['label'])) {
                val['label']
            } else {
                paste0("tab:", knitr::opts_current$get("label"))
            }
            x <- gsub('\\\\(begin|end)\\{kframe\\}', '', x) # WHY DO I NEED TO DO THIS?
            paste0(
                "\\begin{table}[", where,
                "]\n\\caption[", long, "]{", long, "}\\label{", label,
                "}\n\\centering\\vspace{0.2cm}", x, "\\end{table}"
            )
        } else {
            x
        }
    }
}
