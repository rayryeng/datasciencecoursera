histEq <- function(inputImg, numLevels=256) {
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
  
  # Extract rows and columns
  rows <- dims[1]
  cols <- dims[2]
  
  # Grayscale
  if (numChannels == 1) {
    # Convert channel into a single vector
    vec <- as.vector(inputImg)
    
    # Rescale so that the max is at numLevels
    vec <- (numLevels-1)*vec/(max(vec))
    vec <- round(vec)
    
    # Compute its histogram
    h <- hist(vec, breaks=0:numLevels, plot=FALSE)
    
    # Compute its CDF
    cdf <- cumsum(h$counts) / (rows*cols)
    
    # Map the image to the CDF
    # Add 1 to account for 1 indexing
    outputVec <- cdf[vec+1]
    
    # Reshape as a matrix
    outputMatrix <- matrix(outputVec, rows, cols)
    #print(dim(outputMatrix))
    
    # Output as EBImage class
    #outputImg <- Image(outputMatrix, c(rows, cols), colormode="Grayscale")
    # Output as a matrix class
    outputTemp <- outputMatrix[, ncol(outputMatrix):1]  
    outputImg <- outputTemp[, ncol(outputTemp):1] 
    #outputImg <- t(outputMatrix)
  }  
  
  # RGB
  else {
    outputMatrix <- array(0, dim=c(rows,cols,3))
    
    # For each channel...
    for (i in 1:3) {
      # Convert each channel into a single vector
      vec <- as.vector(inputImg[,,i])
      
      # Rescale so that the max is at numLevels
      vec <- (numLevels-1)*vec/(max(vec))
      vec <- round(vec)
      
      # Compute its histogram
      h <- hist(vec, breaks=0:numLevels, plot=FALSE)
      
      # Compute its CDF
      cdf <- cumsum(h$counts) / (rows*cols)
      
      # Map the image to the CDF
      # Add 1 to account for 0 indexing
      outputVec <- cdf[vec+1]
      
      # Reshape as a matrix
      outTemp <- matrix(outputVec, rows, cols)
      #print(dim(outTemp))
      # Transpose
      outputMatrix[,,i] <- outTemp
    }
    
    # Construct an RGB image
    #outRed <- Image(outputMatrix[,,1], c(rows,cols), colormode="Grayscale")
    #outGreen <- Image(outputMatrix[,,2], c(rows,cols), colormode="Grayscale")
    #outBlue <- Image(outputMatrix[,,3], c(rows,cols), colormode="Grayscale")
    #outputImg <- rgbImage(outRed, outGreen, outBlue)    
    outputImg <- outputMatrix
  }  
  
  # Output image
  outputImg
}