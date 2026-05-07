
ui <- function() {
 
  bslib::page_fluid(
    theme = bslib::bs_theme(
      version = 5,
     bootswatch = "zephyr"
    ),
    shiny::tags$script(shiny::HTML("
  Shiny.addCustomMessageHandler('openHTML', function(html) {
    var win = window.open('', '_blank');
    win.document.write(html);
    win.document.close();
  });
")),
    shinyjs::useShinyjs(),
    title = "ACEFA Forecasting Model Code Review",
    fluidRow(
      column(
        width = 1,
        actionButton(
          inputId = "clickme",
          label = tags$img(src = "ACEFA.png", height = "78px", width = "100px",
                        onclick ="window.open('https://acefa-epi-analytics.org/', '_blank')"),
          style = "color: white; background-color: white; border-color: white; box-shadow: 0px 0px 0px 0px white;",
        )
      ),
      column(
        width = 11,
        div(
          style = "display: flex; align-items: center; height: 78px;",
          h1("ACEFA Forecasting Model Code Review", style = "margin: 0;")
        )
      )
    ),
    bslib::layout_sidebar(
      sidebar =
        bslib::sidebar(
          width = 400,
          position = "left",
          open = "open",
          shiny::actionButton("instruct_code", "Instructions!", class = "btn-success"),
          shiny::div(
            id = "review_summary",
            bslib::card(
            shiny::htmlOutput("code_base_output"),
            shiny::htmlOutput("reviewer_name_output"),
          )
          ),
          shiny::actionButton("download_CodeMd", "View HTML Report", class = "btn-info")
        ),
      div(id = "stage1_title",
      h4("Clarity")
      ),
      create_card("1", "How well does the code base allow for a reviewer to read through the code? e.g. Is there a metadata file or associated readme? Is it organised? Are the inputs in a clearly marked location? Is the code organised, are outputs clearly saved somewhere? Is there a clear roadmap to recreate the analysis?"),
      br(),
      div(id = "stage2_title",
      h4("Fidelity")
      ),
      create_card("2", "How well does the code base allow for a reviewer to assess what the code should do, based on methods described?"),
      br(),
      div(id = "stage3_title",
      h4("Usability")
      ),
      create_card("3", "How well does the code base allow for the reviewer to install or download all the required code and run from start to finish with the given instructions?"),
      br(),
      div(id = "stage4_title",
      h4("Reproducibility")
      ),
      create_card("4", "How well does the code base reproduce the results?"),
      br(),
      div(id = "stage5_title",
      h4("Quality")
      ),
      create_card("5", "How well is the code base written acording to best practice? E.g., Is there clear style? Are objects and functions named correctly, is there a logical order in the code?")
    )
    )
}
