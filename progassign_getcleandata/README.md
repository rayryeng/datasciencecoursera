# README.md
---
This README contains instructions on how to run the programming assignment required for the *Getting and Cleaning Data* course offered by the Johns Hopkins School for Public Health.  The programming assignment was performed using the `R` programming language.

---

## Introduction

If the user requires an introduction on what kind of data the assignment is using, the user is encouraged to consult the `CodeBook.md` Markdown file that is included in this repo.  This Markdown file also includes the variables that were used in tidying up the data and the high-level summary of what was performed to create the tidy dataset.

It is highly recommended that the user clone the folder containing this directory to their computer prior to running, as the datasets used are structured uniquely in the `data` folder to allow automation when cleaning the datasets.  The user may also notice that the final tidied dataset is also included in the repo.  This is available should the user wish to observe the tidied dataset before running the `R` script.

## How to run the script

Once the user has cloned the folder to their computer, the working directory should be set to this directory.  Once the working directory is set, the user simply has to run the `run_analysis.R` script file.  In `RStudio` or in the `R` environment that is included in the `R` distribution, you simply have to source the file:

    source("run_analysis.R")

**NOTE:** This will take several seconds to complete - explanation to follow.

Once this is performed, the final output should be a data frame that contains the tidied up dataset and is stored as the variable `finalFrame`.  The script also writes this final frame to disk as a text and CSV file.

The reason why this is performed is due to the computationally intensive step of loading in the feature vectors for the test and training data.  The total number of feature vectors shared between these two sets of data is over 10000, so saving these to disk allows observation of the data without rerunning the script (i.e. you only need to run it once).