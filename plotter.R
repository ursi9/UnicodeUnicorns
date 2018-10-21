plotter <- function(df){
  data("wrld_simpl", package = "maptools")                                                                            
  wm <- crop(wrld_simpl, extent(-180, 180, 60, 90)) 
  
  # Defines the x axes required
  x_lines <- seq(-120,180, by = 60)
  lab <- as.character(df$Day[1], format="%Y-%m-%d")
  
  plotted <- ggplot() +
    geom_point(aes(x = Longitude, y = Latitude, color = Thickness), data = df, alpha = 0.6) +
    #geom_polygon(data = df, aes(x = Longitude, y = Latitude), color = "black", fill = "white", alpha = 0.2) +
    #geom_tile(data = df, aes(x = Longitude, y = Latitude, width = width, alpha = Thickness), fill = "black",  height = 25/111) +
    #geom_rect(data = df, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = Thickness)) +
    geom_polygon(data = wm, aes(x = long, y = lat, group = group), fill = "tan", colour = "black", alpha = 0.8) +
    
    # Convert to polar coordinates
    coord_map("ortho", orientation = c(90, 0, 0)) +
    scale_y_continuous(breaks = seq(60, 90, by = 5), labels = NULL) +
    
    # Removes Axes and labels
    scale_x_continuous(breaks = NULL) + 
    xlab("") + 
    ylab("") +
    
    # Change theme to remove axes and ticks
    theme(panel.background = element_blank(),
          panel.grid.major = element_line(size = 0.25, linetype = 'dashed',
                                          colour = "black"),
          axis.ticks=element_blank()) +
    labs(caption = lab)
  return(plotted)
}