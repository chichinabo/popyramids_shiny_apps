require("epade")
# Plot logos on the pyramid
require("png")
require("grid")

mars_path<-file.path("../resources/images/mars.png")
venus_path<-file.path("../resources/images/venus.png")
chibo_path<-file.path("../resources/images/chibo.png")
chibo_percent_path<-file.path("../resources/images/chibo_percent.png")

mars_icon <- readPNG(mars_path)
venus_icon <- readPNG(venus_path)
chibo_icon <- readPNG(chibo_path)
chibo_percent_icon <- readPNG(chibo_percent_path)

############################ Retrieve app statistics ############################
## TODO: We need to modify this function for plotting multivariable pyramids
plot_pyramid<- function(feature){
  
  pid<-unlist(feature$properties$pid)
  pop.xy<-unlist(feature$properties$what_data[[1]]$what_xy)
  pop.xx<-unlist(feature$properties$what_data[[1]]$what_xx)
  pop.age<-unlist(feature$properties$what_data[[1]]$what_age)
  pop.total<-unlist(feature$properties$what_total_pop)
  when<-unlist(feature$properties$when_reference)
  geoname<-unlist(feature$properties$where_geoname)
  project<-unlist(feature$properties$what_project)
  provider<-unlist(feature$properties$whose_provider)
  url<-unlist(feature$properties$whose_url)
  bins<-length(pop.age)
  
  tornado.ade(cbind(pop.xy, pop.xx),
              vnames=pop.age,
              gnames=c('',''),
              xlab='',
              main=geoname,
              col= cbind("#9ECAE1", "#FC9272"),
              legendon="bottom",
              wall = 2)
  
  ##Year
  mtext(substring(when,1,4), cex=1.2, col="black", font=2)
  
  ##Sources
  mtexti(paste(provider, " (", url,")"), 2, cex=.8, col="gray")#2=left-center
  mtexti(project, 4, cex=.8, col="gray")#4=right-center
  
  ##Chibo credits
  mtext("popyramids.chichinabo.org", 1, line=4, adj=0, cex=.8, col="gray")
  mtext(paste("PID:",pid), 1, line=4, adj=1.0, cex=.8, col="gray")
  
  
  grid.raster(mars_icon,height = 0.05,interpolate = TRUE,x = 0.25, y = 0.85,just = "right")
  grid.raster(venus_icon,height = 0.05,interpolate = TRUE,x = 0.75, y = 0.85,just = "left")
  
  ##Check if it is a percentages pyramid
  if(pop.xy[1]==floor(pop.xy[1])){
    grid.raster(chibo_icon,height = 0.10,interpolate = TRUE, x = 0.50, y = 0.11,just = "center")
  }else{
    grid.raster(chibo_percent_icon,height = 0.08,interpolate = TRUE, x = 0.50, y = 0.11,just = "center")
  }
  
}


## Plot an empty chart when no data is provided
plot_pyramid_empty<- function(){
  
  tornado.ade(cbind(c(1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0), c(1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0)),
              vnames=c("[0-10)","[10-20)","[20-30)","[30-40)","[40-50)","[50-60)","[60-70)","[70-80)","[80-90)","[90-100)","[100,)"),
              gnames=c('',''),
              xlab='',
              main='No data, no pyramid!!',
              col="gray",
              legendon="bottom",
              wall = 2)
  
  ##Chibo credits
  mtext("popyramids.chichinabo.org", 1, line=4, adj=0.5, cex=1.5)
  grid.raster(chibo_icon,height = 0.4,interpolate = TRUE, x = 0.30, y = 0.50,just = "center")
}

