# 🌿 Áreas Verdes Urbanas do Recife (greenR)

Este repositório apresenta **dados, scripts e análises das áreas verdes urbanas do município do Recife**, extraídas por meio do **pacote `greenR` (R)**, que permite a identificação, quantificação e análise espacial da cobertura vegetal em ambientes urbanos a partir de dados geoespaciais.

O objetivo principal é **mapear, mensurar e analisar a distribuição das áreas verdes**, fornecendo subsídios técnicos para estudos ambientais, planejamento urbano e formulação de políticas públicas. As áreas verdes dozem respeito a parques, praças, Academias da cidade, clubes, Jardins, Quadras ou instituições que possuam áreas verdes em suas delimitações. Diversos trabalhos acadêmicos analisam a importância de áreas verdes para a qualidade de vida urbana

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
