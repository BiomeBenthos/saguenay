# Libraries 
library(sf)
library(tidyverse)
library(magrittr)
library(mapview)

# Data 
sag <- st_read("./data/data-raw/saguenay.geojson")
lim <- st_read("./data/data-raw/section_limits.geojson") # Done manually with mapedit

# Split 
sections <- lwgeom::st_split(sag, lim) %>% 
            st_cast() %>%
            mutate(troncon = 1:(nrow(lim)+1)) %>%
            select(troncon, name, geometry)


# Names
sections$name <- c("Bassin inférieur","Bassin intermédiaire","Centre","Saint-Fulgence","BaieHaHa")

# Export
st_write(sections, "data/data-raw/saguenay_sections.geojson")
            