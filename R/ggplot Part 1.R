##ggplot part one datacamp course
#Sue Wallace
#15.04.2018

#PART 1----

# Load the ggplot2 package
library (ggplot2)

# Explore the mtcars data frame with str()

str(mtcars)

# Execute the following command
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_point()


# Change the command below so that cyl is treated as factor
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_point()

#putting factor around 'cyl' means that the x axis only shows the factors that are in the data (like 4,6,8)

#essential elements of designing a ploy
#data - the data you want to show
#aesthetic - the scales on which you map the data
#geometries - the way you want to visualise the data

# A scatter plot has been made for you
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# This assigns a different colour to differing cells in the variable disp
ggplot(mtcars, aes(x = wt, y = mpg, color = disp)) +
  geom_point()

# This assigns a different colour to differing cells in the variable disp
ggplot(mtcars, aes(x = wt, y = mpg, size = disp)) +
  geom_point()

#The above only work as the variables are on a continous scale

# Explore the diamonds data frame with str()
str(diamonds)

# Add geom_point() with +
ggplot(diamonds, aes(x = carat, y = price))+
  geom_point ()


# Add geom_point() and geom_smooth() with + - geom_smooth adds a smooth line to the plot
ggplot(diamonds, aes(x = carat, y = price))+ 
  geom_point ()+
  geom_smooth()

# 1 - The plot you created in the previous exercise
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

# 2 - Copy the above command but show only the smooth line

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_smooth()

# 3 - Copy the above command and assign the correct value to col in aes()

ggplot(diamonds, aes(x = carat, y = price, colour=clarity)) +
  geom_smooth()




# 4 - Keep the color settings from previous command. Plot only the points with argument alpha.

ggplot(diamonds, aes(x = carat, y = price, colour=clarity)) +
  geom_point(alpha= 0.4)

#alpha changes the dots to be more transparent

#example of seperating out the commands

# Create the object containing the data and aes layers: dia_plot
dia_plot <- ggplot(diamonds, aes(x = carat, y = price))

# Add a geom layer with + and geom_point()
dia_plot + geom_point()

# Add the same geom layer, but with aes() inside
dia_plot + geom_point(aes(color = clarity))

# 1 - The dia_plot object has been created for you
dia_plot <- ggplot(diamonds, aes(x = carat, y = price))

# 2 - Expand dia_plot by adding geom_point() with alpha set to 0.2
dia_plot <- dia_plot + geom_point(alpha = 0.2)

# 3 - Plot dia_plot with additional geom_smooth() with se set to FALSE
dia_plot + geom_smooth(se = FALSE)

#se removes any error in shading

# 4 - Copy the command from above and add aes() with the correct mapping to geom_smooth()
dia_plot + geom_smooth(aes(col = clarity), se = FALSE)

#colour can make a third variable on the plot

ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Measure)

#iris tidy isn;t here but this shows a jitter where two plots appear side by side as defined by
#the meaasure variable. So if you had a year variable you could get a plot for each year

#tidying data using tidyr

library(tidyr)

iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")

# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

# Fill in the ___ to produce to the correct iris.wide dataset
iris.wide <- iris %>%
  gather(key, value, -Species, -Flower) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

#This creates fewer variables and more rows
#length and width ahve been put into the same row

#aesthetics

#These are the aesthetics you can consider within aes() in this chapter: 
#x, y, color, fill, size, alpha, labels and shape.

# 1 - Map mpg to x and cyl to y
ggplot(mtcars, aes(x=mpg, y=cyl)) +
  geom_point()

# 2 - Reverse: Map cyl to x and mpg to y
ggplot(mtcars, aes(x=cyl, y=mpg)) +
  geom_point()

# 3 - Map wt to x, mpg to y and cyl to col
ggplot(mtcars, aes(x=wt, y=mpg, col=cyl)) +
  geom_point()

# 4 - Change shape and size of the points in the above plot
ggplot(mtcars, aes(x=wt, y=mpg, col=cyl)) +
  geom_point(shape=1, size=4)

#The color aesthetic typically changes the outside outline of an object 
#and the fill aesthetic is typically the inside shading

#Which shape to use? The default geom_point() uses shape = 19 
#(a solid circle with an outline the same colour as the inside). 
#Good alternatives are shape = 1 (hollow) and shape = 16 (solid, no outline). 
#These all use the col aesthetic (don't forget to set alpha for solid points).

#A really nice alternative is shape = 21 which allows you to use both fill for the 
#inside and col for the outline! This is a great little trick for when you want to 
#map two aesthetics to a dot.

# am and cyl are factors, wt is numeric
class(mtcars$am)
class(mtcars$cyl)
class(mtcars$wt)

# From the previous exercise
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

# 1 - Map cyl to fill
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 1, size = 4)


# 2 - Change shape and alpha of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 21, alpha =0.6, size = 4)


# 3 - Map am to col in the above plot. This is an example of a plot with four variables

ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl, col=am)) +
  geom_point(shape = 21, alpha =0.6, size = 4)

#fill is useful for a bar whereas col is more useful for a point chart

# Map cyl to size
ggplot(mtcars, aes(x = wt, y = mpg, size = cyl)) +
  geom_point()

# Map cyl to alpha
ggplot(mtcars, aes(x = wt, y = mpg, alpha = cyl)) +
  geom_point()

# Map cyl to shape 
ggplot(mtcars, aes(x = wt, y = mpg, shape = cyl)) +
  geom_point()

# Map cyl to labels
ggplot(mtcars, aes(x = wt, y = mpg, label = cyl)) +
  geom_text()

# Define a hexadecimal color
my_color <- "#4ABEFF"

# Set the color aesthetic 
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point()

# Set the color aesthetic and attribute  - changing color in geom_point meants that color 
#in cyl is overriden. This is because attributes put into the geom line will override aes in ggplot

ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(color = my_color)

#This can be overcome by changing colour to fill in ggplot

# Set the fill aesthetic and color, size and shape attributes
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(size = 10, shape = 23, color = my_color)


# Expand to draw points with alpha 0.5
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(alpha = 0.5)

# Expand to draw points with shape 24 and color yellow
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, color = 'yellow')

# Expand to draw text with label rownames(mtcars) and color red
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_text(label = rownames(mtcars), color = 'red')

#useing multiple aesthetic mappings in ggplot----

#In this chapter you saw aesthetics and attributes. Variables in a data frame are 
#mapped to aesthetics in aes(). (e.g. aes(col = cyl)) within ggplot(). Visual elements 
#are set by attributes in specific geom layers (geom_point(col = "red")). 
#Don't confuse these two things - here you're focusing on aesthetic mappings.

# Map mpg onto x, qsec onto y and factor(cyl) onto col (3 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl))) +
  geom_point()

# Add mapping: factor(am) onto shape (now 4 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am))) +
  geom_point()

# Add mapping: (hp/wt) onto size (now 5 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am), size = (hp/wt))) +
  geom_point()
  
#positioning----


