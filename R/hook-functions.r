#' @title Chunk Tag \code{tab.cap} Extension for package:knitr
#'
#' @description \pkg{knitr} hook functions are called when the corresponding
#'   chunk options are not \code{NULL} to do additional jobs beside the R code
#'   in chunks. \pkg{eattacher} provides the hook \code{tab.cap} and
#'   \code{tab.scap} which are meant to be analogous to \code{fig.cap} and
#'   \code{fig.scap}, respectively.
#'
#' @details the function hook_tab.cap is set as a hook in \pkg{knitr} when
#'   \pkg{attacher} is attached (and removed when \pkg{attacher} is
#'   detached).This hook creates an \\begin{table} environment before the chunk
#'   output, as well as a caption,  and a \\end{table} after the chunk output (+
#'   label, etc.) The hook_tab.scap shortens the caption for the 'lot'.
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
            short <- long
            where <- if(!is.na(val['where'])) val['where'] else "htb"
            label <- if(!is.na(val['label'])) {
                val['label']
            } else {
                paste0("tab:", knitr::opts_current$get("label"))
            }
            x <- gsub('\\\\(begin|end)\\{kframe\\}', '', x) # WHY DO I NEED TO DO THIS?
            paste0(
                "\\begin{table}[", where,
                "]\n\\caption[", short, "]{", long, "}\\label{", label,
                "}\n\\centering\\vspace{0.2cm}", x, "\\end{table}"
            )
        } else {
            x
        }
    }
}

# -- #' @describeIn hook_tab.cap
# -- #'
#
# hook_tab.scap <- function(){
#     hook_chunk <- knit_hooks$get("chunk")
#     function(x, options) {
#         x <- hook_chunk(x, options)
#         if(!is.null(val <- options$tab.cap)){
#             #attach <- if(!is.na(val[2])) val[2] else opts_attacher$get("attach_table")
#             long <- val[1]
#             short <- strsplit(long, ".")[[1]][1]
#             where <- if(!is.na(val['where'])) val['where'] else "htb"
#             label <- if(!is.na(val['label'])) {
#                 val['label']
#             } else {
#                 paste0("tab:", knitr::opts_current$get("label"))
#             }
#             x <- gsub('\\\\(begin|end)\\{kframe\\}', '', x) # WHY DO I NEED TO DO THIS?
#             paste0(
#                 "\\begin{table}[", where,
#                 "]\n\\caption[", short, "]{", long, "}\\label{", label,
#                 "}\n\\centering\\vspace{0.2cm}", x, "\\end{table}"
#             )
#         } else {
#             x
#         }
#     }
# }
