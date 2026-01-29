# 🌿 Áreas Verdes Urbanas do Recife (greenR)

Este repositório apresenta **dados, scripts e análises das áreas verdes urbanas do município do Recife**, extraídas por meio do **pacote `greenR` (R)**, que permite a identificação, quantificação e análise espacial da cobertura vegetal em ambientes urbanos a partir de dados geoespaciais.

O objetivo principal é **mapear, mensurar e analisar a distribuição das áreas verdes**, fornecendo subsídios técnicos para estudos ambientais, planejamento urbano e formulação de políticas públicas. As áreas verdes dozem respeito a parques, praças, Academias da cidade, clubes, Jardins, Quadras ou instituições que possuam áreas verdes em suas delimitações. Diversos trabalhos acadêmicos analisam a importância de áreas verdes para a qualidade de vida urbana.

---

## 📍 Área de Estudo

- **Município:** Recife – PE  
- **Contexto urbano:** cidade costeira, densamente urbanizada, com elevada impermeabilização do solo e forte desigualdade socioespacial  
- **Relevância ambiental:** mitigação de ilhas de calor, regulação microclimática, drenagem urbana e melhoria da qualidade de vida

**[🔗 Clique aqui para acessar o Mapa das áreas verdes de Recife](https://areas-verdes-recife.netlify.app/)**
---

## 🛠️ Metodologia

A extração e análise das áreas verdes foram realizadas em ambiente **R**, utilizando principalmente o pacote **`greenR`**, integrado a ferramentas de geoprocessamento e análise espacial.

### Etapas metodológicas

1. Delimitação do perímetro urbano do Recife  
2. Aquisição e preparação das bases espaciais  
3. Identificação das áreas verdes urbanas com o `greenR`  
4. Cálculo de métricas espaciais e indicadores ambientais  
5. Agregação dos resultados por unidades territoriais (bairros, RPAs, setores censitários)

---

## 📦 Pacote `greenR`

O **`greenR`** é um pacote desenvolvido para:
- Detecção e quantificação de áreas verdes urbanas  
- Cálculo de métricas de cobertura vegetal  
- Integração com objetos `sf` e `terra`  
- Produção de indicadores comparáveis no espaço urbano  

Sua aplicação permite análises **reprodutíveis, transparentes e escaláveis**, fundamentais para estudos territoriais.

---

## 📊 Indicadores Gerados

A partir do `greenR`, foram produzidos, entre outros, os seguintes indicadores:

- Área total de cobertura verde (m² e hectares)  
- Proporção de área verde por unidade territorial  
- Área verde per capita  
- Distribuição espacial das áreas verdes  
- Desigualdade intraurbana de acesso à vegetação  

Esses indicadores possibilitam diagnósticos ambientais precisos e comparações espaciais.

---

## 🗺️ Escalas de Análise

Os resultados podem ser analisados em diferentes níveis:

- Município  
- Regiões Político-Administrativas (RPAs)  
- Bairros  
- Setores censitários  

Essa flexibilidade permite avaliar padrões macro e microespaciais da vegetação urbana.

---

## ⚠️ Limitações

- Dependência da qualidade das bases cartográficas  
- Diferenças conceituais entre “área verde” e “cobertura vegetal”  
- Possível sub ou superestimação em áreas mistas (vegetação + infraestrutura)  
- Resultados sensíveis à escala de análise adotada  

Essas limitações devem ser consideradas na interpretação dos indicadores.

---

## 🌱 Aplicações

As análises desenvolvidas neste repositório podem subsidiar:

- Planejamento urbano e ambiental  
- Gestão de parques, praças e corredores verdes  
- Políticas de adaptação às mudanças climáticas  
- Avaliação de desigualdades socioambientais  
- Monitoramento contínuo da infraestrutura verde urbana

---

## 📚 Fontes e Referências

- Pacote **greenR** (R)  
- IBGE – Malhas territoriais e Censo Demográfico 2022  
- Dados geoespaciais oficiais do município do Recife  

---

## 📌 Considerações Finais

A utilização do **`greenR`** para a análise das áreas verdes do Recife fortalece abordagens baseadas em dados e evidencia o papel da **infraestrutura verde** como componente essencial da sustentabilidade urbana.

Contribuições são bem-vindas por meio de *issues* ou *pull requests*.

## Script

```
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

