library(shiny)
library(ggplot2)

# 1a
# Define UI for app that draws a histogram ----
ui_1a <- fluidPage(

    # App title ----
    titlePanel("Solution 1a!"),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(

            # Input: Slider for the number of bins ----
            sliderInput(inputId = "bins",
                        label = "Number of bins:",
                        min = 25,
                        max = 50,
                        value = 25)

        ),

        # Main panel for displaying outputs ----
        mainPanel(

            # Output: Histogram ----
            plotOutput(outputId = "oldFaithfulHistogram")

        )
    )
)

# Define server logic required to draw a histogram ----
server_1a <- function(input, output) {

    # Histogram of the Old Faithful Geyser Data ----
    # with requested number of bins
    # This expression that generates a histogram is wrapped in a call
    # to renderPlot to indicate that:
    #
    # 1. It is "reactive" and therefore should be automatically
    #    re-executed when inputs (input$bins) change
    # 2. Its output type is a plot
    output$oldFaithfulHistogram <- renderPlot({

        x    <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        hist(x, breaks = bins, col = "#CFB53B", border = "white",
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")

    })

}

# Create Shiny app ----
# shinyApp(ui = ui_1a, server = server_1a)

# 1b
# Define UI for app that draws a histogram ----
ui_1b <- fluidPage(

    # App title ----
    titlePanel(h1("Solution 1b!", align="center")),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(position="right",

        # Sidebar panel for inputs ----
        sidebarPanel(
            h2("Settings", align="center"),

            # Input: Slider for the number of bins ----
            sliderInput(inputId = "bins",
                        label = "Number of bins:",
                        min = 25,
                        max = 50,
                        value = 25)

        ),

        # Main panel for displaying outputs ----
        mainPanel(

            h1("Directions"),
            p("To use ", strong("this"), " app, you should first ", em("read"), " the directions ", a("here", href="https://lmgtfy.com/?q=wait%2C+where+are+the+directions%3F"), "."),
            h2("Choo choo!"),
            img(src="purdue.png", height=100, width=75),

            # Output: Histogram ----
            plotOutput(outputId = "oldFaithfulHistogram")

        )
    )
)

# Define server logic required to draw a histogram ----
server_1b <- function(input, output) {

    # Histogram of the Old Faithful Geyser Data ----
    # with requested number of bins
    # This expression that generates a histogram is wrapped in a call
    # to renderPlot to indicate that:
    #
    # 1. It is "reactive" and therefore should be automatically
    #    re-executed when inputs (input$bins) change
    # 2. Its output type is a plot
    output$oldFaithfulHistogram <- renderPlot({

        x    <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        ggplot(data.frame(waiting=x), aes(x=waiting))+
            geom_histogram(bins=input$bins, color="black", fill="#CFB53B")

    })

}

# Create Shiny app ----
# shinyApp(ui = ui_1b, server = server_1b)

# 2a
ui_2a <- fluidPage(
    titlePanel("Boxes"),

    fluidRow(

        column(12,
               h3("Box 1"),
               textInput("text", h3("Text input"),
                         value = "Enter text...", width="100%")),
    ),

    fluidRow(

        column(6, offset=3,
               h3("Box 6"),
               textInput("text", h3("Text input"),
                         value = "Enter text...", width="100%")),


    ),

    fluidRow(

        column(3,
               h3("Box 9"),
               textInput("text", h3("Text input"),
                         value = "Enter text...", width="100%")),

        column(3, offset=3,
               h3("Box 11"),
               textInput("text", h3("Text input"),
                         value = "Enter text...", width="100%")),


    )

)

# Define server logic ----
server_2a <- function(input, output) {

}

# Run the app ----
# shinyApp(ui = ui_2a, server = server_2a)

# 2b
# Define UI for app that draws a histogram ----
ui_2b <- fluidPage(

    # App title ----
    titlePanel(h1("Solution 2b!", align="center")),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(position="right",

                  # Sidebar panel for inputs ----
                  sidebarPanel(
                      h2("Settings", align="center"),

                      # Input: Slider for the number of bins ----
                      sliderInput(inputId = "bins",
                                  label = "Number of bins:",
                                  min = 25,
                                  max = 100,
                                  value = 25),
                      selectInput("distribution", label = "Distribution:",
                                  choices = list("Normal" = 1, "Uniform" = 2, "Exponential" = 3), selected=1),

                  ),

                  # Main panel for displaying outputs ----
                  mainPanel(

                      h1("Directions"),
                      p("To use ", strong("this"), " app, you should first ", em("read"), " the directions ", a("here", href="https://lmgtfy.com/?q=wait%2C+where+are+the+directions%3F"), "."),
                      h2("Choo choo!"),
                      img(src="purdue.png", height=100, width=75),

                      # Output: Histogram ----
                      plotOutput(outputId = "oldFaithfulHistogram")

                  )
    )
)

# Define server logic required to draw a histogram ----
server_2b <- function(input, output) {

    output$oldFaithfulHistogram <- renderPlot({

        if (input$distribution == 1) {
            data <- rnorm(100)
        } else if (input$distribution == 2) {
            data <- runif(100)
        } else if (input$distribution ==3) {
            data <- rexp(100)
        }

        ggplot(data.frame(data=data), aes(x=data))+
            geom_histogram(bins=input$bins, color="black", fill="#CFB53B")

    })

}

# Create Shiny app ----
shinyApp(ui = ui_2b, server = server_2b)