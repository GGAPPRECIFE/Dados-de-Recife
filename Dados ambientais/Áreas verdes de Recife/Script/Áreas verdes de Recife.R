#---_---------------------------------------------------------------------------
# Áreas verdes---
#---_---------------------------------------------------------------------------
# Carregamento dos pacotes
library(greenR) #pacote que extrai as áreas verdes
library(sf)
library(dplyr)
library(ggplot2)
library(osmdata)
library(janitor)
library(stringi)
library(patchwork)
library(lubridate)
library(rcompanion)
library(geobr)
library(tidyverse)
library(sf)
library(leaflet)
library(leafgl)
library(htmlwidgets)
library(RColorBrewer)
library(htmltools)
library(magrittr)

#---_---------------------------------------------------------------------------
## Extração dos dados----
#---_---------------------------------------------------------------------------

#bbox de Recife
bbox_recife <- c(xmin = -35.10,ymin = -8.15,xmax = -34.85,ymax = -7.98)
#extraindo as áreas verdes de Recife
data <- get_osm_data(bbox_recife)

# O objeto 'data' é uma lista e desta lista extraímos 
green_areas_data <- data$green_areas 
#Convertendo 
green_areas2 <- green_areas_data$osm_polygons%>% st_transform(4326)
#Visualizando as áreas verdes
visualize_green_spaces(green_areas_data)
#Agrupando as áreas verdes
green_space_clustering(green_areas_data, num_clusters = 3)

#Bairros de Recife
bairros_recife <- read_sf('PE_bairros_CD2022.shp')%>% 
  filter(NM_MUN=='Recife') %>% 
  st_transform(4326)

#Extraindo as áreas verdes que interceptam apenas os bairros de Recife
areas_recife <- st_join(green_areas2,bairros_recife, join=st_intersects)

#Calculando as áreas em m² das áreas verdes
areas_recife <- areas_recife %>% mutate(area = st_area(geometry))

#Salvando o shapefile das áreas verdes
st_write(areas_recife, 'areas_recife2.shp')


#---_---------------------------------------------------------------------------
# Criando um mapa interativo com os pacotes leaflet e leafgl----
#---_---------------------------------------------------------------------------

mapa_area_verde <- leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(data = bairros_recife,fillColor ='transparent',
              weight = 1,opacity = 1,color = "black",     # Cor da linha de contorno
              fillOpacity = 0.3,highlightOptions = highlightOptions(
                weight = 3,color = "#666",
                fillOpacity = 0.7,  bringToFront = FALSE)) %>% 
  addPolygons(data = areas_recife %>% filter(NM_MUN=='Recife'),fillColor ='darkgreen',
              weight = 1,opacity = 1,color = "black", dashArray = "3",fillOpacity = 0.3,
              highlightOptions = highlightOptions(weight = 3,color = "#666",
                                                  fillOpacity = 0.7,  bringToFront = FALSE),
              #label = ~NM_BAIRRO,  # Aparece o nome ao passar o mouse
              popup = ~paste0("<b>OSM_ID:</b> ", osm_id, "<br>",
                              "<b> Nome:</b> ", name, "<br>",
                              "<b> Nome do Bairro:</b> ", NM_BAIRRO, "<br>",
                              "<b> RPA:</b> ", NM_SUBDIST, "<br>")) 
#Salvando mapa em html
saveWidget(mapa_area_verde, file = "mapa_area_verde.html", selfcontained = TRUE)
