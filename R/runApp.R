#' @title Run the ACEFA Forecasting Model Code Review app
#' @description The ACEFA Forecasting Model Code Reviewing app allows code reviewers to review code bases
#' @return A .rtf of the ACEFA Forecasting Model Code Review
#' @export

ACEFA_Code_Review <- function() {
    shiny_env <- 1
    envir <- as.environment(shiny_env)

    appDir <- system.file("ACEFA_Code_Review", package = "ACEFA_Code_Review")
    shiny::runApp(appDir, display.mode = "normal")
  }