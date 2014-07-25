
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Histogram Equalization Demo"),
    absolutePanel(
        style = "opacity: 0.92",
        right = 1,
        width = 300,
        fixed = TRUE,
#        fileInput("files", "Upload Image", multiple=FALSE, 
#                  accept = c("image/jpeg", "image/tif", "image/tiff", "image/png")),
        selectInput("defaultImages", "Choose an image", 
                     c("Pout", "Dress", "Hazy City", "Unknown Friend", "Moon", "Woman"), selected = NULL),
        sliderInput("numberOfBins", "Choose number of levels", 2, 256, 32, step = 1)        
        
    ),
    mainPanel(
        # Use imageOutput to place the image on the page
        h2('Description'),
        p('This shiny app illustrates visual and numerical examples of enhancing images using histogram 
equalization.  Given an image with poor contrast (either too dark, too light, or too hazy / foggy), histogram equalization
          attempts to make the image have higher contrast.  The histogram is stretched so that the probability of encountering
          each intensity / colour value in the image is equiprobable'),
        h2('How To Use'), 
        p('There is a control menu on the right that 
          allows you to choose one of several images that has poor contrast in a dropdown menu.  The dropdown menu
is designed to scroll with you as you move around on the page so that you are able to visualize and compare results
between the original and the enhanced image.  There is 
          also a slider tool that allows you to vary how many intensity levels the desired output should have.
          The original image and its histogram are displayed, as well as the enhanced image with its histogram.'),
        h2('Explanation of Output'),
        p('For grayscale images, moving the slider corresponds to how many shades of gray you would like to see.  For
          colour images, moving the slider corresponds to how many colours PER COLOUR CHANNEL (red, green and blue)
          you would like to see.  Moving the slider towards the left will produce a higher contrast but more 
          binary like image.  Moving the slider towards the right will produce a higher contrast image and the
          objects are more discernable in the image.'),        
        h2('Original Image'),
        imageOutput("origImage"),
        h2('Histogram of Original Image'),
        imageOutput("histOrig"),
        h2('Histogram Equalized Image'),
        imageOutput("histEqImage"),
        h2('Histogram of Equalized Image'),
        imageOutput("histEq")
        #verbatimTextOutput("outputDefault")
        
    )    
))