#server.R
library(shiny)
library(ggplot2)
library(scales)
Sys.setlocale("LC_TIME", "English")
#load caffeine data
coffee <- read.csv("stcf.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
    # Calculate caffeine according to input selected.
    # Model assumed a 11% decay of caffeine every hour. 
    # When drinking more than 1 cup, effects will be add to data(), starting from the time taken.
    # The time axis (x-axis) is in POSIXct format, assuming date of today.
    data <- reactive({
            data.frame(
                Hours= seq(from=0, to =24, by=1)*3600+strptime(paste(as.Date(Sys.time()), input$drinkTime), format="%Y-%m-%d %H"),
                Caffeine= as.numeric(input$morning==TRUE)*coffee$Caffeine[which(coffee$Beverage==input$coffee & coffee$Size==input$size)]*0.89^seq(from=0, to =24, by=1)
                    + as.numeric(input$afternoon==TRUE)*append(head(coffee$Caffeine[which(coffee$Beverage==input$coffee2 & coffee$Size==input$size2)]*0.89^seq(from=0, to =24, by=1), input$drinkTime+25-input$drinkTime2), rep(0,input$drinkTime2-input$drinkTime),after=0) 
                    + as.numeric(input$evening==TRUE)*append(head(coffee$Caffeine[which(coffee$Beverage==input$coffee3 & coffee$Size==input$size3)]*0.89^seq(from=0, to =24, by=1), input$drinkTime+25-input$drinkTime3), rep(0,input$drinkTime3-input$drinkTime),after=0)
            )

    })
    
    # Plot of reactive data(), and horizontal line at 50mg.
    output$decay <- renderPlot({
        ggplot(data(), aes(x=Hours, y=Caffeine)) + geom_line() + xlab("") + ylab("Caffeine (mg)") + scale_y_continuous(breaks=seq(0, 500, 10)) + scale_x_datetime(breaks = date_breaks("1 hour")) + theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=16)) + theme(axis.title.y = element_text(size = rel(1.5), angle = 90)) + geom_hline(yintercept=50, color="red", linetype="dashed")
            
    })
}

