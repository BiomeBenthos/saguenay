# source("R/fig_aoi.R")
library(sf)
library(mapview)
sections <- st_read("./data/data-raw/saguenay_sections.geojson", quiet = TRUE)
stations <- st_read("./data/data-output/stations.geojson", quiet = TRUE)
cities <- st_read("./data/data-raw/cities.geojson", quiet = TRUE)

cols <- c("#4B0055","#00588B","#009B95","#53CC67","#FDE333")
nS <- c(20,15,50,20,20)
pts <- list()
for(i in 1:5) pts[[i]] <- rep(cols[i], nS[i])
pts <- unlist(pts)

# City names
xy <- st_coordinates(cities)
cit <-  data.frame(x = xy[,"X"], y = xy[,"Y"], 
                   name = c("Saint-Fulgence","Grande-Anse","Baie-des-Ha! Ha!",
                            "Anse-de-Sable","Baie-Éternité","Anse-Saint-Jean",
                            "Baie-Sainte-Marguerite","Tadoussac"),
                   offY = c(1000, 0,1000,0,0,0,1000,1000))

png('./figures/saguenay.png', res = 300, width = 500, height = 225, units = "mm")
par(mar = c(0,0,0,0))
plot(st_geometry(sections), col = paste0(cols,"44"))
plot(stations, add = TRUE, pch = 20, border = pts, col = paste0(pts,"99"), cex = 2.5, lwd = 2)
for(i in 1:nrow(cit)) text(x = cit$x[i], y = cit$y[i]+cit$offY[i], labels = cit$name[i])
dev.off()

