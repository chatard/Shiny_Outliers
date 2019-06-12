library(shiny)

# Define UI app:  
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("influence of an outlier in a linear regression"),
        
        # Sidebar with controls : 
        sidebarPanel(
            
        # Sliders to choose x and y coordinates for an outlier:
        #                 
                h3("Coordinates of outlier: "),
                sliderInput("sliderXcoord", 
                            "outlier X position: ", 
                            value =35,
                            min = -20, 
                            max = 80),
                
                sliderInput("sliderYcoord", 
                            "outlier Y position: ", 
                            value =100,
                            min = -100, 
                            max = 200),
                
                br(),
        # New slider to modify sample size [not necessary.] : 
        
                h3("Possibly modify the sample size: "),
                sliderInput("sliderSizesamp",
                            "sample size",
                            value =55,
                            min=40,
                            max=70),
                
                submitButton("Submit")
        ),
        
        # Show a tabset that includes a plot, a summary ...
        # some explanations in help tab : 
        
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", plotOutput("plot")), 
                        tabPanel("Summary", verbatimTextOutput("res")), 
                        tabPanel("Help", htmlOutput("help")),
                        type = "pills"
                )
        )
))
