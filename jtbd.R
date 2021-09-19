#Code for JTBD data visualisation (2018) by Fiona MacNeill is licensed under a Creative
#Commons Attribution-ShareAlike 4.0 International License:
#http://creativecommons.org/licenses/by-sa/4.0/
#Based on a work at
#http://www.marketingjournal.org/the-path-to-growth-the-opportunity-algorithm-anthony-ulwick/.

#Loading the libraries needed for the visualisation

library(extrafont)
library(ggplot2)
font_import("Trebuchet MS")

#This data is provided for illustration only and is simulated - please use your own data

jtbd <- structure(list(id = structure(c("Look at time", "Check emails", "Review notifications", "Review activity", "Review heart rate", "Check Social Media", "Log exercise", "Text messaging", "Use voice control", "Pay by Touch", "Unlock by proximity", "Using apps"), 
.Label = c("Look at time", "Check emails", "Review notifications", "Review activity", "Review heart rate", "Check Social Media", "Log exercise", "Text messaging", "Use voice control", "Pay by Touch", "Unlock by proximity", "Using apps")),
Importance = c(9, 4, 8, 7, 5, 4, 7, 3, 1, 2, 2, 5),
Satisfaction = c(9.5, 6, 9, 9, 8, 6, 9, 6, 4, 4, 5, 7),
Oportunity.Score = c(8.5, 2, 7, 5, 2, 2, 5, 0, -2, 0, -1, 3)), .Names = c("Jobs", "Importance", "Satisfaction", "Opportunity Score"), class = "data.frame")

#Labels for the areas of the plot

labelover <- data.frame(
x = 1,
y = 9.5,
label="OVERSERVED")

labeljust <- data.frame(
x = 3,
y = 0.5,
label="JUST RIGHT")

labelunder <- data.frame(
x = 9,
y = 0.5,
label="UNDERSERVED")

#Line segments for the midsection of the plot

#Top line
segment1 <- data.frame(
x = 0,
y = 0,
xend = 10,
yend = 10)

#Bottom line
segment2 <- data.frame(
x = 5,
y = 0,
xend = 10,
yend = 10)

#Ripe for disruption line
segment3 <- data.frame(
x = 0,
y = 4,
xend = 5,
yend = 10)

#Potential for disruption line
segment4 <- data.frame(
x = 0,
y = 2,
xend = 7,
yend = 10)

#Limited Opportunity
segment5 <- data.frame(
x = 5,
y = 0,
xend = 10,
yend = 10)

#Solid Opportunity
segment6 <- data.frame(
x = 6,
y = 0,
xend = 10,
yend = 8)

#High Opportunity
segment7 <- data.frame(
x = 7.2,
y = 0,
xend = 10,
yend = 5)

#top triangle
tri.top <- data.frame(
x = c(0, 10, 0),
y = c(10, 10, 0))

#middle triangle
tri.mid <- data.frame(
x = c(5, 10, 0),
y = c(0, 10, 0))

#bottom triangle
tri.btm <- data.frame(
x = c(10, 10, 5),
y = c(10, 0, 0))

#ulwick triangle
tri.ulw <- data.frame(
x = c(0, 10),
y = c(2, 6))

#Definining global x and y variables
x <- jtbd$Importance
y <- jtbd$Satisfaction 

#The plot itself 
ggplot(jtbd, aes(x=Importance, y=Satisfaction)) +

#A grey area like you would find in Tony Ulwick's Opportunity Landscape visualisation 
geom_area(data = tri.ulw, aes(x = x, y = y), alpha=0.2, fill ="purple") + 

#A trend line to show the data trend which may or may not be useful, this could be turned on by removing the '#'
#geom_smooth(method = "lm", se = FALSE) + 

#The triangle for OVERSERVED 
geom_polygon(data = tri.top, aes(x = x, y = y), fill ="grey90", alpha="0.6") + 

#The triangle for JUST RIGHT 
geom_polygon(data = tri.mid, aes(x = x, y = y), fill ="grey70", alpha="0.5") + 

#The triangle for UNDERSERVED 
geom_polygon(data = tri.btm, aes(x = x, y = y), fill ="grey65", alpha="0.7") + 

#If you wanted to highlight that sweet spot, these areas could be turned on by removing the '#'
#geom_segment(data = segment1, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
#geom_segment(data = segment2, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
geom_segment(data = segment3, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
annotate("text", x = 2, y = 8, label = "Ripe for disruption") + 
geom_segment(data = segment4, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
annotate("text", x = 5.1, y = 9, label = "Potential for disruption") + 
geom_segment(data = segment5, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
annotate("text", x = 9.3, y = 8, label = "Limited Opportunity", size = 3) + 
geom_segment(data = segment6, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
annotate("text", x = 9, y = 6, label = "Solid Opportunity (Opp >10)", size = 3) +
geom_segment(data = segment7, aes(x = x, y = y, xend = xend, yend = yend), alpha=0.2, linetype=2) + 
annotate("text", x = 8.8, y = 4, label = "High Opportunity (Opp >12)", size = 3) +
annotate("text", x = 9, y = 1.5, label = "Extreme Opportunity (Opp >15)", size = 3) +

#Our very helpful labels
geom_text(data = labelover, aes(x = x, y = y, label = label), size=5) +
geom_text(data = labeljust, aes(x = x, y = y, label = label), size=5) +
geom_text(data = labelunder, aes(x = x, y = y, label = label), size=5) +

#Our job labels (optional)
#geom_label(aes(label = jtbd$Job), nudge_y = 0.24, nudge_x = 0.04, hjust="right", alpha=0.8, size=4) +

#The points for our jobs
geom_point(color="blue", alpha=0.5, size=4) +

#Set the scales the way that I want them - aka not as decimals!
scale_x_continuous(limits=c(0, 10), breaks = c(0, 2, 4, 6, 8, 10), labels = scales::comma_format(digits = 1)) +
scale_y_continuous(limits=c(0, 10), breaks = c(0, 2, 4, 6, 8, 10), labels = scales::comma_format(digits = 1)) +

#Hide the legend as it is not helpful this time
theme(legend.position = "none") +

#Labelling the plot
labs(
title ="DEMO: Tasks on a smart watch",
subtitle = "a subtitle") +
theme(panel.background = element_rect(fill = "white", colour = "black"), legend.position = "none")
