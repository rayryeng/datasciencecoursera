# Function that takes in an input image
# loaded in with either readPNG or readJPEG
# and displays the bin counts per intensity or colour channel

plotHists <- function(inputImg) {
    # Determine the total number of channels
    dims <- dim(inputImg)
    
    if (length(dims) == 3) {
        numChannels <- dims[3]
        if (numChannels != 1 && numChannels != 3) {
            stop("Number of channels should be 1 or 3")
        }
    }
    else {
        numChannels <- 1
    }
    
    # Grayscale
    if (numChannels == 1) {
        # Convert channel into a single vector
        par(mfrow=c(1,1))
        vec <- round(256*as.vector(inputImg))
        
        # Compute its histogram
        hist(vec, breaks=0:257, plot=TRUE, xlab="Intensity", ylab="Frequency", 
             main="Histogram of grayscale image", col="blue")        
    }  
    
    # RGB
    else {
        # For each channel...
        par(mfrow=c(3,1))
        histStrings = c("Histogram of red channel", "Histogram of green channel", 
                        "Histogram of blue channel")
        xLabelStrings = c("Red Intensity", "Green Intensity", "Blue Intensity")
        for (i in 1:3) {
            # Convert each channel into a single vector
            vec <- round(256*as.vector(inputImg[,,i]))
            # Compute its histogram
            hist(vec, breaks=0:257, plot=TRUE, xlab=xLabelStrings[i],
                 ylab="Frequency", main=histStrings[i], col="blue")            
        }
    }
}