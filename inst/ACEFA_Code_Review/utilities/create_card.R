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
      width = "400px",
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

card_labels <- list(
  
  "1" = "How well does the code base allow for a reviewer to read through the code? E.g. Is there a metadata file or associated readme? Is it organised? Are the inputs in a clearly marked location, is the code organised, are outputs clearly saved somewhere? Is there a clear roadmap to recreate the analysis?",
  
  "2" = "How well does the code base allow for a reviewer to assess what the code should do, based on methods described?",
  
  "3" = "How well does the code base allow for the reviewer to install or download all the required code and run from start to finish with the given instructions?",
  
  "4" = "How well does the code base reproduce the results?",
  
  "5" = "How well is the code base written according to best practice? E.g., Is there clear style? Are objects and functions named correctly, is there a logical order in the code?"
  
)