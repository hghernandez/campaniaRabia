library(xlsx)
library(stringr)
library(rgdal)
library(ggplot2)
library(dplyr)
library(gridExtra)

dat <- read.xlsx2("datos/formulario Salvador Mazza.xlsx",1)


dat$long <- as.numeric(ifelse(dat$long_3_Ubicacin == "", "NA",paste(substring(dat$long_3_Ubicacin,1,3),".",substring(dat$long_3_Ubicacin,4,str_length(dat$long_3_Ubicacin)),sep="")))

dat$lat <- as.numeric(ifelse(dat$lat_3_Ubicacin == "", "NA",paste(substring(dat$lat_3_Ubicacin,1,3),".",substring(dat$lat_3_Ubicacin,4,str_length(dat$lat_3_Ubicacin)),sep="")))


dat <- dat %>%
  filter(X6_Ingres_a_la_vivien == "Si" & X7_Tiene_perros != "")

View(dat)


##Armo mapa interactivo con los datos de la Campaña de rabia
library(osmdata)
library(sf)
library(leaflet)
library(mapview)

mapSM <- getbb("salvador mazza, Salta",  format_out = "sf_polygon")



mapaTematico <- leaflet(mapSM) %>%
  addTiles() %>% 
  addPolygons() %>%
  addCircles(dat$long,dat$lat, radius= ~ as.numeric(dat$X8_Total_de_perros_va), fillColor = "blue")




