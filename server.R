library(shiny)

shinyServer(function(input, output) {
        
        setSampleSize <- reactive({
                samplesize<-input$sliderSizesamp
        })
        setCoords <- reactive({
                currentxoutlier<-input$sliderXcoord
                currentyoutlier<-input$sliderYcoord
                
        })
        
        
        
        output$plot <- renderPlot({
                
                set.seed(42)
                flagO = TRUE
                samplesize<-input$sliderSizesamp
                slope <- 1
                intercept <- -14
                noise.mean <- 7
                noise.sd<- 42
                noise <- rnorm(samplesize, noise.mean, noise.sd)
                x <- 1:samplesize
                y=slope*x + intercept + noise
                plot(x, y, cex= 2 , pch=21, col="deepskyblue4", bg="deepskyblue3",
                     xlab="X = Explanatory variable.", ylab = " Y = Outcome value",
                     cex.lab=1.4,
                     xlim=c(-20, 80),ylim = c(-140, 210))
                
                currentxoutlier <-input$sliderXcoord
                currentyoutlier<- input$sliderYcoord
                newx<-append(x, currentxoutlier, after = length(x))
                newy<- append(y, currentyoutlier,  after = length(y))
                md1<-lm(y~x)
                abline(md1, col = "blue", lwd = 2)
                md2<- lm(newy ~ newx)
                points(newx[length(newx)], newy[length(newy)], pch=21,col="red", bg="red", cex=3)
                abline(md2, col = "red", lwd = 2)
                legend( "bottom" , legend=c("Lm model1 whithout outlier", "Lm model2 including outlier"),
                        col=c("blue", "red"), lty=1, cex=1,  box.lty = 0,
                        bg='lightblue')
                abline(h = 0, v=0, lwd=0.7)
                
                
        })
        
        output$res <- renderText({
                
                set.seed(42)
                flagO = TRUE
                samplesize<-input$sliderSizesamp
                slope <- 1
                intercept <- -14
                noise.mean <- 7
                noise.sd<- 42
                noise <- rnorm(samplesize, noise.mean, noise.sd)
                x <- 1:samplesize
                y=slope*x + intercept + noise
                plot(x, y, cex= 2 , pch=21, col="deepskyblue4", bg="deepskyblue3",
                     xlab="X = Explanatory variable.", ylab = " Y = Outcome value",
                     xlim=c(-20, 80),ylim = c(-140, 210))
                
               
                currentxoutlier <-input$sliderXcoord
                currentyoutlier<- input$sliderYcoord
                newx<-append(x, currentxoutlier, after = length(x))
                newy<- append(y, currentyoutlier,  after = length(y))
                md1<-lm(y~x)
                abline(md1, col = "blue", lwd = 2)
                md2<- lm(newy ~ newx)
                points(newx[length(newx)], newy[length(newy)], pch=21,col="red", bg="red", cex=3)
                abline(md2, col = "red", lwd = 2)
                legend( "bottom" , legend=c("lm model1 whithout outlier", "lm model2 including outlier"),
                        col=c("blue", "red"), lty=1, cex=1.4, title="Regression lines.", box.lty = 0,
                        bg='lightblue')

                

                hatBeta0 <- round(summary(md1)$coefficients[1,1], digits = 2)
                md1slope <- round(summary(md1)$coefficient[2,1], digits = 2)
                residualEsd<-round(summary(md1)[[6]],2)
                mnew<-summary(md2)
                hatbeta0md2<- round(summary(md2)$coefficients[1,1],digits = 2)
                md2slope <- round(summary(md2)$coefficients[2,1], digits =2)
                residualEsdnew<-round(mnew[[6]],digits =2)

                paste("Blue line = Model 1: does not consider outlier", "\n",
                      "Red line  = Model 2: considers outlier.", "\n",
                      "\n","-(1) " ,"Model1 slope = ",md1slope, "versus Model2 slope = ", md2slope,
                      "\n","-(2) ","RSE. when Model1 : ", residualEsd,"versus RSE. when Model2 = ",residualEsdnew)
        })
        

        output$help <- renderPrint({
                
                p(
                        h3("Using this app: "),
                        "Purpose of this application is to visualize the", 
                        "influence of an outlier on the ",br(),
                        strong("slope"), "of the regression line depending on whether",
                        "its coordinates are more or less distant from the", br(),
                        "regression line fitted to the points of the cloud.",
                        h3("1 Choose coordinates of an outlier:"),
                        h4("1.1 in left side panel use slider to fix x coordinate. "),
                        h4("1.2 then use y position slider to fix y coordinate."),
                        h3("2 Choose a new sample size"),
                        "But it is not necessary to change the sample size.",
                        h3("3 click on the submit button to validate your choices. "),
                        h3("4 take a look in summary tab: "),
                        "it is possible to see how the slope and the Residual Standard Error",br(), 
                        "have changed because of the influence of the outlier.",
                        h2("Thanks ! ")
                        )
                
                
                
                
        })
                     
})