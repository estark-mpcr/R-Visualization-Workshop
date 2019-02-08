## R Visualization Workshop 
#  Emily Stark
#  Florida Atlantic University, Psychology Department
#  Feb 8th, 2019; BS 103
#  5:00pm - 7:00pm

## Introducing RStudio --------------------------------------------------------
# RStudio is allows for well-organized and clean writing, editing, and 
# running R code.

# This secion is for editing. You are able to write and edit code here without
# running it. There are a couple of different methods for writing, but the one
# most used and that we will use is called a script. A script is just a text
# file that doesn't have any special powers. All the computing happens in the 
# window below this, called the console. 

# The console is the portion that interprets the text you give it and performs
# some function in R. If the text you enter does not have meaning in R or 
# is missing something to make it interpretable, it will not be able to run 
# that line of code and will give you an error. If R is expecting you to add
# to your line of code, it will continue to wait for you to finish your
# command by giving you "+" signs. If you keep getting these, don't worry
# you have NOT broken R, you just have to figure out what you're missing. 
# You cannot edit or save things in the console. This is why all of your code 
# 'should' be written an saved in a script. 

# In the upper right corner you have your "environment" window. This is where 
# any variables, functions, datasets, etc go so you can see exactly what you 
# have told R to remember.

# The bottom right corner has a window is used for a lot of things. We will 
# use it mostly for the "Plots" option that allows us to see the plot we create.
# Another nifty tab is "Files" which allows you to search for where a dataset
# is saved and has some point-click functionality for more Operating System
# types of commands (changing file directory, loading R projects/files, etc)


## Installing Packages --------------------------------------------------------
# You only have to install packages once. They get saved to your Hard Drive 
# and after that you only have to load them in 

# Install Packages
install.packages('reshape2', 'ggplot2',  'gridExtra')

# Load in Packages
library(reshape2) # used to change data between long and wide form
library(ggplot2) # used for creating plots
library(gridExtra) # used for showing multiple plots, useful for saving

## Types of 'Tidy Data' -------------------------------------------------------
# 'Happy families are all alike; every unhappy family is unhappy in its own way'
#  ~ Leo Tolstoy

# Traditional tidy data contains a variable in every column and an observation
# in every row (Wickham, 2014). This is a standard that is widely adopted by 
# data scientists which allows for maximal data usability since it cuts down
# on data cleaning and tidying for other users.

# To see an example of Tidy Data, let's look at a dataset preloaded in R
View(iris)

# To get a list of all the variables in iris, you can use the names function
names(iris)

# To see how many observations there are, you can use the nrow function
nrow(iris)


# This form of tidy data is called wide form. Another kind of tidy data 
# is called long form. In long form, there are id columns which identify the
# observation of interest, the variable column which specifies which variable
# is stored in that row, and the value column which gives the value for the
# variable in that row and for the given observation.

# To see iris in long form, we first have to give the observations an identity.
# To create a new column in a dataset, you can simply call the column using a
# '$' and then giving the name for the new variable. You'll assign this column 
# the numbers 1 through the number of rows in iris.

# To assign something in R, you can use the '=', but people really don't use it
# all that often (you're welcome SQL users). Instead, people use the left arrow
# comprised of the less-than-sign and a dash '<-'. 

# One more quick note: white spaces are irrelevant in R. You can tab or enter
# as much as you'd like and R won't care. However, for "Tidy Code" 
# (a la Hadley Wickham), it is suggested to put spaces between almost any 
# variable/value and operator.

iris$obsid <- 1:nrow(iris) # Create a new column called 'obsid' and assign it
# the sequence of 1 through nrow(iris)

# Now we have 'iris' in our Global Envivornment because we are not using the
# preloaded dataset anymore since we have augmented it. We can see what we have 
# in our iris dataset by either clicking it, or by typing the following:
View(iris)
names(iris)

# Before we put our data into long form, I wanted to add another categorical
# variable so plotting can be more fun in the future. We are going to assign 
# each observation either to class "A", "B", "C", "D", or "E", since there are
# 50 observations per class. To do this, we will use the repeat function.

iris$class <- rep(c("A", "B", "C", "D", "E"), 30)

# Since we have an id column, we can melt our data from wide form to 
# long form. We do this using the melt command from reshape2. We want to 
# preserve our wide iris dataset, so we will give this dataset a new name

iris.long <- melt(data = iris, id.vars = 'obsid') # naming is the 2nd
# hardest part of coding.

