#Sue Wallace
#30/12/2017
#Intermediate Practice

##dim(x) - to see how many variables and rows there are

####LAPPY----

#useful for applying a function to lots of variables within the data

lapply(x, my_fun)

#where x is the data and my_fun is the function (i.e. sum)

d <- mtcars

sum(d$carb)

lapply(d, class)

lapply(d, sum)

#you can create your own function and then apply it to all variables


get_mpg <- function(x) {
  d$mpg
}

# Apply get_timestamp() over all elements in logs
lapply(d, get_mpg)


#The below adds each number in the list by 2

a <- list(3, 2, 5, 8, 9, 10, 76)

lapply(a, function(x) { 2 + x })


x <- list(a = 1, b = 2, c = 3)
x[["a"]]
`[[`(x, "a")


####SAPPLY----

#performs an lapply(), and sees whether the result can be simplified to a vector.

sapply(d, length)

sapply(d, sum)

str(d[[5]])



# Implement function get_failure_carb

#the below function will return carb, unless carn is null, then it will return mpg

get_failure_carb <- function(x) {
  if (d$carb) {
    return(NULL)
  } else {
    return(d$mpg)
  }
}

# Use sapply() to call get_failure_loc on logs

sapply(d,get_failure_carb)

####VAPPLY----

#You have to explicitly mention what the outcome of the function you're applying will be with vapply(). the below should 
#return TRUE or FALSE

vapply(d, `[[`, "mpg", FUN.VALUE = logical(1))

####EXPLORATORY QUERIES----

# Print out total value of fares

sum(titanic$Fare)

# Print out proportion of passengers that survived

round (mean(titanic$Survived)*100,1)

####GREPL

#grepl returns TRUE if a string contains the pattern, otherwise FALSE; 
#if the parameter is a string vector, returns a logical vector 
#(match or not for each element of the vector). 

#grepl(pattern, x, ignore.case = FALSE, perl = FALSE,
      #fixed = FALSE, useBytes = FALSE)

#.pattern: regular expression, or string for fixed=TRUE
#.x: string, the character vector
#.ignore.case: case sensitive or not
#.perl: logical. Should perl-compatible regexps be used? Has priority over extended
#.fixed: logical. If TRUE, pattern is a string to be matched as is. Overrides all conflicting arguments
#.useBytes: logical. If TRUE the matching is done byte-by-byte rather than character-by-character

# Extract the name column from titanic
pass_names <- titanic$Name

# Create the logical vectror is_man
is_man <- grepl(", Mr\\.", pass_names)

# Count the number of men
sum(is_man)

# Count number of men based on gender
sum(titanic$Sex == "male")


# Extract the name column from titanic
pass_names <- titanic$Name

# Create titles
titles <- gsub("^.*, (.*?)\\..*$", "\\1", pass_names)

# Call unique() on titles
unique(titles)

#The below craetes a variable with all possible titles. vapply and grepl are then used to work out how many passengers 
#have one of the titles.

pass_names <- titanic$Name
titles <- paste(",", c("Mr\\.", "Master", "Don", "Rev", "Dr\\.", "Major", "Sir", "Col", "Capt", "Jonkheer"))

# Finish the vapply() command
hits <- vapply(titles,
               FUN = grepl,
               FUN.VALUE = logical(length(pass_names)),
               pass_names)

# Calculate the sum() of hits

sum(hits)

##The below cleans the name coloumn 

# pass_names is available in your workspace

# Finish the convert_name() function
convert_name <- function(name) {
  # women: take name from inside parentheses
  if (grepl("\\(.*?\\)", name)) {
    gsub("^.*?\\((.*?)\\)$", "\\1", name)
    # men: take name before comma and after title
  } else {
    gsub("^(.*?),\\s[a-zA-Z\\.]*?\\s(.*?)$", "\\2 \\1", name)
  }
}

# Call convert_name on name
clean_pass_names <- vapply(pass_names, FUN = convert_name,
                           FUN.VALUE = character(1), USE.NAMES = FALSE)

# Print out clean_pass_names

# Count number of men based on gender
sum(titanic$Sex == "male")


#converting to dates

# titanic, dob1 and dob2 are preloaded

# Have a look at head() of dob1 and dob2
head(dob1)
head(dob2)

# Convert dob1 to dob1d, convert dob2 to dob2d
dob1d <- as.Date(dob1)
dob2d <- as.Date(dob2, format = "%B %d, %Y")

# Combine dob1d and dob2d into single vector: birth_dates
birth_dates <- c(dob1d, dob2d)

#adding a column----

# titanic, dob1 and dob2 are preloaded
dob1d <- as.Date(dob1)
dob2d <- as.Date(dob2, format = "%B %d, %Y")
birth_dates <- c(dob1d, dob2d)
disaster_date <- as.Date("1912-04-15")

# Add birth_dates to titanic (column Birth)
titanic$Birth <- birth_dates

# Create subset: survivors
survivors <- subset(titanic, Survived == 1)

# Calculate average age of survivors
mean(disaster_date - survivors$Birth, na.rm = TRUE)

d <- mtcars

mtcars$day <- sum(mtcars$mpg, mtcars$cyl)

