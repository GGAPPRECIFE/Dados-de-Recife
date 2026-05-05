# ============================================================================
# Tratamento dos dados para modelo da metodologia CADINSAN —----
# ============================================================================
# Observações gerais (importante ler antes de rodar):
# 1) Há vários 'library()' repetidos. Não causa erro, mas deixa a sessão mais lenta.
# 2) O caminho de trabalho (setwd) é local; ajuste ao seu ambiente antes de rodar.
# 3) Alguns nomes de colunas possuem espaços à esquerda (ex.: " d.vlr_renda_media_fam").
#    Isso é frágil. Considere usar janitor::clean_names() para padronizar.
# 4) O limiar de classificação (0.8) para insegurança grave é uma escolha conservadora;
#    avalie trade-offs com métricas (precision/recall) e curvas ROC/PR.
# 6) Atenção: variáveis categóricas (faixa_renda, sexo, etc.) entram como fatores.
#    Garanta níveis consistentes entre base de treino (PNAD) e de predição (CadÚnico).
# 7) UF está em nomes por extenso ("São Paulo" etc.). Confirme se é coerente com seu RDS.

# ============================================================================
# 0. Diretório de trabalho ----
# ============================================================================
setwd('')
getwd()
# ============================================================================
# 1. Carregando pacotes ----
# ============================================================================
library(lwgeom)          # Geometrias avançadas para 'sf'
library(sf)              # Dados espaciais (simple features)
library(stringi)         # Strings (acentos, normalização)
library(tidyr)           # Tidyr (pivot, separa/une colunas)
library(dplyr)           # Manipulação de dados (pipe, mutate, join)
library(tidyverse)       # Coleção de pacotes (inclui dplyr, ggplot2, etc.)
library(tidyr)
library(dplyr)
library(sf)
library(ggrepel)         # Rótulos que não se sobrepõem em gráficos
library(gghighlight)     # Destacar séries/pontos em gráficos
library(webr)            # Funções diversas; evite se não usar
library(stringr)         # Manipulação de strings
library(gridExtra)       # Arranjar gráficos em grid
library(stringi)
library(patchwork)       # Compor gráficos (|, /, +)
library(leaflet)         # Mapas interativos
library(patchwork)
library(scales)          # Escalas e formatações (percent, comma)
library(elevatr)         # Elevação (se não usar, pode remover)
library(geobr)           # Geometrias do Brasil (IBGE)
library(concaveman)      # Polígonos concavos a partir de pontos
library(terra)           # Sucessor do 'raster'
library(convey)          # Indicadores de renda/pobreza com survey
library(lubridate)       # Datas
library(gganimate)       # Animações de gráficos
library(survey)          # Análise amostral complexa
library(geobr)
library(scales)
library(lubridate)
library(ggplot2)
library(ggtext)          # Texto rico no ggplot
library(ggplot2)
library(sf)
library(geobr)           # Para mapas do Brasil
library(dplyr)
library(ggrepel)         # Para nomes de cidades
library(ggforce)         # Círculos, elipses; geometria no ggplot
library(rnaturalearth)   # Fronteiras/países do mundo
library(rnaturalearthdata)
library(readr)           # Leitura de csv/tsv
library(ggplot2)
library(patchwork)
library(geosphere)       # Geodésica (distâncias)
library(raster)
library(terra)
library(readr)
library(scales)
library(survey)
library(pROC)            # Curvas ROC/AUC
library(stringi)
library(caret)           # Treino/validação de modelos
sf::sf_use_s2(FALSE)     # Desativa S2 (interseções geoespaciais podem mudar comportamento)

# ============================================================================
# 2. Modelo CADISAN (base PNAD 2023) ----
# ============================================================================

# Selecionando os dados extraídos
# As variáveis foram extraídas da Pesquisa Nacional por Amostra de Domicílios (PNAD) de 2023
pnad <- readRDS('pnadc_anual2023_conc4_segalimentar.rds')

# Descrição das variáveis (conforme documentação PNAD)
# VDI5008  — Renda domiciliar per capita (habitual + outras fontes)
# UF       — Unidade da Federação (nome por extenso)
# V1022    — Tipo de área ("Urbana"/"Rural")
# V2007    — Sexo da pessoa de referência ("Homem"/"Mulher"/"Sem informação")
# V2010    — Cor/raça da pessoa de referência ("Branca", "Preta", "Parda", etc.)
# V2009    — Idade da pessoa (ver uso abaixo para presença de <18)
# V40132A  — Setor de ocupação ("Outra atividade" vs. agrícola)
# SD17001  — Segurança/insegurança alimentar (categorias da EBIA)

# Seleciona apenas as colunas necessárias para o modelo
data_pnad <- pnad$variables[c('VDI5008','UF','V1022','V2007','V2010','V2009','V40132A','SD17001')]

