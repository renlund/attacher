# .onLoad = function(libname, pkgname){
#     attacher_info <- new.env(parent = getNamespace("attacher"))
#     opts_attacher$restore()
# }

.onAttach = function(libname, pkgname){
    knit_hooks$set(chunk = hook_tab.cap())
    packageStartupMessage(paste0('[package:attacher]: knitr hook "tab.cap" is now available.\n',
                                 'NOTE: this package is obsolete and not maintained (and',
                                 ' possibly not great to begin with).')
    evalq(opts_knit$set(eval.after = c("tab.cap", "fig.cap", "fig.scap")), ## "tab.scap",
          envir = getNamespace('knitr'))
}

.onDetach = function(libname){
    evalq(knit_hooks$set(tab.cap = NULL, tab.scap = NULL), envir = getNamespace('knitr'))
    packageStartupMessage('[package:attacher]: knitr hook "tab.cap" has been removed')
}
