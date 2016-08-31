#ui.R
library(shiny)
coffee <- read.csv("stcf.csv", stringsAsFactors = FALSE)
ui <- fluidPage(
    selectInput("coffee", 
                label = "Choose a coffee",
                choices = unique(coffee$Beverage), 
                selected = "Caffe Misto"),
    selectInput("size", 
                label = "Choose a size",
                choices = c("Short","Tall","Grande","Venti"), 
                selected = "Tall"),
    sliderInput(inputId = "drinkTime",
                label = "Consumed at what Hour",
                min = 0,
                max = 23,
                value = 6,
                step = 1),
    plotOutput("decay")
)