# Define estados do Sul e Sudeste (para criar faixas de renda distintas por região)
sul_sudeste <- c("Rio Grande do Sul", "Santa Catarina", "Paraná", "São Paulo",
                 "Rio de Janeiro", "Minas Gerais", "Espírito Santo")

# Criação de variáveis derivadas para o modelo --------------------------------
# - faixa_renda: cortes diferentes para Sul/Sudeste vs demais regiões
# - regiao: codifica macro-regiões em inteiros 1..5
# - tipo_area: numeric (1 urbana; 2 rural)
# - sexo: codifica em 0/1/2
# - cor_raca: 1 Preta; 2 Branca; 3 Outros (Parda, Amarela, Indígena, Ignorado)
# - presenca_18: 1 se há <18 no domicílio, 0 caso contrário (cuidado: V2009 é idade da pessoa; aqui
#                usa-se ifelse(V2009>18,0,1) para cada linha; na prática, isso não detecta presença
#                de menores no domicílio, e sim se o indivíduo é <18. Avalie a proxy.)
# - setor_ocup: 1 se agrícola ("V40132A" != 'Outra atividade'), 0 caso contrário
# - inseg_grave: 1 se SD17001 == 'Insegurança alimentar grave'

data_pnad <- data_pnad %>%
  mutate(
    faixa_renda = case_when(
      is.na(VDI5008) ~ "Sem renda",
      UF %in% sul_sudeste & VDI5008 <= 199 ~ "Abaixo de 200",
      UF %in% sul_sudeste & VDI5008 > 199 & VDI5008 <= 350 ~ "De 199 a 350",
      UF %in% sul_sudeste & VDI5008 > 350 & VDI5008 <= 481 ~ "De 350 a 481",
      UF %in% sul_sudeste & VDI5008 > 481 & VDI5008 <= 602 ~ "De 481 a 602",
      UF %in% sul_sudeste & VDI5008 > 602 & VDI5008 <= 720 ~ "De 602 a 720",
      UF %in% sul_sudeste & VDI5008 > 720 & VDI5008 <= 840 ~ "De 720 a 840",
      UF %in% sul_sudeste & VDI5008 > 840 & VDI5008 <= 965 ~ "De 840 a 965",
      UF %in% sul_sudeste & VDI5008 > 965 & VDI5008 <= 1113 ~ "De 965 a 1113",
      UF %in% sul_sudeste & VDI5008 > 1113 & VDI5008 <= 1285 ~ "De 1113 a 1285",
      UF %in% sul_sudeste & VDI5008 > 1285 & VDI5008 <= 1411 ~ "De 1285 a 1411",
      UF %in% sul_sudeste & VDI5008 > 1411 & VDI5008 <= 1486 ~ "De 1411 a 1486",
      UF %in% sul_sudeste & VDI5008 > 1486 & VDI5008 <= 1670 ~ "De 1486 a 1670",
      UF %in% sul_sudeste & VDI5008 > 1670 & VDI5008 <= 1885 ~ "De 1670 a 1885",
      UF %in% sul_sudeste & VDI5008 > 1885 & VDI5008 <= 2155 ~ "De 1885 a 2155",
      UF %in% sul_sudeste & VDI5008 > 2155 & VDI5008 <= 2515 ~ "De 2155 a 2515",
      UF %in% sul_sudeste & VDI5008 > 2515 & VDI5008 <= 2970 ~ "De 2515 a 2970",
      UF %in% sul_sudeste & VDI5008 > 2970 ~ "Acima de 2970",
      # Demais regiões → Faixas alternativas
      !UF %in% sul_sudeste & VDI5008 <= 100 ~ "De 1 a 100",
      !UF %in% sul_sudeste & VDI5008 > 100 & VDI5008 <= 200 ~ "De 100 a 200",
      !UF %in% sul_sudeste & VDI5008 > 200 & VDI5008 <= 240 ~ "De 200 a 240",
      !UF %in% sul_sudeste & VDI5008 > 240 & VDI5008 <= 290 ~ "De 240 a 290",
      !UF %in% sul_sudeste & VDI5008 > 290 & VDI5008 <= 330 ~ "De 290 a 330",
      !UF %in% sul_sudeste & VDI5008 > 330 & VDI5008 <= 380 ~ "De 330 a 380",
      !UF %in% sul_sudeste & VDI5008 > 380 & VDI5008 <= 600 ~ "De 380 a 600",
      !UF %in% sul_sudeste & VDI5008 > 600 & VDI5008 <= 650 ~ "De 600 a 650",
      !UF %in% sul_sudeste & VDI5008 > 650 & VDI5008 <= 810 ~ "De 650 a 810",
      !UF %in% sul_sudeste & VDI5008 > 810 ~ "Acima de 810"
    ),
    regiao = case_when(
      UF %in% c("Acre", "Amapá", "Amazonas", "Pará", "Rondônia", "Roraima", "Tocantins") ~ 1, # Norte
      UF %in% c("Alagoas", "Bahia", "Ceará", "Maranhão", "Paraíba", "Pernambuco", "Piauí", "Rio Grande do Norte", "Sergipe") ~ 2, # Nordeste
      UF %in% c("Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo") ~ 3, # Sudeste
      UF %in% c("Paraná", "Rio Grande do Sul", "Santa Catarina") ~ 4, # Sul
      UF %in% c("Distrito Federal", "Goiás", "Mato Grosso", "Mato Grosso do Sul") ~ 5
    ),
    tipo_area = ifelse(V1022 == 'Urbana', 1, 2),
    sexo = case_when(V2007 == 'Sem informação' ~ 0, V2007 == 'Homem' ~ 1, V2007 == 'Mulher' ~ 2),
    cor_raca = case_when(
      V2010 == 'Preta' ~ 1,
      V2010 == 'Branca' ~ 2,
      V2010 %in% c('Amarela','Parda','Indígena','Ignorado') ~ 3
    ),
    presenca_18 = ifelse(V2009 > 18, 0, 1),  # ver observação acima
    setor_ocup = ifelse(!V40132A %in% c('Outra atividade', NA), 0, 1),
    inseg_grave = ifelse(SD17001 == 'Insegurança alimentar grave', 1, 0),
    SD17001=SD17001)

