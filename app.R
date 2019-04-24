library(shiny)
library(plotly)
str(mtcars)
mc <- min(mtcars$cyl)
mx <- max(mtcars$cyl)

ui <- pageWithSidebar(
      
          headerPanel("mtcars Data"),
          sidebarPanel(
            sliderInput("cylinder","Cylinder",min=mc,max=mx,step=1,value=4)
          ),
          mainPanel(
            plotlyOutput("plot"),
            verbatimTextOutput("event")
          )
    
)

server <- function(input, output){
    sub <- reactive({
    req(input$cylinder)
    mtcars[mtcars$cyl==input$cylinder,]
  })
  # renderPlotly() also understands ggplot2 objects!
    output$plot <- renderPlotly({
    ggplot(sub(),aes(x =mpg,y=hp,col=(as.factor(gear))))+geom_line()+ggtitle("Line Plot showing variation of hp with mpg")
  })
}


shinyApp(ui, server)
