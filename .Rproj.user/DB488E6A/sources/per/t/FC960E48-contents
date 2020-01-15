library(xlsx)
library(readxl)
library(stringr)
library(rgdal)
library(ggplot2)
library(dplyr)
library(gridExtra)

dat <- read.xlsx2("datos/formulario Salvador Mazza.xlsx",1)
dat <- as.data.frame(read_xlsx("datos/formulario Salvador Mazza.xlsx",1))

View(dat)

str(dat)
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
library(htmlwidgets)
library(htmltools)


mapSM <- getbb("salvador mazza, Salta",  format_out = "sf_polygon")

titulo <- tags$div(
  HTML("<h1>Campaña contra rabia. Salvador Mazza</h1>"))  #Agrego Titulo

mapTematico <- leaflet(mapSM) %>%
  addTiles() %>% 
  addPolygons() %>%
  addCircles(dat$long,dat$lat, radius= ~ (dat$`8_Total_de_perros_va`), color= "red", fill = TRUE, fillColor = "red", label= c(dat$`8_Total_de_perros_va`)) %>%
  addControl(titulo, position = "topleft")

mapTematico


#Guardo el archivo con extension .html
library(htmlwidgets)

saveWidget(mapTematico , "C:/Users/Gabriela/Desktop/campaniaRabia.html", selfcontained = TRUE)