#saveRDS(data_pnad, 'Dados da PNAD 2023.rds')

# ============================================================================
# 3. Dados CadÚnico para classificação ----------------------------------------
# ============================================================================

# (BASE DE DADOS DO CADÚNICO NÃO PODEM SER DISPONIBILIZADAS)
# Leitura do CadÚnico e correção de bairros com erro
cadunico <- read_delim('tudo.csv', delim = ';')
bairro_erro <- readxl::read_xlsx('Bairros-erro.xlsx')
colnames(bairro_erro)[1] <- ' d.nom_localidade_fam'  # mantém espaço à esquerda (cuidado)
cadunico <- left_join(cadunico, bairro_erro, by = ' d.nom_localidade_fam')

# Seleção de variáveis de interesse e filtros ---------------------------------
# Obs.: muitos nomes têm espaços e prefixos como ' d.' e ' p.'; evite isso se possível
cadunico2 <- cadunico[c(
  ' d.cod_familiar_fam', 'BAIRROS', ' d.vlr_renda_media_fam', ' d.cod_local_domic_fam',
  ' p.cod_sexo_pessoa', ' p.cod_raca_cor_pessoa', ' p.fx_idade', ' p.cod_agricultura_trab_memb',' d.ind_risco_scl_inseg_alim')] %>%
  filter(` d.vlr_renda_media_fam` < 1518) %>%         # filtro de renda (arbitrário; documente)
  mutate(regiao = 2) %>%                               # força Nordeste = 2 (porque Recife)
  mutate(
    faixa_renda = case_when(
      is.na(` d.vlr_renda_media_fam`) ~ "Sem renda",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` <= 100 ~ "De 1 a 100",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 100 & ` d.vlr_renda_media_fam` <= 200 ~ "De 100 a 200",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 200 & ` d.vlr_renda_media_fam` <= 240 ~ "De 200 a 240",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 240 & ` d.vlr_renda_media_fam` <= 290 ~ "De 240 a 290",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 290 & ` d.vlr_renda_media_fam` <= 330 ~ "De 290 a 330",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 330 & ` d.vlr_renda_media_fam` <= 380 ~ "De 330 a 380",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 380 & ` d.vlr_renda_media_fam` <= 600 ~ "De 380 a 600",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 600 & ` d.vlr_renda_media_fam` <= 650 ~ "De 600 a 650",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 650 & ` d.vlr_renda_media_fam` <= 810 ~ "De 650 a 810",
      !regiao %in% sul_sudeste & ` d.vlr_renda_media_fam` > 810 ~ "Acima de 810"
    ),
    tipo_area = ` d.cod_local_domic_fam`,
    sexo = ` p.cod_sexo_pessoa`,
    cor_raca = case_when(
      ` p.cod_raca_cor_pessoa` == 2 ~ 1,  # mapeamento específico do seu layout
      ` p.cod_raca_cor_pessoa` == 1 ~ 2,
      ` p.cod_raca_cor_pessoa` %in% c(3,4,5,NA) ~ 3
    ),
    presenca_18 = ifelse(` p.fx_idade` %in% c(0:3), 1, 0),  # faixas etárias 0..3 ≈ presença de menores
    setor_ocup = ` p.cod_agricultura_trab_memb`, 
  )

# Trata NAs nas variáveis categóricas (evita NAs em predição)
cadunico2$tipo_area[is.na(cadunico2$tipo_area)] <- 1
cadunico2$setor_ocup[is.na(cadunico2$setor_ocup)] <- 2

#writexl::write_xlsx(cadunico2, 'cadunico2.xlsx')