# Libraries 
library(sf)
library(tidyverse)
library(magrittr)
library(mapview)

# Data 
sections <- st_read("./data/data-raw/saguenay_sections.geojson")

# Functions
source("./R/fnc_sampling.R")

# Number of samples per section
nS <- c(20,15,50,20,20)

# Internal buffer of 10m along coast and between sections 
sections <- st_buffer(sections, -20)

# Stations
samples <- list()
for(i in 1:nrow(sections)) {
  samples[[i]] <- sampling(sections[i, ], nS[i])
}
samples <- bind_rows(samples)

# Export
st_write(samples, './data/data-output/stations.geojson', delete_dsn = TRUE)

# Visualize
mapview(sections) + mapview(samples)








# Export
st_write(sections, "data/data-raw/saguenay_sections.geojson")
            