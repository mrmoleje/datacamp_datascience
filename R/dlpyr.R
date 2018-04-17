#Datacamp
#dplyr
#Sue Wallace
#16.03.2018

library(dplyr)

data(mtcars)

#how many variables in the data?

dim(mtcars)

#tbl----
# A data frame that displays the data in a way taht is earier to view

tbl_df(mtcars)

#Changing labels----

#create a vector to incorporate into a new column in the dataframe

gears <- c("3" = "Three", "4" = "Four", "5" = "Five")

# Add the Carrier column to hflights
mtcars$gear1 <- gears[mtcars$gear]


#The five verbs and their meaning----

#The dplyr package contains five key data manipulation functions, also called verbs:
#  select(), which returns a subset of the columns,
#filter(), that is able to return a subset of the rows, 
#arrange(), that reorders the rows according to single or multiple variables,
#mutate(), used to add columns from existing data,
#summarise(), which reduces each group to a single row by calculating aggregate measures.

#SELECT----

select(mtcars, mpg, gear)

#to select multiple (this takes out the 'cyl or second variable)

select(mtcars, 1:8, -2)

#To look at the variables in a neat format

names(mtcars)

#Helper functions when selecting are useful to select particular particular data within a variable

#starts_with("X"): every name that starts with "X",
#ends_with("X"): every name that ends with "X",
#contains("X"): every name that contains "X",
#matches("X"): every name that matches "X", where "X" can be a regular expression,
#num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
#one_of(x): every name that appears in x, which should be a character vector.


select(mtcars, starts_with("m"), contains("di"), ends_with("t"))

#MUTATE----
#Adding new variables to a data set

#using calulations to create a new variable

a <- mutate(mtcars, mpgvs=sum(mpg, am))

#you can create multiple variables at once

##FILTER----

#taking out certain rows
#?comparison willbring out the logical opperators you can use when using filter

#x < y, TRUE if x is less than y
#x <= y, TRUE if x is less than or equal to y
#x == y, TRUE if x equals y
#x != y, TRUE if x does not equal y
#x >= y, TRUE if x is greater than or equal to y
#x > y, TRUE if x is greater than y
#x %in% c(a, b, c), TRUE if x is in the vector c(a, b, c)

tbl_df(mtcars)

#basic funtion

filter (mtcars, cyl>5)

#more than one element to filter

filter (mtcars, mpg %in% c(21.0, 18.7, 17.3))

#a calculation to filter on 

filter (mtcars, disp > gear+carb)

#boolean opperators & (and), | (or), and ! (not)

#Taking out 'NA'

filter(mtcars, !is.na(mpg))


filter (mtcars, mpg>1|carb>2)


filter (mtcars, mpg>1&carb>2)

filter(mtcars, qsec==18.90)

####filter, mutate, select

c1<-filter(mtcars, gear==4)


c2<- mutate(c1, Cyl_am=cyl-am)

select (c2, mpg, vs, carb, cyl, Cyl_am)


##ARRANGE----

#this will arrange gears from the lowest to highest number. If this was a character variable then it would
#arrange alphabetically. Default is smallest to largest

arrange(mtcars, gear)

#As many of the gears are tied (i.e. a lot are 3) you can then arrange by a second variable

arrange(mtcars, gear, mpg)

#reverse arrange

arrange (mtcars, desc(gear))

arrange (mtcars, cyl+carb)

##SUMMARISE----

#NOTE THAT SUMMARISE RETURNS A SINGLE NUMBER, NOT A NEW COLUMN WITH A NEW VARIABLE

#summarise(), the last of the 5 verbs, follows the same syntax as mutate(), 
#but the resulting dataset consists of a single row instead of an entire new 
#column in the case of mutate().

#In contrast to the four other data manipulation functions, summarise() does not 
#return an altered copy of the dataset it is summarizing; instead, it builds a new 
#dataset that contains only the summarising statistics.


summarise (mtcars, sum(gear))

summarise (mtcars, mean(gear))

summarise (mtcars, median(gear))

summarise(filter(mtcars, mpg >15.0), max_gear = max(gear))

#R contains many aggregating functions

#min(x) - minimum value of vector x.
#max(x) - maximum value of vector x.
#mean(x) - mean value of vector x.
#median(x) - median value of vector x.
#quantile(x, p) - pth quantile of vector x.
#sd(x) - standard deviation of vector x.
#var(x) - variance of vector x.
#IQR(x) - Inter Quartile Range (IQR) of vector x

summarise(mtcars, 
          leastgear = min(gear), 
          averagegear = mean(gear), 
          mostgear = max(gear), 
          sdgear = sd(gear))

#dplyr aggregate functions

#first(x) - The first element of vector x.
#last(x) - The last element of vector x.
#nth(x, n) - The nth element of vector x.
#n() - The number of rows in the data.frame or group of observations that summarise() describes.
#n_distinct(x) - The number of unique values in vector x.

#Next to these dplyr-specific functions, you can also turn a logical test into an aggregating function 
#with sum() or mean(). A logical test returns a vector of TRUE's and FALSE's. When you apply sum() or 
#mean() to such a vector, R coerces each TRUE to a 1 and each FALSE to a 0. sum() then represents the 
#total number of observations that passed the test; mean() represents the proportion.

# Generate summarizing statistics for mtcars

#The number of observation and the number of gears

summarise(mtcars, 
          n_obs = n(), 
          n_gear = n_distinct(gear))


# Generate summarizing statistics for mtcars 
summarise(mtcars, 
          n_mpg = n(), 
          n_mpg = sum(mpg == 15),
          avg_mpg = mean(mpg, na.rm = TRUE))

#THE PIPE OPPERATOR
#linking the 5 verbs together, see the %>% as 'then'

mtcars %>%
  mutate(diff = gear - mpg) %>%
  filter(!is.na(diff)) %>%
  summarise(avg = mean(diff))

#using the pipe function for many verbs

mtcars %>%
  mutate(RealDrat = drat + 100, mph = qsec / am * 60) %>%
  filter(!is.na(mpg), mpg < 70) %>%
  summarise(n_less = n(), 
            n_dest = n_distinct(carb), 
            min_am = min(am), 
            max_am = max(am))

mtcars %>%
  mutate(mpg100 = mpg + 100, mpgminus100 = mpg-100) %>%
  filter (mpg<15|gear==1|am==1)%>%
  summarise (n_non=n(),
             n_mpg100 = n_distinct(mpg100),
             min_mpg100 = min(mpg100),
             max_mpg100 = max(mpg100))

#GROUP BY

mtcars %>%
  group_by(gear) %>%
  summarise(p_cyl = mean(cyl) * 100, 
            avg_wt = mean(wt, na.rm = TRUE)) %>%
  arrange(avg_wt, p_cyl)


#combining group_by with mutate

mtcars %>%
  filter(!is.na(mpg), mpg > 0) %>%
  group_by(gear) %>%
  summarise(avg = mean(gear)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

#using dplyer when connecting to a database----

#example

# Set up a connection to the mysql database

my_db <- src_mysql(dbname = "dplyr", 
                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "student",
                   password = "datacamp")

# Reference a table within that source: nycflights
nycflights <- tbl(my_db, "dplyr")

# glimpse at nycflights
glimpse(nycflights)

# Ordered, grouped summary of nycflights
nycflights %>%
  group_by(carrier) %>%
  summarise(n_flights = n(), avg_delay = mean(arr_delay)) %>%
  arrange(avg_delay)
