install.packages("Matrix")## if not already installed
install.packages("arules") ## if not already installed
install.packages("arulesViz") ## if not already installed; necessary for visualization purpose

library("Matrix")
library("arules")
library("arulesViz")


## http://cran.r-project.org/web/packages/arules/vignettes/arules.pdf
## https://sivaanalytics.wordpress.com/2013/07/12/market-basket-analysis-retail-foodmart-example-step-by-step-using-r/


##################### Example 1: creating transactions from a list ###########################
a_list <- list(
  c("A","B","C"),
  c("B","D"),
  c("B","E"),
  c("A","B","D"),
  c("A","E"),
  c("B","E"),
  c("B","D"),
  c("A","B","E","C"),
  c("A","B","E"),
  c("F")
)
a_list

## set transaction names
names(a_list) <- paste("Tr",c(1:10), sep = "")
a_list

## coerce into transactions
mytrans <- as(a_list, "transactions")

inspect(mytrans)

rules = apriori(mytrans, parameter=list(support=0.2, confidence=0.7,minlen=2)) 
rules

inspect(rules)
inspect(head(sort(rules, by="lift")))

rules_subset <- subset(rules, lift > 1.5)
inspect(rules_subset)


################### Example 2: creating transactions from a file in "basket" format #################
# Set working directory to the folder where the data files are
getwd()
dir()
?read.transactions
trs <- read.transactions("lenses_basket.csv", format = "basket", sep=",")
inspect(trs)

rules = apriori(trs, parameter=list(support=0.2, confidence=0.7,minlen=2)) 

inspect(head(sort(rules, by="lift")))

################### Example 3: creating transactions from a file in "single" format ###############
# Set working directory to the folder where the data files are
getwd()
dir()
trs <- read.transactions("lenses_single.csv", format = "single", sep=",", cols = c(1,2))
inspect(trs)

rules = apriori(trs, parameter=list(support=0.2, confidence=0.7,minlen=2)) 

inspect(head(sort(rules, by="lift")))


################### Example 4: creating transactions from a file in "binary matrix" format ###############
# Set working directory to the folder where the data files are
getwd()
dir()

mydata<-read.csv("lenses_matrix.csv",header=TRUE, sep=",")
mydata

rules = apriori(as.matrix(mydata[,2:7]), parameter=list(support=0.2, confidence=0.7,minlen=2)) ## the first column in mydata has transaction id

inspect(head(sort(rules, by="lift")))


#############  Visualization example #########################
## Source: http://www.jmlr.org/papers/volume12/hahsler11a/hahsler11a.pdf
data("Groceries")
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))
rules

### select and inspect three rules with highest lift
rules_high_lift <- head(sort(rules, by="lift"), 3)
inspect(rules_high_lift)
### plot selected rules as graph
plot(rules_high_lift, method="graph", control=list(type="items"))

### visualize rules as a scatter plot
plot(rules)
likelyGoodRules <- subset(rules, support > 0.0019, confidence > 0.89, lift > 1)
inspect(sort(likelyGoodRules, by="lift"))
plot(likelyGoodRules, method="graph", control=list(type="items"))



