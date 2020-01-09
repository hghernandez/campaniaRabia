library(xlsx)
library(readxl)
library(stringr)
library(rgdal)
library(ggplot2)
library(dplyr)
library(gridExtra)

dat <- read.xlsx2("datos/formulario Salvador Mazza.xlsx",1)
dat <- read_xlsx("datos/formulario Salvador Mazza.xlsx",1)


dat$long <- as.numeric(ifelse(dat$long_3_Ubicacin == "", "NA",paste(substring(dat$long_3_Ubicacin,1,3),".",substring(dat$long_3_Ubicacin,4,str_length(dat$long_3_Ubicacin)),sep="")))

dat$lat <- as.numeric(ifelse(dat$lat_3_Ubicacin == "", "NA",paste(substring(dat$lat_3_Ubicacin,1,3),".",substring(dat$lat_3_Ubicacin,4,str_length(dat$lat_3_Ubicacin)),sep="")))


#Filtro solo cuando se ingreso a la vivienda y las que tenian perros
dat <- dat %>%
  filter(dat[,c(12)] == "Si" & dat[,c(13)] != "" & is.na(long) == FALSE)




##Armo mapa interactivo con los datos de la Campaña de rabia
library(osmdata)
library(sf)
library(leaflet)
library(mapview)


mapSM <- getbb("salvador mazza, Salta",  format_out = "sf_polygon")

radius <- names(dat[,c(14)])

mapaTematico <- leaflet(mapSM) %>%
  addTiles() %>% 
  addPolygons() %>%
  addCircles(dat$long,dat$lat, radius= ~ (dat$`8_Total_de_perros_va`), fillColor = "blue")




