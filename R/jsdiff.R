#' Create a diff view using jsdiff
#'
#' This creates a jsdiff widget which allows user to see differences between two strings.
#'
#' @param oldStr Old string of text to diff
#' @param newStr New string of text to diff
#' @param diffType Type of diff to use
#' @param language The syntax highlighting language to use
#' @param width Fixed width for widget (in css units). The default is NULL, which results in intelligent automatic sizing based on the widget's container.
#' @param height Fixed height for widget (in css units). The default is NULL, which results in intelligent automatic sizing based on the widget's container.
#'
#' @import htmlwidgets
#'
#' @export
jsdiff <- function(oldStr, newStr, diffType = c("Chars", "Words", "Lines"), language = "r", width = NULL, height = NULL) {
  diffType <- match.arg(diffType)

  # forward options using x
  x = list(
    oldStr = oldStr,
    newStr = newStr,
    diffType = diffType,
    language = language
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'jsdiff',
    x,
    width = width,
    height = height,
    package = 'jsdiff'
  )
}

#' @import shiny
jsdiff_html <- function(id, style, class, ...){
  tags$div(id = id, class = class,
           radioButtons("diff_type",  "Diff", c("Chars", "Words", "Lines"), inline = TRUE),
           tags$pre(tags$code())
  )
}

#' Widget output function for use in Shiny
#'
#' @export
jsdiffOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'jsdiff', width, height, package = 'jsdiff')
}

#' Widget render function for use in Shiny
#'
#' @export
renderJsdiff <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, jsdiffOutput, env, quoted = TRUE)
}
