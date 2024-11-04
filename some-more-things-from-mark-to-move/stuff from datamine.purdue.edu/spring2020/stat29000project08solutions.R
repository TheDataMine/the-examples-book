# 1a
# The shinyApp function is run once, when you launch your app

# 1b
# The server function is run once each time a user visits your app

# 1c
# The R expressions inside render* functions are run many times. Shiny runs them once each time a user change the value of a widget.

# 1d
# R accepts input from a file, parses it, and evaluates the expressions. Basically inserts code.

# 1e
# When `source` is run inside the app.R file, it assumes the file is in the same directory as the app.R file.

# 2 a/b/c
library(shiny)
library(ggplot2)
source("rt_solutions.R")

ui_2 <- fluidPage(

    # App title
    titlePanel("Rotten tomatoes guesser"),

    # Search bar
    textInput("search_term", h3("Search for a movie"), value="wall-e"),

    # Tomatometer weight input
    numericInput(inputId = "tomatometer_weight", h3("Tomatometer weight"), value=.5),

    # Output image
    uiOutput(outputId = "cover_image"),

    # Output tomatometer score
    uiOutput(outputId = "tomatometer_score"),

    # Output audience score
    uiOutput(outputId = "audience_score"),

    # Output the title
    uiOutput(outputId = "title"),

    # Output the critics consensus
    uiOutput(outputId = "critics_consensus"),

    # Output the datamine score
    uiOutput(outputId = "datamine_score")
)

server_2 <- function(input, output) {

    # wrap rt_id in a reactive function for flexibility
    rt_id <- reactive({
        guess_id(input$search_term)
    })

    # wrap the datamine score in a reactive expression
    datamine_score <- reactive({
        # strip % sign from scores
        tomatometer_score <- gsub("%", "", tomatometer_score())
        audience_score <- gsub("%", "", audience_score())

        # convert to numeric
        tomatometer_score <- as.numeric(tomatometer_score)
        audience_score <- as.numeric(audience_score)

        # calculate "datamine_score"
        datamine_score <- input$tomatometer_weight*tomatometer_score + (1-input$tomatometer_weight)*audience_score

        # convert back to a percentage
        paste0(datamine_score, "%")
    })

    # reactive expression that updates link to image when input$search changes
    cover_image_link <- reactive({
        scrape_cover_link(rt_id())
    })

    # reactive expression that updates the tomatometer score when input$search changes
    tomatometer_score <- reactive({
        scrape_tomatometer_score(rt_id())
    })

    # reactive expression that updates the tomatometer score icon when input$search changes
    audience_score <- reactive({
        scrape_audience_score(rt_id())
    })

    # reactive expression that updates the title when input$search changes
    title <- reactive({
        scrape_title(rt_id())
    })

    # reactive expression that updates the critics consensus when input$search changes
    critics_consensus <- reactive({
        scrape_critics_consensus(rt_id())
    })

    # render's the cover image
    output$cover_image <- renderUI({
        div(id="cover_image", tags$img(src=cover_image_link()))
    })

    # render's the tomatometer score
    output$tomatometer_score <- renderUI({
        div(id="tomatometer_score", tags$strong(tomatometer_score()))
    })

    # render's the audience score
    output$audience_score <- renderUI({
        div(id="audience_score", tags$strong(audience_score()))
    })

    # render's the title
    output$title <- renderUI({
        div(id="title", tags$h1(title()))
    })

    # render's the critics consensus
    output$critics_consensus <- renderUI({
        div(id="critics_consensus", tags$p(critics_consensus()))
    })

    # render's the datamine score
    output$datamine_score <- renderUI({
        div(id="datamine_score", tags$strong(datamine_score()))
    })

}

# Create Shiny app ----
shinyApp(ui = ui_2, server = server_2)