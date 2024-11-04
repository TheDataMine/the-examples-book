library(shiny)
library(DT)
library(markdown)
library(DiagrammeR)

source("utils.R")

ui <- fluidPage(
    titlePanel("Username & Password Authentication", "Demo"),
    tabsetPanel(
                tabPanel("Overview",
                    sidebarLayout(
                        sidebarPanel(includeMarkdown("overview.md")),
                        mainPanel(
                            mermaid("
graph TB
  A[User sign's up with username and password]-->B[A random salt is generated]
  B-->C[Salt is appended to password]
  C-->D[The result is hashed using a hash function]
  D-->E[The salt is prepended to the result]
  E-->F[The username and salted and hashed password is stored in database]
  G[User signs in with username and password]-->H{Does user exist?}
  H-->J[No]-->A
  H-->I[Yes]
  I-->K[Hashed password is extracted from the database]
  K-->L[Salt is extracted from beginning of the hash]
  L-->M[Salt is appended to user provided password]
  M-->N[Result is hashed]
  N-->O[Salt is prepended to result]
  O-->P[Result is compared with hashed password from database]
  P-->Q{Match?}
  Q-->R[No]-->S[Log in fails]-->G
  Q-->T[Yes]-->U[Log in succeeds]
")
                        ),
                    ),
                ),

                tabPanel("1. Signing up",
                    sidebarLayout(
                        sidebarPanel(
                            includeMarkdown("step1.md")
                        ),
                        mainPanel(
                            textInput("username1", h3("Username: ")),
                            textInput("password1", h3("Password: "))
                        )
                    )

                ),

                tabPanel("2. Hashing",
                         sidebarLayout(
                             sidebarPanel(
                                 includeMarkdown("step2.md")
                             ),
                             mainPanel(
                                h3("Username: "),
                                textOutput("u1"),
                                h3("Password: "),
                                textOutput("p1"),
                                h3("Hashed password: "),
                                textOutput("passhash")
                             )
                         )
                ),

                tabPanel("3. Salting",
                         sidebarLayout(
                             sidebarPanel(
                                 includeMarkdown("step3.md")
                             ),
                             mainPanel(
                                 h3("Username: "),
                                 textOutput("u2"),
                                 h3("Password: "),
                                 textOutput("p2"),
                                 h3("Salt: "),
                                 textOutput("salt"),
                                 h3("Salted password: "),
                                 textOutput("salted_password"),
                                 h3("Hashed salted password: "),
                                 textOutput("hash_salted_password"),
                                 h3("Salt+Hashed salted password: "),
                                 textOutput("final_hash"),
                                 br(),

                                 p("Changing the salt completely changes the end result. Note that the password itself hasn't changed. This is why two people with the same password will have different hashes."),
                                 actionButton("newsalt", "New salt")
                             )
                         )
                ),

                tabPanel("4. Storing",
                         sidebarLayout(
                             sidebarPanel(
                                 includeMarkdown("step4.md")
                             ),
                             mainPanel(
                                 textInput("username2", h3("Username: ")),
                                 textInput("password2", h3("Password: ")),
                                 actionButton("adduser", "Add user"),
                                 br(),
                                 br(),
                                 DT::dataTableOutput("userDB")

                             )
                         ),

                ),

                tabPanel("5. Logging in",
                         sidebarLayout(
                             sidebarPanel(
                                 includeMarkdown("step5.md")
                             ),
                             mainPanel(
                                textInput("username3", h3("Username: ")),
                                textInput("password3", h3("Password: ")),
                                actionButton("login", "Log in"),
                                textOutput("login_status"),
                             )
                         )
                )
    ),
)

server <- function(input, output) {

    ###########
    # outputs #
    ###########

    output$p1 <- renderText({
      input$password1
    })

    output$p2 <- renderText({
      input$password1
    })

    output$u1 <- renderText({
      input$username1
    })

    output$u2 <- renderText({
      input$username1
    })

    output$passhash <- renderText({
      sha256(input$password1)
    })

    output$salt <- renderText({
      # this is an eventReactive that waits to update its value based
      # on the click of the action button newsalt
      salt()
    })

    # final_hash is the salt concatenated with the hash of the concatenation of password and salt
    output$final_hash <- renderText({
        hash_password(input$password1, salt())
    })

    output$hash_salted_password <- renderText({
        sha256(paste0(input$password1, salt()))
    })

    output$salted_password <- renderText({
        salt_password(input$password1, salt())
    })

    output$login_status <- renderText({
      login_status()
    })

    output$userDB <- DT::renderDataTable({
      DT::datatable(DB$userDB, options = list(lengthMenu = c(5, 10, 15), pageLength = 5))
    })

    #############
    # reactives #
    #############

    # wait for newsalt button to be clicked, and assign a new salt to salt
    salt <- eventReactive(input$newsalt, {
      gensalt()
    })

    # when login is clicked, find hashed password in database for the given username
    # hash the provided password and check to see if hashes match
    login_status <- eventReactive(input$login, {

      # get the hashed password for username
      db_hash <- DB$userDB[usernames==input$username3, "passwords"]

      # if username was found AND hashes matched, return success
      # otherwise, return failure
      if(nrow(db_hash)>0 && check_password(input$password3, db_hash)) {
          return("Success!")
      } else {
          return("Failure!")
      }
    })

    # when you read a value from a reactiveValue, the calling function is reactive to this value
    # in addition, when you modify this value, it notifies any reactive functions that depend on it
    DB <- reactiveValues(userDB = userDB)

    # upon clicking the adduser button, observeEvent will run code
    observeEvent(input$adduser, {
        # creates the hash given the password and salt
        final_pass <- hash_password(input$password2, gensalt())

        # isolate allows you to read the reactive value without becoming reactive to the reactive value
        isolate({
            # add username and hashed password to "database"
            DB$userDB <- rbindlist(list(DB$userDB, list(usernames=input$username2, passwords=final_pass)))
        })
    })

}

shinyApp(ui=ui, server=server)