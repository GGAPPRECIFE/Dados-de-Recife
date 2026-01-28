# 🌳 Censo Arbóreo do Recife (2023)

![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen)
![Data](https://img.shields.io/badge/Dataset-259.575_Registros-blue)
![Local](https://img.shields.io/badge/Cidade-Recife-red)

Repositório dedicado ao armazenamento, tratamento e visualização dos dados do Censo Arbóreo realizado na cidade do Recife em 2023. Esta base de dados é fundamental para a gestão ambiental e o planejamento urbano da cidade. Os dados possuem a relação de árvores existentes, por bairro e por setor censitário e com geolocalização.

---

## 📍 Mapa Interativo de Arborização

O projeto utiliza a biblioteca **Leaflet** no R para mapear cada uma das árvores registradas, permitindo a visualização por bairros e zonas de planejamento (RPA).

> [!IMPORTANTE]
> Devido ao grande volume de dados (quase 260 mil pontos), utilizamos renderização via **WebGL (leafgl)** para garantir que a navegação seja fluida no navegador.

**[🔗 Clique aqui para acessar o Mapa em Tela Cheia](https://censo-arboreo.netlify.app/)**

O mapa apresenta a localização das árvores nos setores e possui *pop-ups* com informações sobre o bairro, setor, número de árvores, população e o número de árvores por pessoa dos setores e dos bairros.
---

## 📊 Estrutura dos Dados

A base de dados conta com **259.575 feições** e inclui informações detalhadas sobre cada indivíduo arbóreo:

| Coluna | Descrição |
| :--- | :--- |
| `NM_BAIRRO` | Nome do bairro onde a árvore está localizada. |
| `CD_BAIRRO` | Código do bairro onde a árvore está localizada. |
| `nome_popul` | Identificação da espécie pelo nome popular. |
| `altura` | Altura aproximada do indivíduo (em metros). |
| `porte_esp` | Classificação do porte da espécie. |
| `arvores_por_pessoa` | Árvores por pessoa no setor censitário. |
| `arvores_por_pessoa_bairro` | Árvores por pessoa no Bairro. |
| `geometry` | Coordenadas geográficas em WGS84. |

---

## 🛠️ Tecnologias e Metodologia

Para a análise e visualização deste projeto, foram utilizadas as seguintes ferramentas no ambiente R:

* **Tidyverse**: Para limpeza e manipulação dos dados.
* **SF (Simple Features)**: Para o tratamento de dados geoespaciais.
* **Leaflet + Leafgl**: Para a criação de mapas interativos de alta performance com labels dinâmicos.
* **Htmlwidgets**: Para exportação do mapa em formato HTML autossuficiente.

---

## 📂 Como utilizar este repositório

1. **Dados Brutos:** Localizados na pasta `/data`.
2. **Scripts R:** Localizados em `/scripts`, contendo o código para gerar o mapa com delimitação de bairros.
3. **Mapa Final:** O arquivo `mapa_arborizacao_recife.html` pode ser baixado e aberto em qualquer navegador.

---

<p align="center">
<b>Desenvolvido como parte do Data Hub Recife</b><br>
Secretaria de Planejamento, Gestão e Transformação Digital
</p>
