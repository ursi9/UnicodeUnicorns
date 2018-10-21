plotter <- function(df){
  # Set Background Map
  data("wrld_simpl", package = "maptools")                                                                            
  wm <- crop(wrld_simpl, extent(-180, 180, 60, 90)) 
  
  # Date Labels
  lab <- as.character(df$Day[1], format="%Y-%m-%d")
  
  # Plot Map and Ice
  plotted <- ggplot() +
    geom_point(aes(x = Longitude, y = Latitude, color = Thickness), data = df, alpha = 0.6) + #Ice
    geom_polygon(data = wm, aes(x = long, y = lat, group = group), fill = "tan", colour = "black", alpha = 0.8) + #Map
    
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