# We get a weird warning message saying things will be dropped. This makes me
# nervous so first I will check to see if I have the right number of rows.
# If I have 150 observations and 5 variables, and each row in long form is a 
# unique combination of observations and variables, I should have 150*5 rows 
# in iris.long. I do, so nothing appears to be dropped. For safety, I'm going 
# to check if there are any NA's (R's default filler for empty spaces). To do 
# this, I'm going to generate a table that shows how many NA's I have in the 
# value column.

table(is.na(iris.long$value))

# I see there are 750 FALSE. If there were any true, I'd also have a header 
# for TRUE and a number. But I don't so we are good to go.

# Both forms of Tidy Data are useful for data manipulation and visualization.
# We will not be getting too deep into data manipulation, but for more 
# information, you should look into the 'dplyr' package (also Hadley Wickham's)


## Basics of Plotting with ggplot ---------------------------------------------
# Base R (without any packages installed/loaded) does have it's own plotting 
# functions, but that's not why we use R for visualization. An example:

boxplot(iris$Sepal.Length)

# Yuck. 

# Instead, we use ggplot. Ggplot was also written by Hadley Wickham and creates
# a shared grammar for plotting across many different types. To begin with 
# ggplot, you first have to tell R what data you're looking at. If that's all we
# run, we get a blank plot. This is because ggplot doesn't know what to plot.
ggplot(data = iris)

# If that's all we run, we get a blank plot. This is because ggplot doesn't 
# know what to plot. So we have to first tell it what variables are going 
# where, then how to represent them. aes means "aesthetics" and tells ggplot
# what goes where. This is generally put in the ggplot() function. After that,
# we add the layer that tells ggplot what to plot by literally adding it.

ggplot(data = iris, aes(x = 1, y = Sepal.Length)) + # First layer of "where"
  geom_boxplot() # Second layer of "what"

# We can compare this to the basic boxplot
boxplot(iris$Sepal.Length)

# We will add more and more layers and customization to the plots in the 
# remaining of the workshop. But everything in ggplot uses the syntax of adding
# 'functions' using the '+'.


## Bar and Line Graphs --------------------------------------------------------

# Our first goal is to plot a bar graph of the average Sepal.Lengths for each 
# species. There are ways to compute the averages, but that is beyond the scope
# of this workshop.

names(iris) # so I can see exactly what the columns are called. Spelling is the
# 1st hardest part of coding.

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary')

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "mean")

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "max")

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "min")

# These look good, but I don't know which function is being done for the y-axis
# so I should add my own axes.

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "mean") + ylab('Average Sepal Length')

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "max") + ylab('Max Sepal Length')

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = 'summary', fun.y = "min") + ylab('Min Sepal Length')

# Maybe I want to look at each species by the class I made up (A,B,...) on
# my bar chart. This is easily done by adding an aes argument. For bar charts
# we use "Fill" because we are going to fill the bars with different colors.

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = class)) +
  geom_bar(stat = 'summary', fun.y = 'mean') + ylab('Average Sepal Length')

# This is cool...except I hate it. I don't want to have my bars filled with 
# different colors, but instead I want to plot the bars so they stand next to 
# each other. I do this by using the position argument in the geom_bar function.
# Ggplot knows that "dodge" means side by side. I have no idea why.

ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = class)) +
  geom_bar(position = 'dodge', stat = 'summary', fun.y = 'mean') + 
  ylab('Average Sepal Length')

# Now, maybe I want to put my categorical variable with more settings on the 
# x-axis for a less cluttered looking graph. I can do this by swapping my x and
# fill variables in aes.

ggplot(data = iris, aes(x = class, y = Sepal.Length, fill = Species)) +
  geom_bar(position = 'dodge', stat = 'summary', fun.y = 'mean') + 
  ylab('Average Sepal Length')


# If, instead, we wanted to do a line graph, it is a very similar process. 
# We don't have any variables relating to time in iris, so we will use obsid.

ggplot(data = iris, aes(x = obsid, y = Sepal.Length)) + geom_line()

# For another example that is better suited for a line graph, we will 
# create a dataframe real quick. The easiest way to do this is to create
# vectors and bind those together in a matrix, then conver to a dataframe.

meals <- c('Lunch', 'Lunch', 'Dinner', 'Dinner')
person <- c('Marley', 'Mia', 'Marley', 'Mia')
bill <- c(18.62, 21.84, 30.51, 25.07)

