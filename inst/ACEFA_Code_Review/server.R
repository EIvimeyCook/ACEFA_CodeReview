markdown_to_html <- function(text) {
  if (is.null(text) || text == "") {
    return(text)
  }

  # Convert newlines to <br>
  text <- gsub("\n", "<br>", text)

  # Convert bold **text** to <strong>text</strong>
  text <- gsub("\\*\\*(.+?)\\*\\*", "<strong>\\1</strong>", text)

  # Convert italic *text* to <em>text</em>
  text <- gsub("(?<!\\*)\\*(?!\\*)(.+?)(?<!\\*)\\*(?!\\*)", "<em>\\1</em>", text, perl = TRUE)

  # Convert links [text](url) to <a href="url">text</a>
  text <- gsub("\\[(.+?)\\]\\((.+?)\\)", '<a href="\\2" target="_blank">\\1</a>', text)

  # Convert inline code `code` to <code>code</code>
  text <- gsub("`(.+?)`", "<code>\\1</code>", text)

  return(text)
}

server <- function(input, output, session) {
  
  observe({                     
    shinyjs::toggleState(
      id        = "download_CodeMd",
      condition = all(!is.null(input$check_1),
                      !is.null(input$check_2),
                      !is.null(input$check_3),
                      !is.null(input$check_4),
                      !is.null(input$check_5))
    )
  })
  
  
  
  observeEvent(input$download_CodeMd, {
    card_data <- lapply(names(card_labels), function(id) {
      response <- input[[paste0("check_", id)]]
      comment <- input[[paste0("item_", id, "_comment")]]
      if (!is.null(response)) {
        list(
          id = id,
          label = card_labels[[id]],
          response = response,
          comment = comment
        )
      } else {
        NULL
      }
    })
    card_data <- Filter(Negate(is.null), card_data)

    code_base <- if (input$code_base == "") "No Code Base ID Given" else input$code_base
    reviewer_name <- if (input$reviewer_name == "") "No Name Given" else input$reviewer_name
    filename <- paste0(
      "ACEFA_Forecasting_Model_Code_Review_Report_", gsub("[^A-Za-z0-9_-]", "_", code_base), "_",
      gsub("[^A-Za-z0-9_-]", "_", reviewer_name), ".html"
    )

    html <- paste0(
      '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>ACEFA Forecasting Model Code Review Report </title>',
      "<style>body{font-family:Arial,sans-serif;max-width:800px;margin:40px auto;padding:20px;line-height:1.6}",
      "h1{color:#2c3e50;border-bottom:3px solid #3498db;padding-bottom:10px}",
      "h2{color:#34495e;margin-top:30px;border-bottom:2px solid #95a5a6;padding-bottom:5px}",
      "h3{color:#7f8c8d;margin-top:20px}",
      ".info{background-color:#ecf0f1;padding:15px;border-radius:5px;margin:20px 0}",
      ".info p{margin:5px 0}",
      ".checklist-item{background-color:#f8f9fa;padding:15px;margin:15px 0;border-left:4px solid #3498db;border-radius:3px}",
      ".response{font-weight:bold;color:#2980b9}",
      ".comment{margin-top:10px;font-style:italic;color:#555}",
      "code{background:#f4f4f4;padding:2px 6px;border-radius:3px;font-family:monospace;font-size:0.9em}",
      "a{color:#3498db;text-decoration:none}",
      "a:hover{text-decoration:underline}",
      "hr{border:none;border-top:2px solid #bdc3c7;margin:30px 0}",
      ".footer{text-align:center;color:#7f8c8d;font-size:0.9em;margin-top:40px}",
      ".download-btn{display:inline-block;padding:10px 20px;background:#3498db;color:white;",
      "text-decoration:none;border-radius:5px;margin:20px 0;cursor:pointer;border:none;font-size:16px}",
      ".download-btn:hover{background:#2980b9}",
      "@media print{.no-print{display:none}}",
      "</style></head><body>",
      '<div class="no-print" style="text-align:center">',
      '<button class="download-btn" onclick="downloadHTML()">💾 Download This Report</button>',
      "</div>",
      "<h1>ACEFA Forecasting Model Code Review Report</h1>",
      '<div class="info">',
      "<p><strong>Code Base:</strong> ", code_base, "</p>",
      "<p><strong>Reviewer:</strong> ", reviewer_name, "</p>",
      "<p><strong>Date:</strong> ", Sys.Date(), "</p>",
      "</div><hr><h2>ACEFA Forecasting Model Code Review Checklist</h2>"
    )

    for (card in card_data) {
      # Match the Rmd logic exactly
      response_text <- ifelse(is.null(card$response), "Not answered", card$response)
      comment_text <- ifelse(is.null(card$comment) || card$comment == "", "No comment provided.", card$comment)

      # Convert markdown to HTML for both label and comment
      label_html <- markdown_to_html(card$label)
      comment_text <- markdown_to_html(comment_text)

      html <- paste0(
        html,
        '<div class="checklist-item"><h3>', label_html, "</h3>",
        '<p class="response">Response: ', response_text, "</p>",
        '<p class="comment">Comment: ', comment_text, "</p>",
        "</div>"
      )
    }

    html <- paste0(
      html,
      '<hr><div class="footer"><p><em>Report generated using ACEFA Forecasting Model Code Review App</em></p></div>',
      "<script>",
      "function downloadHTML() {",
      '  var blob = new Blob([document.documentElement.outerHTML], {type: "text/html"});',
      "  var url = URL.createObjectURL(blob);",
      '  var a = document.createElement("a");',
      "  a.href = url;",
      '  a.download = "', filename, '";',
      "  document.body.appendChild(a);",
      "  a.click();",
      "  document.body.removeChild(a);",
      "  URL.revokeObjectURL(url);",
      "}",
      "</script>",
      "</body></html>"
    )

    session$sendCustomMessage("openHTML", html)
  })

  data_modal <- shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    size = "l",
    fade = TRUE,
    shiny::div(
      style = "display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;",
      shiny::tags$img(src = "ACEFA.png", height = "88px", width = "120px", style = "margin-bottom: 20px;"),
      br(),
      textInput("code_base", tags$b("Code Base ID"), placeholder = "Enter code base ID", width = "300px"),
      textInput("reviewer_name", tags$b("Reviewer Name"), placeholder = "Enter your name", width = "300px"),
      br(),
     "Output from this data collection will be provided to the code authors and will not be anonymous.",
     br(),
     br(),
      "Reminder: This is a constructive, kind process, let’s use this as a space for learning.",
      actionButton("submit_data_modal", "Submit", class = "btn btn-success", style = "margin-top: 20px;")
    )
  )
  shiny::showModal(data_modal)

  shiny::observeEvent(input$submit_data_modal, {
    output$code_base_output <- shiny::renderUI({
      if (input$code_base == "") {
        shiny::HTML(paste(
          "<p>",
          "<b>ID:</b> No Code Base ID Given",
          "</p>"
        ))
      } else {
        (
          shiny::HTML(paste(
            "<p>",
            "<b>ID:</b>",
            input$code_base,
            "</p>"
          ))
        )
      }
    })

    output$reviewer_name_output <- shiny::renderUI({
      if (input$reviewer_name == "") {
        shiny::HTML(paste(
          "<p>",
          "<b>Name:</b> No Name Given",
          "</p>"
        ))
      } else {
        (
          shiny::HTML(paste(
            "<p>",
            "<b>Name:</b>",
            input$reviewer_name,
            "</p>"
          ))
        )
      }
    })
    shiny::removeModal()
  })
}
