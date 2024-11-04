hotels <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv', stringsAsFactors = FALSE)
hotels$totalstay <- hotels$stays_in_weekend_nights + hotels$stays_in_week_nights

monthList <- as.list(month.name)
names(monthList) <- month.name

countryList <- as.list(unique(hotels$country))
names(countryList) <- unique(hotels$country)
# Based on the arrival month for the booking, an histogram showing the lead time, that is, the number of days that elapsed between the booking and arrival date.
# Based on the country, a side-by-side boxplot of the total stay nights (week and weekend) for different arrival months.
# Based on whether the reservation is for a repeated guest or not, a summary information (plot or numeric summary) showing the number of days the booking was in the waiting list before being confirmed.

library(shiny)

ui <- fluidPage(

        titlePanel("Vacation booking assistant"),

        sidebarLayout(
                sidebarPanel(
                        h3("Let's plan your next vacation!"),
                        br(),
                        h4('Please select the following information for your next vacation:'),
                        # Arrival month
                        selectInput("month", h3("Arrival month:"),
                                    choices = monthList, selected = 'January'),
                        # Country
                        selectInput("country", h3("Country:"),
                                    choices = countryList, selected = 'USA')
                ),
                mainPanel(
                        tabsetPanel(
                                tabPanel("Lead time",
                                         br(),
                                         "Number of days that elapsed between the booking date in the system and the arrival date.",
                                         br(),

                                         br(),
                                         "Summary information:",
                                         br(),

                                         ),
                                tabPanel("Vacation length",
                                         br(),
                                         "Total stay nights (week and weekend) for different arrival months for the selected country.",
                                         br(),

                                         br(),
                                         "Average stay time per month:",

                        )
                )
        )
)
)

server <- function(input, output) {
        subsetData <- reactive({
                subset(hotels, arrival_date_month == input$month & country == input$country)
        })

        getMonths <- reactive({
                if(input$month =='January'){
                        months <- month.name[which(month.name==input$month) + c(0,1)]
                        months <- c('December', months)
                } else if(input$month == 'December'){
                        months <- month.name[which(month.name==input$month) + c(-1,0)]
                        months <- c(months, 'January')
                } else {
                        months <- month.name[which(month.name==input$month) + c(-1,0,1)]
                }
                months
        })

        subsetData3Months <- reactive({
                subset(hotels, arrival_date_month %in% getMonths() & country == input$country)
        })

        observe({
                hotelSubset <- subsetData()

                hotel3MonthSubset <- subsetData3Months()

                months <- getMonths()


        })
}

shinyApp(ui=ui, server=server)