datamat <- cbind(meals, person, bill)
meals <- as.data.frame(datamat)
View(meals)

# The line graph does not have a "fill" aesthetic. Instead, it takes "group".

ggplot(data = meals, aes(x = meals, y = bill, group = person)) +
  geom_line()

# Yikes...we broke math. 25.07 is not directly between 21.84 and 30.51. This
# is because when we converted to a dataframe, R interpreted the bill variable
# as a factor.

class(meals$bill)

# "factor" is a special kind of class in R. It displays strings or letters and
# numbers, but interpret's them internally as integers. So if we try to just
# change it to numbers, we're going to be disappointed:

meals$bill
as.numeric(meals$bill)

# Instead, we have to tell R first interperet them as characters, then numbers.

as.numeric(as.character(meals$bill))
meals$bill <- as.numeric(as.character(meals$bill))

# Now let's try to plot again.

ggplot(data = meals, aes(x = meals, y = bill, group = person)) +
  geom_line()

# This isn't very clear because we don't know which line corresponds to 
# which person. So we will add another aes for color.

ggplot(data = meals, aes(x = meals, y = bill, 
                         group = person, color = person)) + geom_line()

# If we want to change things about the line, we can do that by giving the
# geom_line functions more arguments.

ggplot(data = meals, aes(x = meals, y = bill, 
                         group = person, color = person)) + 
  geom_line(size = 2) # try different values

# If we want to add the actual data points here, that is super simple

ggplot(data = meals, aes(x = meals, y = bill, 
                         group = person, color = person)) + 
  geom_line(size = 2) + geom_point(size = 4)

# Maybe we want to change the shape of the points. This needs to be done in aes
# because it relates to variables.

ggplot(data = meals, aes(x = meals, y = bill, 
                         group = person, shape = person)) + 
  geom_line() + geom_point(size = 4)

# Now we want to update our axes labels and add a title

ggplot(data = meals, aes(x = meals, y = bill, 
                         group = person, color = person)) + 
  geom_line() + geom_point(size = 4) + ylab('Bill') + xlab('Meals') + 
  ggtitle('Spending Habits of My Dogs')

# I just noticed that Lunch comes before Dinner so our x axis should show that.
# Reordering the x-axis is pretty simple. We do this with scale commands. Since
# my plotting code is getting longer and I am tweaking, I can save my plot
# commands as a variable and keep adding things to that variable.

p1 <- ggplot(data = meals, aes(x = meals, y = bill, 
                               group = person, color = person)) + 
        geom_line() + geom_point(size = 4) + ylab('Bill') + xlab('Meals') + 
        ggtitle('Spending Habits of My Dogs')

p1 + scale_x_discrete(limits = c('Lunch', 'Dinner')) # x bc it's the x axis,
# discrete bc it's a discrete variable. This changes the order.

# I like this, so I'll save it over p1.

p1 <- p1 + scale_x_discrete(limits = c('Lunch', 'Dinner'))

p1

# Now I want to do something about the legend title. This is also done with 
# a scale command, but instead of scale_x_discrete, it will be 
# scale_color_discrete since that is the aes that are in the legend.

p1 + scale_color_discrete(name = 'Dog')

# If I wanted to give Mia top billing over Marley, I can do that the same way
# that I used for reordering the x-axis

p1 + scale_color_discrete(name = 'Dog', limits = c('Mia', 'Marley'))

# I like this, so I can save over p1 with this new p1.

p1 <- p1 + scale_color_discrete(name = 'Dog', limits = c('Mia', 'Marley'))

# Maybe I want to add some text to my graph. I can do this by adding another
# layer called "annotate". Let's say I want to put some text near Marley's 
# bill for Dinner.

# Because the meal is also interpreted as a factor, our x values are 1 for
# Lunch and 2 for Dinner. So my label will be at x = 1.5 and y = 30.

p1 + annotate('text', x = 1.5, y = 30, label = 'Marley is a Big Spender')

# If I wanted that to be in two lines, I can add the new line command '\n'

p1 + annotate('text', x = 1.5, y = 30, label = 'Marley is a\nBig Spender')

# Maybe I want to add an arrow to the actual point. I can do that by adding
# another annotation layer.

p1 + annotate('text', x = 1.5, y = 30, label = 'Marley is a\nBig Spender') +
  annotate('segment', x = 1.65, xend = 1.95, y = 30, yend = 30.51, 
           arrow = arrow(), color = 'violet', size = 3)

