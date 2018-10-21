spaceappdata <- function(startdate,enddate = 0,step = 10){
  if(enddate == 0) {enddate <- startdate}
  date <- startdate
  i <- 1
  data.1 <- data.frame()
  
  while (date <= enddate) {
    print(as.character(date, format = "%d-%m-%Y"))
    file <- paste("RDEFT4_", as.character(date, format = "%Y%m%d"), ".nc", sep = "")
    if (file.exists(file)){
      nc <- nc_open(file)
      thicc<- ncvar_get(nc, "sea_ice_thickness")
      nonzero <- (thicc > 0)
      assign(paste("data.", as.character(i), sep = ""), value = rbind(get(paste("data.", as.character(i), sep = "")), data.frame(
        "Longitude" = ncvar_get(nc, "lon")[nonzero], 
        "Latitude" = ncvar_get(nc, "lat")[nonzero], 
        #"Height" = ncvar_get(nc, "freeboard")[nonzero], 
        "Thickness" = thicc[nonzero], 
        "Day" = rep(date,times = length(thicc[nonzero]))
      )))
    }
    #newdate <- date + step
    #if (newdate > as.Date(paste(as.character(date, format = "%Y"),"05 15"), format = "%Y %m %d") & date <= as.Date(paste(as.character(date, format = "%Y"),"05 15"), format = "%Y %m %d")) {
    #  i <- i+1
    #}
    #date <- newdate
    date <- date + step
  }
  return(data.1)
}


#seaboard <- ncvar_get(nc, "seaboard")[a]