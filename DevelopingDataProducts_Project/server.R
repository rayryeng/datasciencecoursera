
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)

#source("http://bioconductor.org/biocLite.R")
#biocLite("EBImage")
#library(EBImage)
library(png)
library(jpeg)

source("histEq.R")
source("plotHists.R")

shinyServer(function(input, output) {         
    
    output$origImage <- renderImage({
        
#        if (is.null(input$files)) {
#            # User has not uploaded a file yet
#            # Display a 1 x 1 blank image
#            print("Blank")
#            list(src = "1x1.png",
#                 contentType = "image/png",
#                 width = 1,
#                 height = 1,
#                 alt = "Output Image")            
#        }        
        
        if (input$defaultImages == "Pout") {
                 list(src = "pout.png",
                      contentType = "image/png",
                      width = 240,
                      height = 291,
                      alt = "Output Image")                
         } 
        else if (input$defaultImages == "Dress") {
                 list(src = "Herdress.jpg",
                      contentType = "image/jpeg",
                      width = 240,
                      height = 291,
                      alt = "Output Image")                 
         }
        else if (input$defaultImages == "Hazy City") {
            list(src = "hazy.jpg",
                 contentType = "image/jpeg",
                 width = 315,
                 height = 209,
                 alt = "Output Image")                 
        }    
        else if (input$defaultImages == "Unknown Friend") {
            list(src = "friend.jpg",
                 contentType = "image/jpeg",
                 width = 419,
                 height = 276,
                 alt = "Output Image")                 
        }    
        else if (input$defaultImages == "Moon") {
            list(src = "moon.png",
                 contentType = "image/png",
                 width = 256,
                 height = 256,
                 alt = "Output Image")                 
        }  
        else if (input$defaultImages == "Woman") {
            list(src = "woman.png",
                 contentType = "image/png",
                 width = 256,
                 height = 256,
                 alt = "Output Image")                 
        }             
#         else {
#             print("Upload File")
#             # Get the single image information
#             df <- input$files
#             
#             # Get the MIME type
#             mime <- df$type
#             
#             # Figure out what type of image this is
#             if (mime == "image/jpeg") {
#                 type <- ".jpeg"
#             }
#             else if (mime == "image/tif" || mime == "image/tiff") {
#                 type <- ".tif"
#             }
#             else if (mime == "image/png") {
#                 type <- ".png"
#             }
#             else {
#                 stop("File uploaded must be one of: PNG, TIF or JPEG")
#             }
#             
#             # Obtain the location of where this image was uploaded to
#             path <- df$datapath
#             # Create a copy of the image that contains the correct extension
#             # A temp file to save the output.
#             # This file will be removed later by renderImage        
#             fullPath <- paste(path, type, sep="")
#             file.copy(path, fullPath)
#             
#             # Read the image
#             img <- readImage(fullPath)
#             
#             # Get the dimensions of the image
#             widthImg <- dim(im)[1]        
#             heightImg <- dim(im)[2]
#             
#             # Generate the image
#             writeImage(img, fullPath)
#             
#             # Return a list containing the filename
#             list(src = fullPath,
#                  contentType = mime,
#                  width = widthImg,
#                  height = heightImg,
#                  alt = "Output Image")
#         }
    }, deleteFile = FALSE)

    output$histOrig <- renderImage({
        if (input$defaultImages == "Pout") {
            fileName <- "pout.png"
            typeImage <- "PNG"
        } 
        else if (input$defaultImages == "Dress") {
            fileName <- "Herdress.jpg"
            typeImage <- "JPEG"
        }     
        else if (input$defaultImages == "Hazy City") {
            fileName <- "hazy.jpg"
            typeImage <- "JPEG"
        }   
        else if (input$defaultImages == "Unknown Friend") {
            fileName <- "friend.jpg"
            typeImage <- "JPEG"
        }         
        else if (input$defaultImages == "Moon") {
            fileName <- "moon.png"
            typeImage <- "PNG"
        }   
        else if (input$defaultImages == "Woman") {
            fileName <- "woman.png"
            typeImage <- "PNG"
        }         
        # Read the image
        #img <- readImage(fileName)     
        if (typeImage == "PNG") {
            img <- readPNG(fileName)
        }
        else {
            img <- readJPEG(fileName)
        }
                    
        png("histOrig.png", width=400, height=400)
        plotHists(img)
        dev.off()          
        
        list(src = "histOrig.png",
             contentType = "image/png",
             width = 400,
             height = 400,
             alt = "Output Image")        
    }, deleteFile=TRUE)

    output$histEqImage <- renderImage({
            
        if (input$defaultImages == "Pout") {
            fileName <- "pout.png"
            typeImage <- "PNG"
        } 
        else if (input$defaultImages == "Dress") {
            fileName <- "Herdress.jpg"
            typeImage <- "JPEG"
        }     
        else if (input$defaultImages == "Hazy City") {
            fileName <- "hazy.jpg"
            typeImage <- "JPEG"
        }   
        else if (input$defaultImages == "Unknown Friend") {
            fileName <- "friend.jpg"
            typeImage <- "JPEG"
        }         
        else if (input$defaultImages == "Moon") {
            fileName <- "moon.png"
            typeImage <- "PNG"
        }   
        else if (input$defaultImages == "Woman") {
            fileName <- "woman.png"
            typeImage <- "PNG"
        }     
    
         # Read the image
        #img <- readImage(fileName)
        if (typeImage == "PNG") {
            img <- readPNG(fileName)
        }
        else {
            img <- readJPEG(fileName)
        }                

        # Get the dimensions of the image
        widthImg <- dim(img)[1]        
        heightImg <- dim(img)[2]
                 
        # Generate the image
        outImg <- histEq(img, input$numberOfBins)
        
        # Write this image to file
        writePNG(outImg, "histEqImage.png")           
        #writeImage(outImg, "histEqImage.png")
                
        # Return a list containing the filename
        list(src = "histEqImage.png",
             contentType = "image/png",
             width = widthImg,
             height = heightImg,
             alt = "Output Image")
}, deleteFile = TRUE)    

    output$histEq <- renderImage({
        if (input$defaultImages == "Pout") {
            fileName <- "pout.png"
            typeImage <- "PNG"
        } 
        else if (input$defaultImages == "Dress") {
            fileName <- "Herdress.jpg"
            typeImage <- "JPEG"
        }     
        else if (input$defaultImages == "Hazy City") {
            fileName <- "hazy.jpg"
            typeImage <- "JPEG"
        }   
        else if (input$defaultImages == "Unknown Friend") {
            fileName <- "friend.jpg"
            typeImage <- "JPEG"
        }         
        else if (input$defaultImages == "Moon") {
            fileName <- "moon.png"
            typeImage <- "PNG"
        }   
        else if (input$defaultImages == "Woman") {
            fileName <- "woman.png"
            typeImage <- "PNG"
        }                  
        # Read the image
        #img <- readImage(fileName)
        if (typeImage == "PNG") {
            img <- readPNG(fileName)
        }
        else {
            img <- readJPEG(fileName)
        }                                   
        
        # Generate the image
        outImg <- histEq(img, input$numberOfBins)        
        png("histFinal.png", width=400, height=400)
        plotHists(outImg)
        dev.off()          
        
        list(src = "histFinal.png",
             contentType = "image/png",
             width = 400,
             height = 400,
             alt = "Output Image")                
    }, deleteFile=TRUE)
})