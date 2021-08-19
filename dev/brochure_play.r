library(brochure)
library(shiny)

brochureApp(
  # First page
  page(
    href = "/",
    ui = fluidPage(
      h1("This is my first page"), 
      plotOutput("plot")
    ),
    server = function(input, output, session){
      output$plot <- renderPlot({
        plot(iris)
      })
    }
  ), 
  # Second page, without any server-side function
  page(
    href = "/page2", 
    ui =  fluidPage(
      h1("This is my second page"), 
      tags$p("There is no server function in this one")
    )
  )
)