# We could play around with this all day long, but the bottom line is you can
# add unlimited annotation layers to your plot (text, line segments, different
# shapes, etc),

## Scatterplots ---------------------------------------------------------------

# Let's plot a scatterplot of the iris data with Sepal.Length vs Petal.Length

names(iris)

ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point()

# With scatterplots, we can add in lines of best fit without separately 
# calculating them. 

ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() + geom_smooth()

# This is using a loess smooth function. We can easily swap this out for a
# general linear model. 

ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() + geom_smooth(method = 'lm')

# The shaded regions show confidence intervals for the points, but if we are
# not interested in that, we can get rid of them.

ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() + geom_smooth(method = 'lm', se = FALSE)

# Now let's try to color-code based on species. We use color (we don't have)
# to use group because we're not connecting the dots, just color coding it.

ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length, 
                        color = Species)) + geom_point()

# Let's fix all the text.

p1 <- ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length, 
                        color = Species)) + geom_point() +
   scale_color_discrete(breaks = c('setosa',
                                   'versicolor',
                                   'virginica'),
                        labels = c('Setosa',
                                   'Versicolor',
                                   'Virginica')) +
  xlab('Petal Length') + ylab('Sepal Length') + ggtitle('Flower Growth') 

p1

# From here we could add annotation layers if we wanted. It would be the same
# process as above. However, we're going to move on to distributions.

## Histograms and Density Plots -----------------------------------------------

# The most basic histogram option is the one we all know and love. It should 
# not be surprising that we will start by defining our dataset and variable
# of interest. Then all we have to do is add geom_histogram().

ggplot(data = iris, aes(x = Sepal.Length)) + geom_histogram()

# There are some paramters we can change. Like 'binwidth'.

ggplot(data = iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = 0.5)
ggplot(data = iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = 0.25)
ggplot(data = iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = 0.05)

# If we wanted to plot distributions broken up by species, that's simple.

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) + 
  geom_histogram(binwidth = 0.3)

# To make things look prettier, we can change the level of transparancy (alpha)

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) + 
  geom_histogram(binwidth = 0.3, alpha = 0.7)

# If we wanted to see the approximate density distribution instead, all we have
# to do is use geom_density instead of geom_histogram

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density()

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.7)

# Both of these are pretty informative. If I wanted to see them together at the
# same time, I could assign them both plot names and then use grid.arrange
# from the gridExtra library.

p1 <- ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) + 
  geom_histogram(binwidth = 0.3, alpha = 0.7)

p2 <- ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.7)

grid.arrange(p1, p2, ncol = 2)

# Very simple stuff. From here we have figured out how to plot up to three 
# variables at the same time, change the order and names of discrete variables
# and plotted multiple plots in the same window. Now is when we customize 
# our plots to flow with the design of our poster/publication/etc.

## Customizing Plots ----------------------------------------------------------

# Let's say we want to change up things about the text like size, color, 
# orientation, etc. We can do this using the theme command. This command is
# a bit syntaxically confusing. You will first state what you want to change
# then you have to put all your arguments into an appropriate class identifier.

p1 <- ggplot(data = iris, aes(x = class, y = Sepal.Length, fill = Species)) +
  geom_bar(position = 'dodge', stat = 'summary', fun.y = 'mean') + 
  ylab('Average Sepal Length') + xlab('Color of Flower') +
  scale_x_discrete(breaks = c("A", "B", "C", "D", "E"),
                   labels = c("Red", "Blue", "Yellow",
                              "Purple", "White")) + ggtitle('Basic Plot')

p1

# Let's first change all axis titles to be larger and to be a different color. 
# Google R color chart. I like maroon. 

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'))

# Now, let's make the axis text larger too. We can do this either by adding a
# new theme command, or by putting more in the previous theme command. I like
# to put as much in a single theme command as possible, but if it gets to be 
# too much, I will break it up to different element types.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18))

# Now maybe I want to rotate the x axis text, but not the y. There is an angle
# argument for element_text() but if we apply it to the axis.text argument, we
# may not get desired results.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18, angle = 45))

# This rotated both the x and y axis text. Instead, we should use specific axis
# text arguments for x and y.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18), 
           axis.text.x = element_text(angle = 45))

# Now we have rotated only the x axis text, and notice that it still used the
# size = 18 from before. axis.text.x default to whatever you specified in 
# axis.text if you specifically redefine something. 

