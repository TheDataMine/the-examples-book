ui_2a <- fluidPage(
  titlePanel("Boxes"),

  fluidRow(

    column(12,
           h3("Box 1"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),
  ),

  fluidRow(

    column(3,
           h3("Box 5"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 6"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 7"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 8"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),
  ),

  fluidRow(

    column(3,
           h3("Box 9"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 10"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 11"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),

    column(3,
           h3("Box 12"),
           textInput("text", h3("Text input"),
                     value = "Enter text...", width="100%")),
  )

)

# Define server logic ----
server_2a <- function(input, output) {

}

# Run the app ----
shinyApp(ui = ui_2a, server = server_2a)