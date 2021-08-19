library(brochure)
library(shiny)
library(glouton)

cache_system <- cachem::cache_disk(tempdir())  

nav_links <- tags$ul(
  tags$li(
    tags$a(href = "/", "home"), 
  ),
  tags$li(
    tags$a(href = "/page2", "page2")
  )
)


page_1 <- function() {
    page(
        href = "/",
        ui = fluidPage(
            h1("This is my first page"),
            nav_links,
            textInput("textenter", "Enter a text"), 
            radioButtons(
                "rad",
                "Choose cool stuff",
                choices = c("a", "b", "c"),
                selected = "a",
                inline = TRUE
            ),
            actionButton(
                "save",
                "Save that cookie!"
            ),
            plotOutput("plot")
        ),
        server = function(input, output, session){
            r <- cookie_set()

            rad_choice <- reactive({
                req(input$rad)
                input$rad
            })

            observeEvent(input$save, {
                req(rad_choice())
                #browser()
                cache_system$set(
                    paste0(
                        r$cook$brochure_cookie,
                        "text"
                    ),
                    rad_choice()
                    )
            })

            output$plot <- renderPlot({
            plot(iris)
            })
        }
    )
}