# But now, our labels are encroaching on the boarder. We can fix this.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18), 
           axis.text.x = element_text(angle = 45, vjust = 0.6)) # play w/ this

# Now let's make our title bigger and another color.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18), 
           axis.text.x = element_text(angle = 45, vjust = 0.6), 
           title = element_text(size = 36, color = 'navyblue'))

# Oops. Title also corresponds to the legend title. We don't want that.

p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
           axis.text  = element_text(size = 18), 
           axis.text.x = element_text(angle = 45, vjust = 0.6), 
           title = element_text(size = 36, color = 'navyblue'),
           legend.title = element_text(size = 24, color = 'maroon'),
           legend.text = element_text(size = 18))

# Now let's save the plot with the altered text themes.

p2 <- p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
                 axis.text  = element_text(size = 18), 
                 axis.text.x = element_text(angle = 45, vjust = 0.6), 
                 title = element_text(size = 36, color = 'navyblue'),
                 legend.title = element_text(size = 24, color = 'maroon'),
                 legend.text = element_text(size = 18))

p2

# Maybe we want to hide the grid marks. We can do that by overriding the 
# element_line with element_blank

p2 + theme(panel.grid = element_blank())

# We can use this to surpress only the minor grid lines. Also, let's make the
# grid lines navy blue and make the y grids larger than the x grids.

p2 + theme(panel.grid.minor = element_blank(),
           panel.grid.major = element_line(color = 'navyblue'),
           panel.grid.major.y = element_line(size = 1.5))

# I don't like that as much as I thought I would. I'm going to make it dashed
# lines instead.

p2 + theme(panel.grid.minor = element_blank(),
           panel.grid.major = element_line(color = 'navyblue', 
                                           linetype = 'dashed',
                                           size = 1.2),
           panel.grid.major.x = element_blank())

# Great. Let's save this as p3.

p3 <- p2 + theme(panel.grid.minor = element_blank(),
                 panel.grid.major = element_line(color = 'navyblue', 
                                                 linetype = 'dashed',
                                                 size = 1.2),
                 panel.grid.major.x = element_blank())

p3

# Now, we can change the background colors.

p3 + theme(plot.background = element_rect(fill = 'oldlace'),
           panel.background = element_rect(fill = 'lightpink'),
           legend.background = element_rect(fill = 'mistyrose'))

# This is a pretty color scheme, but the colors of the bars don't look good.
# To change the color of the actual variables, we can define a colorscheme.

ourpal <- c('mediumturquoise', 'mediumvioletred', 'midnightblue')

ggplot(data = iris, aes(x = class, y = Sepal.Length, fill = Species)) +
  geom_bar(position = 'dodge', stat = 'summary', fun.y = 'mean') + 
  ylab('Average Sepal Length') + xlab('Color of Flower') +
  scale_x_discrete(breaks = c("A", "B", "C", "D", "E"),
                   labels = c("Red", "Blue", "Yellow",
                              "Purple", "White")) + ggtitle('Basic Plot') +
  scale_fill_manual(values = ourpal)

# We'll save this so we can add the theme from before.

ourpal <- c('mediumturquoise', 'mediumvioletred', 'midnightblue')

p1 <- ggplot(data = iris, aes(x = class, y = Sepal.Length, fill = Species)) +
  geom_bar(position = 'dodge', stat = 'summary', fun.y = 'mean') + 
  ylab('Average Sepal Length') + xlab('Color of Flower') +
  scale_x_discrete(breaks = c("A", "B", "C", "D", "E"),
                   labels = c("Red", "Blue", "Yellow",
                              "Purple", "White")) + ggtitle('Basic Plot') +
  scale_fill_manual(values = ourpal)

p2 <- p1 + theme(axis.title = element_text(size = 24, color = 'maroon'),
                 axis.text  = element_text(size = 18), 
                 axis.text.x = element_text(angle = 45, vjust = 0.6), 
                 title = element_text(size = 36, color = 'navyblue'),
                 legend.title = element_text(size = 24, color = 'maroon'),
                 legend.text = element_text(size = 18))

p3 <- p2 + theme(panel.grid.minor = element_blank(),
                 panel.grid.major = element_line(color = 'navyblue', 
                                                 linetype = 'dashed',
                                                 size = 1.2),
                 panel.grid.major.x = element_blank())

p4 <- p3 + theme(plot.background = element_rect(fill = 'oldlace'),
                 panel.background = element_rect(fill = 'lightpink'),
                 legend.background = element_rect(fill = 'mistyrose'))
