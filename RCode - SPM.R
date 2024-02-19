## Mining Assotiations with CSPADE
## M. J. Zaki. (2001). SPADE: An Efficient Algorithm for Mining Frequent Sequences. Machine Learning Journal, 42, 31-60.

install.packages("Matrix") # if not already installed
install.packages("arules") # if not already installed
install.packages("arulesSequences") # if not already installed

getwd()
dir()

library("Matrix")
library("arules")
library("arulesSequences")

## reading our own data from text file
?read_baskets
x <- read_baskets(con  = "seq_data.txt", info = c("sequenceID","eventID","SIZE"))
as(x, "data.frame")
?cspade
s1 <- cspade(x, parameter = list(support = 0.5), control = list(verbose = TRUE))
summary(s1)
as(s1, "data.frame")

## using example data - zaki - that is already part of the package
data(zaki)
as(zaki, "data.frame")
## if the following API doesn't run from RStudio, run it directly from the RConsole.
s2 <- cspade(zaki, parameter = list(support = 0.5), control = list(verbose = TRUE))
summary(s2)
as(s2, "data.frame")

