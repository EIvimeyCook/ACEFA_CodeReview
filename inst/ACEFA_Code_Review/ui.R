
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
          shiny::div(
            id = "review_summary",
            bslib::card(
            shiny::htmlOutput("code_base_output"),
            shiny::htmlOutput("reviewer_name_output"),
            hr(),
            h6("Output from this data collection will be provided to the code authors and will not be anonymous."),
            h6("Reminder: This is a constructive, kind process, let’s use this as a space for learning."),
          )
          ),
          shiny::actionButton("download_CodeMd", "View HTML Report", class = "btn-info")
        ),
      div(id = "stage1_title",
      h5("Step 1: Log in to the One Drive Kate Senior invited you to. In a manner consistent with the data security protocols, get a local version of the code, test data, and comparison outputs."),  
      br(),
      h3("Clarity")
      ),
      create_card("1", "How well does the code base allow a reviewer to understand the code? e.g. Is there a metadata file or associated readme? Is it organised? Are the inputs in a clearly marked location? It is clear which data files are used? Are outputs clearly saved somewhere? Is there a clear roadmap to recreate the analysis?"),
      hr(),
      div(id = "stage2_title",
      h5("Step 2: Check out the methods description in the One Drive. To the extent possible, look at the code and compare against the described methods."),    
      br(),
      h3("Fidelity")
      ),
      create_card_specific("2", "How consistent does the code appear with the methods as described in the writeup? Are any fixed values in the code referenced clearly in the methods description? Are there aspects of the code that would have been relevant to the methods writeup but were not included? (Eg. Prior specification? Fixed parameter values? Data modification procedures?)"),
      hr(),
      div(id = "stage3_title",
      h5("Step 3: Use the instructions in the code and test data in the One Drive and attempt to run the code from start to finish. If it appears this will take an infeasible amount of time, perhaps attempt to run on a single pathogen/location pair. "),
      br(),
      h3("Usability")
      ),
      create_card("3", "Is it clear what needs to be installed for this code to be run? Is it clear how to run it? To extent possible, run the code and comment on any issues encountered."),
      hr(),
      div(id = "stage4_title",
      h5("Step 4: Attempt to produce final outputs per the instructions and review the output against the demo output in One Drive. "),
      br(),
      h3("Reproducibility")
      ),
      create_card_specific("4", "Are you able to reproduce results consistent with the outputs provided?"),
      hr(),
      div(id = "stage5_title",
      h5("Step 5. Reflect on the code base as a whole. ") , 
      br(),
      h3("Quality")
      ),
      create_card("5", "Reflect on the quality of the code base as a whole. Is there a consistent style that makes the code readable? Are functions and variables named logically and clearly? Does the code employ common sense guards against human error, eg by specifying variables once and then referring to them by name rather than requiring the user to revise repeated input fields manually? Are there any changes to the code structure or implementation that you would suggest to the author and haven’t been captured by your previous responses?")
    )
    )
}
