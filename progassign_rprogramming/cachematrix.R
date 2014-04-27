## Programming Assignment 2 - R Programming
## Data Science Specialization Track
##
## These two functions are part of completing the second
## programming assignment for the R Programming course 
## offered on Coursera through the Johns Hopkins
## School for Public Health
##
## The two functions shown here help in caching the
## inverse of a matrix.  Matrix inversion is usually
## very computationally intensive - especially for large
## size matrices.  Sometimes in code (and especially in loops),
## the inverse of a matrix need only be computed once.  
## To avoid recomputing the inverse and generating the
## same result repeatedly, we can simply compute the
## result once.  If you try to recompute the inverse again,
## we have already computed this already and so we should
## just return this pre-computed result.
##

## makeCacheMatrix:
## To facilitate this caching, you first create a special
## matrix that will help us with this by using the
## makeCacheMatrix function.  The input into this function
## is simply a variable of type matrix.
##
## Usage example:
## x <- matrix(1:4, nrow=2, ncol=2)
## m <- makeCacheMatrix(x)

makeCacheMatrix <- function(x = matrix()) {
	# Following the same format as the assignment example
	# Creating a makeCacheMatrix object will consist of
	# four functions encapsulated in a list
	# 1. set the matrix
	# 2. get the matrix
	# 3. set the inverse of the matrix
	# 4. get the inverse of the matrix

	# Initially set to NULL
	# Changes when the user sets the value
    inv <- NULL

    # set function
    # Sets the matrix itself but not the inverse
    set <- function(y) {
            x <<- y
            inv <<- NULL
    }

    # get function
    # Gets the matrix itself but not the inverse
    get <- function() x

    # Manually set the inverse
    setinverse <- function(inverse) inv <<- inverse

    # Get the inverse
    getinverse <- function() inv

    # Encapsulate into a list
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)	
}

## cacheSolve:
## Once you create this matrix, you use the cacheSolve
## function to compute the inverse and cache the result
##
## If you try using cacheSolve again on the same special
## matrix, then the pre-computed result is obtained, thus
## avoiding any recomputation.  An informative message
## will be shown in the command prompt when the pre-computed
## result is returned instead.
##
## Usage example:
## x <- matrix(1:4, nrow=2, ncol=2)
## m <- makeCacheMatrix(x)
## s <- cacheSolve(m)
## print(s)
## s should return:
##     [,1] [,2]
##[1,]   -2  1.5
##[2,]    1 -0.5
##
## s2 <- cacheSolve(m)
## This should display a "Getting cached matrix" message
## print(s2)
## s2 should return
##     [,1] [,2]
##[1,]   -2  1.5
##[2,]    1 -0.5

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    # Following the same format as the assignment example

    # Get the current state of the inverse and see if it
    # has been computed yet
    inv <- x$getinverse()

    # If it has...
    if(!is.null(inv)) {
    	# Simply return the computed inverse		
        message("Getting cached matrix")
        return(inv)
    }

    # If it hasn't...
    # Get the matrix itself
    data <- x$get()

    # Find the inverse
    inv <- solve(data, ...)

    # Cache this result in the object
    x$setinverse(inv)

    # Return this new result
    inv    
}
