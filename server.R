#server.R
library(shiny)
library(ggplot2)
library(scales)
Sys.setlocale("LC_TIME", "English")
coffee <- read.csv("stcf.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
    data <- reactive({
        data.frame(
            Hours= seq(from=0, to =24, by=1)*3600+strptime(paste(as.Date(Sys.time()), input$drinkTime), format="%Y-%m-%d %H"), 
            Caffeine= coffee$Caffeine[which(coffee$Beverage==input$coffee & coffee$Size==input$size)]*0.89^seq(from=0, to =24, by=1)
        )

    })

    output$decay <- renderPlot({
        # plot(data()$x,
        #      data()$y,
        #      type="l",
        #      ylab="Caffeine in Body (mg)",
        #      xlab="Hours Since Consuming Coffee")
        ggplot(data(), aes(x=Hours, y=Caffeine)) + geom_line() + xlab("") + ylab("Caffeine")#+ scale_x_datetime(labels=date_format('%H:%M')) 
            
    })
}

