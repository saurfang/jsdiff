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
jsdiff <- function(oldStr, newStr,
                   diffType = c("Lines", "Words", "Chars"),
                   language = "r",
                   width = NULL, height = NULL) {
  diffType <- match.arg(diffType)

  # forward options using x
  x = list(
    oldStr = toCharacter(oldStr),
    newStr = toCharacter(newStr),
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

toCharacter <- function(x) {
  if(!is.character(x)) {
    paste(capture.output(print(x)), collapse = "\n")
  } else {
    x
  }
}

#' @import shiny
jsdiff_html <- function(id, style, class, ...){
  tags$div(id = id, class = class,
           radioButtons("diff_type",  "Diff", c("Chars", "Words", "Lines"), inline = TRUE),
           tags$pre(tags$code())
  )
}

#' Widget output function for use in Shiny
#' @inheritParams htmlwidgets::shinyWidgetOutput
#' @param width of the widget element
#' @param height of the widget element
#' @export
jsdiffOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'jsdiff', width, height, package = 'jsdiff')
}

#' Widget render function for use in Shiny
#' @inheritParams htmlwidgets::shinyRenderWidget
#' @export
renderJsdiff <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, jsdiffOutput, env, quoted = TRUE)
}
