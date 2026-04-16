# 📊 Dados de Arboviroses — Recife (PE)

Este repositório reúne dados relacionados às arboviroses **dengue**, **zika** e **chikungunya** no município de Recife (Pernambuco, Brasil), com o objetivo de apoiar análises epidemiológicas, estudos acadêmicos e tomada de decisão em saúde pública.

---

## 📌 Descrição

As arboviroses são doenças transmitidas principalmente pelo mosquito *Aedes aegypti* e representam um importante desafio de saúde pública em regiões tropicais.

Este conjunto de dados contempla informações sobre:
- Casos notificados
- Casos confirmados
- Incidência
- Distribuição temporal (semanal, mensal ou anual)
- Distribuição espacial (quando disponível)

---

## 🗂️ Estrutura dos Dados

Os dados estão organizados em arquivos no formato `.xlsx` (ou similar), contendo as seguintes variáveis principais:

| Variável              | Descrição |
|----------------------|----------|
| `ano`                | Ano de notificação |
| `semana` / `mes`     | Unidade temporal |
| `doenca`             | Dengue, Zika ou Chikungunya |
| `casos_notificados`  | Número de casos reportados |
| `casos_confirmados`  | Número de casos confirmados |
| `bairro` (opcional)  | Localização espacial |
| `latitude` / `longitude` (opcional) | Coordenadas geográficas |

---

## 🌍 Cobertura Geográfica

- Município: Recife (Bairros e setores censitários)

**[🔗 Casos de dengue em 2024 por bairros](https://incandescent-pony-df4592.netlify.app/)**
---

## 📅 Período de Cobertura

> Definir conforme a base de dados (ex: 2010 – 2025)

---

## 📥 Fonte dos Dados

Os dados podem ter sido obtidos a partir de fontes oficiais, como:

- Secretaria de Saúde de Recife (Dados Abertos)
---

## 🔧 Tratamento dos Dados

Possíveis etapas realizadas no processamento:

- Limpeza de dados inconsistentes  
- Padronização de nomes de variáveis  
- Conversão de datas  
- Geocodificação de endereços  
- Agregações temporais e espaciais  

---

## 📈 Possíveis Aplicações

- Análise de séries temporais  
- Modelagem epidemiológica  
- Identificação de surtos  
- Análise espacial (mapas de risco)  
- Avaliação de políticas públicas  

---

## ⚠️ Limitações

- Possível subnotificação de casos  
- Atrasos na atualização dos dados  
- Mudanças nos critérios de confirmação ao longo do tempo  
- Lacunas em variáveis específicas  

---

## 📜 Licença

Definir a licença de uso dos dados. Exemplos:

