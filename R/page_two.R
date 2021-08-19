library(brochure)
library(shiny)

nav_links <- tags$ul(
  tags$li(
    tags$a(href = "/", "home"), 
  ),
  tags$li(
    tags$a(href = "/page2", "page2")
  )
)

page_2 <- function() {
  # Second page, without any server-side function
    page(
        href = "/page2", 
        ui =  fluidPage(
        h1("This is my second page"), 
        nav_links,
        verbatimTextOutput("textdisplay")
        ),
        server = function(input, output, session) {
            r <- cookie_set()
            output$textdisplay <- renderPrint({
                #browser()
                cache_system$get(
                    paste0(
                        r$cook$brochure_cookie,
                        "text"
                    )
                )
            })

        }
    )
}