p4


## Preloaded Themes -----------------------------------------------------------
# If you don't want to go through the process of changing all of these things,
# you can choose a different theme here, I'll call a couple and plot them
# together for comparison.

p1gray <- p1 + theme_gray()
p1blwt <- p1 + theme_bw()
p1lndw <- p1 + theme_linedraw()
p1lite <- p1 + theme_light()
p1dark <- p1 + theme_dark()
p1mini <- p1 + theme_minimal()
p1clas <- p1 + theme_classic()
p1void <- p1 + theme_void()

grid.arrange(p1gray, p1blwt, p1lndw, p1lite,
             p1dark, p1mini, p1clas, p1void,
             ncol = 4)


## Saving Plots --------------------------------------------------------------
# R makes quick work of saving plots. You can use the point and click function
# of Rstudio, or you can build it into your code. These save it to the current
# working directory (which you can see right under the word "Console"). To 
# change the director you can use the setwd command.

setwd('./Desktop')

jpeg('rplot.jpg', width = 1200, height = 480)
grid.arrange(p1gray, p1blwt, p1lndw, p1lite,
             p1dark, p1mini, p1clas, p1void,
             ncol = 4)
dev.off()

png('rplot.png', width = 1200, height = 480)
grid.arrange(p1gray, p1blwt, p1lndw, p1lite,
             p1dark, p1mini, p1clas, p1void,
             ncol = 4)
dev.off()

pdf('rplot.pdf', width = 15, height = 6, paper = 'special')
grid.arrange(p1gray, p1blwt, p1lndw, p1lite,
             p1dark, p1mini, p1clas, p1void,
             ncol = 4)
dev.off()


## Heatmaps -------------------------------------------------------------------

# Heatmaps are a little different than the other plots, but they still follow
# the ggplot syntax (obviously). Heatmaps are generally used to compare 
# variables on the same scale across observations, show geographic data (GIS),
# or visualize correlation matrices. We will be doing the latter.

# We are using the built in 'mtcars' dataset. Instead of looking at the
# whole dataset, we can visualize the first 6 rows using the head() function.
head(mtcars)

# Great, now we can make a correlation matrix.

mtcarcor <- cor(mtcars)

# To plot this in ggplot, we want the variables along the x and y axis and the
# values to be the filled in shade. That's hard to do in wide form, so let's 
# melt it down. 

mtcarcorlong <- melt(mtcarcor)

# Now we have Var1 and Var2 that can go along the x and y axes and the value. 
# To make the heatmap in ggplot, we will use the geom_tile to fill in the 
# intersection of the variables.

ggplot(data = mtcarcorlong, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() 

# This is nice, but the color scheme does not make a lot of sense since the 
# there are two extremes instead of one.  Let's try to create a new one. We
# will need to use scale_fill because it's a fill varaible, and gradient since
# it is a continuous variable. However, for 2 poles, we need to use gradient2.


ggplot(data = mtcarcorlong, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() + scale_fill_gradient2(low = 'blue', mid = 'white', high = 'red')

# This doesn't suck. But there are a lot of tools online to find nice looking
# color schemes. One of my favorites is colorbrewer2.org but it doesn't 
# show the gradient version. We have to imagine it. Or plot it.

ggplot(data = mtcarcorlong, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() + scale_fill_gradient2(low = '#0571b0', mid = '#f7f7f7', 
                                     high = '#ca0020')

# That looks a little better. We can customize as above. 


## Acknowledgements and References --------------------------------------------
# While this workshop is designed entirely by myself, Emily Stark, it is one of
# many useful ggplot tutorials which helped shape my understanding of R, 
# ggplot, and data science. Therefore it is important to highlight that this 
# workshop could not have been created without the following resources:

# Cookbook for R, Winston Chang
# R for Everyone, Jared P. Lander
# R CRAN manuals for packages listed below

# The packages used for this workshop are below:
# Auguie, B & Antonov, A reshape2. R-project
#
# Wickham, H. (2007). Reshaping Data with the reshape Package. Journal of 
#     Statistical Software, 21(12), 1 - 20. 
#     doi:http://dx.doi.org/10.18637/jss.v021.i12
#
# Wickham, H. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag 
#     New York, 2016.
#

# Citation for Tidy Data paper:
# Wickham, H. (2014). Tidy Data. Journal of Statistical Software, 59(10), 
#     1 - 23. doi:http://dx.doi.org/10.18637/jss.v059.i10
