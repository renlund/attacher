[![Travis-CI Build Status](https://travis-ci.org/renlund/attacher.svg?branch=master)](https://travis-ci.org/renlund/attacher)

attacher
--------

An R package to facilitate attachments of tables and figures within a pdf 
(created with LaTeX + knitr) using the `attachfile` LaTeX package. This package
works on top of `knitr`.

 * There is a `fig_cap` function that creates a caption and (if wanted) pastes on
a attachment "link" to the corresponding plot.
 * There is a `tab_cap` functions that creates a caption, writes an object to file,
and created an attachment link to this file. 
 * Additionally, there is a `tab.cap` chunk hook analogous to knitr's `fig.cap`.
 * There is a way to set most parameters globally.
 
See the vignette for details.
