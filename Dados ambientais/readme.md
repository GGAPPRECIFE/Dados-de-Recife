# 🌱 Observatório Ambiental do Recife

![Status](https://img.shields.io/badge/Status-Ativo-brightgreen)
![Dataset](https://img.shields.io/badge/Dados-Ambientais-green)
![Local](https://img.shields.io/badge/Cidade-Recife-red)

Este repositório consolida indicadores e dados geoespaciais sobre o ecossistema urbano do Recife. O foco principal é fornecer subsídios para o planejamento sustentável e a mitigação dos efeitos das mudanças climáticas na capital pernambucana.

---

## 🌳 Censo Arbóreo 2023

O destaque atual deste hub é o **Censo Arbóreo**, que mapeou detalhadamente a infraestrutura verde da cidade.

### 📍 Visualização Geoespacial
Utilizamos tecnologias de alta performance para renderizar a distribuição de **259.575 árvores**. O mapa integra a malha de bairros com informações individuais de cada espécie.

* **Tecnologia:** Renderização via GPU com `leafgl` no R.
* **Interatividade:** Labels dinâmicos que identificam o nome popular e altura ao passar o mouse.
* **Camadas:** Delimitação oficial por bairros e RPAs (Regiões Político-Administrativas).

---

## 📊 Inventário de Dados Ambientais

| Indicador | Fonte | Formato | Descrição |
| :--- | :--- | :--- | :--- |
| **Arborização Urbana** | Censo Arbóreo | `.geojson` / `.csv` | Localização, espécie, altura e porte das árvores. |
| **Recursos Hídricos** | SEPLAN | `.shp` | Mapeamento de canais, rios e bacias hidrográficas. |
| **Áreas Verdes** | PCR | `.csv` | Inventário de parques, praças e áreas de preservação. |
| **Resíduos Sólidos** | EMLURB | `.json` | Pontos de coleta seletiva e volume de descarte por região. |
| **Dados climáticos** | Divsersas fontes | `.xlsx`, `.tiff`, `.geotiff`| Precipitação, temperatura, umidade relativa do ar. |

---

## 🛠️ Como Explorar os Dados no R

Para reproduzir as análises ambientais e o mapa de arborização:

```R
# Exemplo de carregamento dos dados de arborização
library(sf)
dados_ambientais <- st_read("data/censo_arboreo_recife.geojson")

# Visualizando o porte das espécies
table(dados_ambientais$porte_esp)
