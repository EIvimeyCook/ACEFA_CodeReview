create_card <- function(id, label) {
  label_html <- gsub("\\*\\[(.+?)\\]\\((.+?)\\)\\*", '<a href="\\2" target="_blank">\\1</a>', label)
  
  div(
    id = id,
    HTML(paste0("<strong>", label_html, "</strong>")),
    br(),
    br(),
    shinyWidgets::radioGroupButtons(
      inputId = paste0("check_", id),
      label = NULL,
      choices = c("1 (Poor)", "2", "3", "4", "5 (Excellent)"),
      justified = TRUE,
      width = "800px",
      individual = TRUE,
      selected = character(0),
      size = "normal"
    ),
    textAreaInput(
      inputId = paste0("item_", id, "_comment"),
      label = NULL,
      placeholder = "Comment",
      width = "1000px",
      height = "200px"
    )
  )
}

card_labels <- list(
  
  "1" = "How well does the code base allow a reviewer to understand the code? E.g. Is there a metadata file or associated readme? Is it organised? Are the inputs in a clearly marked location? It is clear which data files are used? Are outputs clearly saved somewhere? Is there a clear roadmap to recreate the analysis?",
  
  "2" = "How consistent does the code appear with the methods as described in the writeup? Are any fixed values in the code referenced clearly in the methods description? Are there aspects of the code that would have been relevant to the methods writeup but were not included? (E.g. Prior specification? Fixed parameter values? Data modification procedures?)",
  
  "3" = "Is it clear what needs to be installed for this code to be run? Is it clear how to run it? Run the code and comment on any issues encountered. ",
  
  "4" = "Are you able to reproduce results consistent with the outputs provided?",
  
  "5" = "Reflect on the quality of the code base as a whole. Is there a consistent style that makes the code readable? Are functions and variables named logically and clearly? Does the code employ common sense guards against human error, eg by specifying variables once and then referring to them by name rather than requiring the user to revise repeated input fields manually? Are there any changes to the code structure or implementation that you would suggest to the author and haven’t been captured by your previous responses?"
  
)

create_card_specific <- function(id, label) {
  label_html <- gsub("\\*\\[(.+?)\\]\\((.+?)\\)\\*", '<a href="\\2" target="_blank">\\1</a>', label)
  
  div(
    id = id,
    HTML(paste0("<strong>", label_html, "</strong>")),
    br(),
    br(),
    shinyWidgets::radioGroupButtons(
      inputId = paste0("check_", id),
      label = NULL,
      choices = c("1 (Poor)", "2", "3", "4", "5 (Excellent)", "Unable to assess"),
      justified = TRUE,
      width = "800px",
      individual = TRUE,
      selected = character(0),
      size = "normal"
    ),
    textAreaInput(
      inputId = paste0("item_", id, "_comment"),
      label = NULL,
      placeholder = "Comment",
      width = "1000px",
      height = "50px"
    )
  )
}

create_card_specific2 <- function(id, label) {
  label_html <- gsub("\\*\\[(.+?)\\]\\((.+?)\\)\\*", '<a href="\\2" target="_blank">\\1</a>', label)
  
  div(
    id = id,
    HTML(paste0("<strong>", label_html, "</strong>")),
    br(),
    br(),
    shinyWidgets::radioGroupButtons(
      inputId = paste0("check_", id),
      label = NULL,
      choices = c("Yes", "No", "Unable to assess"),
      justified = TRUE,
      width = "800px",
      individual = TRUE,
      selected = character(0),
      size = "normal"
    ),
    textAreaInput(
      inputId = paste0("item_", id, "_comment"),
      label = NULL,
      placeholder = "Comment",
      width = "1000px",
      height = "50px"
    )
  )
}
