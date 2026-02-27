# 📊 Estimativas da População dos Bairros do Recife

Este repositório apresenta **métodos de estimativa da população dos bairros do município do Recife**, com base em dados oficiais do **IBGE** e em técnicas demográficas e territoriais amplamente utilizadas em planejamento urbano.

O projeto tem como objetivo produzir **estimativas populacionais anuais em escala intraurbana**, suprindo a ausência de dados censitários anuais para bairros e apoiando análises demográficas, socioeconômicas e de políticas públicas.x

O link com as motodologias podem ser acessados [aqui](https://estimativa-pop-bairros-recife.netlify.app/).

---

## 🎯 Objetivo

- Estimar a população anual dos bairros do Recife  
- Comparar diferentes métodos de projeção intraurbana  
- Avaliar consistência e sensibilidade das estimativas  
- Disponibilizar bases e scripts reprodutíveis  

---

## 📍 Área de Estudo

- **Município:** Recife – PE  
- **Unidade espacial:** Bairros  
- **Período de análise:** Pós-Censo 2010 até o período mais recente de estimativas do IBGE  

---

## 🧮 Métodos de Estimativa Populacional

Foram utilizados quatro métodos principais de estimativa da população dos bairros:

---

### 1️⃣ Evolução Equivalente

O método de **Evolução Equivalente** assume que os bairros acompanham a **mesma taxa de variação observada nas estimativas populacionais do município**, produzidas anualmente pelo IBGE.

**Descrição:**
- Calcula-se a taxa de crescimento anual do município
- Aplica-se essa taxa à população inicial de cada bairro
- Garante coerência com o total municipal

**Vantagem:**  
Mantém compatibilidade direta com as estimativas oficiais do IBGE.

---

### 2️⃣ Proporção Fixa

O método de **Proporção Fixa** considera que a participação relativa de cada bairro na população total do município permanece constante ao longo do tempo.

**Descrição:**
- Calcula-se o percentual da população de cada bairro no ano-base
- Multiplica-se esse percentual pela população total estimada do município em cada ano

**Vantagem:**  
Simplicidade e fácil interpretação.

**Limitação:**  
Não capta dinâmicas diferenciais de crescimento entre bairros.

---

### 3️⃣ Taxa Anual

O método de **Taxa Anual** utiliza a taxa de crescimento específica de cada bairro, calculada a partir da razão entre a população observada no **Censo 2022** e no **Censo 2010**.

**Descrição:**
- Calcula-se a taxa média anual de crescimento do bairro
- Aplica-se essa taxa de forma cumulativa aos anos subsequentes

**Vantagem:**  
Capta dinâmicas próprias de crescimento intraurbano.

**Limitação:**  
Sensível a variações pontuais entre os dois censos.

---

### 4️⃣ Método Shift-Share

O método **Shift-Share** decompõe a variação populacional dos bairros em componentes:

- **Componente estrutural (municipal):** crescimento associado à dinâmica do município
- **Componente diferencial:** crescimento específico do bairro

**Descrição:**
- Parte do crescimento municipal
- Identifica ganhos ou perdas relativas de cada bairro
- Permite análise comparativa intraurbana

**Vantagem:**  
Permite identificar bairros que crescem acima ou abaixo da média municipal.

---
## 📊 Produtos Gerados

- Estimativas anuais da população por bairro  
- Séries temporais comparáveis entre métodos  
- Tabelas e indicadores demográficos  
- Mapas temáticos de distribuição populacional  

---

## 🛠️ Tecnologias Utilizadas

- **R** (tidyverse, sf, data.table, ggplot2, leaflet)  
- **Git/GitHub** para versionamento  
- **Markdown / RMarkdown** para documentação  

---

## ⚠️ Observações Metodológicas

- As estimativas não substituem dados censitários oficiais
- Métodos assumem hipóteses simplificadoras sobre crescimento populacional
- Recomenda-se comparar os resultados entre métodos
- A escolha do método deve considerar o objetivo da análise

---

## 📚 Fontes de Dados

- IBGE — Censos Demográficos 2010 e 2022  
- IBGE — Estimativas Populacionais Municipais  
- Malhas territoriais oficiais do IBGE  

---

## 📌 Considerações Finais

A produção de estimativas populacionais intraurbanas é fundamental para o planejamento urbano e a formulação de políticas públicas. Ao comparar diferentes métodos, este projeto busca oferecer **transparência metodológica**, **robustez analítica** e **subsídios técnicos** para o uso responsável das estimativas populacionais dos bairros do Recife.

Contribuições são bem-vindas por meio de *issues* ou *pull requests*.

