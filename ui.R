#ui.R
library(shiny)
#load caffeine data
coffee <- read.csv("stcf.csv", stringsAsFactors = FALSE) 
ui <- fluidPage(
    title = "Caffeine Calculator",
    h1("Caffeine Calculator"),
    h4("This app calculates how much caffeine remains in the body throughout the day."),
    h4("The default assumes a cup of coffee is consumed in the morning. The black curve in the plot is the caffeine (mg) remaining."),
    h4("Choices of coffee, size, and time consumed can be changed, and the plot will update accordingly."),
    h4("If coffee is also taken in the afternoon/evening, check the corresponding checkbox, and the effect will be added to the plot."),
    h4("A red horizontal line marks 50mg of caffeine. This is to remind that if the level of caffeine is higher than this line when going to bed, the quality of sleep may be affected."),
    hr(),
    
    fluidRow(
        # display choices for morning/afternoon/evening over 3 columns of the same row
        column(4,
               # default is coffee taken in the morning
               checkboxInput(inputId="morning", label="Morning", TRUE),
               # Only show this panel if morning is checked
               conditionalPanel(
                   condition = "input.morning == true",
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
                               max = 12,
                               value = 6,
                               step = 1)
               )
        ),
        column(4,
               checkboxInput(inputId="afternoon", label="Afternoon", FALSE),
               # Only show this panel if afternoon is checked
               conditionalPanel(
                   condition = "input.afternoon == true",
                   selectInput("coffee2",
                               label = "Choose a coffee",
                               choices = unique(coffee$Beverage),
                               selected = "Caffe Misto"),
                   selectInput("size2",
                               label = "Choose a size",
                               choices = c("Short","Tall","Grande","Venti"),
                               selected = "Tall"),
                   sliderInput(inputId = "drinkTime2",
                               label = "Consumed at what Hour",
                               min = 13,
                               max = 18,
                               value = 14,
                               step = 1)
               )
        ),
        column(4,
               checkboxInput("evening", "Evening", FALSE),
               # Only show this panel if Evening is checked
               conditionalPanel(
                   condition = "input.evening == true",
                    selectInput("coffee3",
                                label = "Choose a coffee",
                                choices = unique(coffee$Beverage),
                                selected = "Caffe Misto"),
                    selectInput("size3",
                                label = "Choose a size",
                                choices = c("Short","Tall","Grande","Venti"),
                                selected = "Tall"),
                   sliderInput(inputId = "drinkTime3",
                               label = "Consumed at what Hour",
                               min = 19,
                               max = 23,
                               value = 20,
                               step = 1)

               )
        )
    ),
    
    hr(),
    plotOutput("decay")
    
)
