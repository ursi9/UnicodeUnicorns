library(rgdal)                                                                                                      
library(raster)
library(ggplot2)
library(rgeos)
library(ncdf4)
library(maps)
library(mapdata)
library(mapproj)
library(maptools)
library(sp)

startdate<-as.Date("20100926", format="%Y%m%d")
enddate<-as.Date("20110515", format="%Y%m%d")

df<-spaceappdata(startdate = startdate, enddate = enddate, step = 1)

k_size<- data.frame("k" = numeric(), "Day" = as.Date(x = integer(0), origin = "1970-01-01"))
for(d in unique(df$Day)){
  print(d)
  sel<-(df$Day == d)
  k_size <- rbind(k_size, data.frame("k" = (mean(df$Thickness[df$Day == d])*length(df$Day[df$Day == d])), "Day" = as.Date(d, format = "%Y-%m-%d", origin = "1970-01-01")))
}

a<-seq(1, length(k_size$Day), by = as.integer(length(k_size$Day)/4))
val <- ggplot() + geom_line(data = k_size, aes(x = as.numeric(Day), y = k)) + labs(caption = "mass of ice over time") + ylim(0,max(k_size$k))
pic1 <- plotter(subset(df, Day == k_size$Day[a[1]]))
pic2 <- plotter(subset(df, Day == k_size$Day[a[2]]))
pic3 <- plotter(subset(df, Day == k_size$Day[a[3]]))
pic4 <- plotter(subset(df, Day == k_size$Day[a[4]]))
pic5 <- plotter(subset(df, Day == k_size$Day[a[5]]))
