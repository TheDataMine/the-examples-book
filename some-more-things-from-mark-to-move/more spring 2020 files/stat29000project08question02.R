library(shiny)
library(ggplot2)
source("rt.R")

ui_2 <- fluidPage(

    # App title
    titlePanel("Rotten tomatoes guesser"),

    # Search bar
    textInput("rt_id", h3("Type a rotten tomatoes id"), value="frozen_2013"),

    # Output image
    uiOutput(outputId = "cover_image"),

    # Output tomatometer score
    uiOutput(outputId = "tomatometer_score"),

    # Output audience score
    uiOutput(outputId = "audience_score"),

    # Output the title
    uiOutput(outputId = "title"),

    # Output the critics consensus
    uiOutput(outputId = "critics_consensus")
)

server_2 <- function(input, output) {

    # wrap rt_id in a reactive function for flexibility
    rt_id <- reactive({
        input$rt_id
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

}

# Create Shiny app ----
shinyApp(ui = ui_2, server = server_2)