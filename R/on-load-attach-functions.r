# .onLoad = function(libname, pkgname){
#     attacher_info <- new.env(parent = getNamespace("attacher"))
#     opts_attacher$restore()
# }

.onAttach = function(libname, pkgname){
    knit_hooks$set(chunk = hook_tab.cap())
    packageStartupMessage('[package:attacher]: knitr hook "tab.cap" is now available')
    evalq(opts_knit$set(eval.after = c("tab.cap", "tab.scap", "fig.cap", "fig.scap")),
          envir = getNamespace('knitr'))
}

.onDetach = function(libname){
    evalq(knit_hooks$set(tab.cap = NULL, tab.scap = NULL), envir = getNamespace('knitr'))
    packageStartupMessage('[package:attacher]: knitr hook "tab.cap" has been removed')
}
