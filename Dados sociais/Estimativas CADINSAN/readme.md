# 🍽️ Estimação da População em Insegurança Alimentar Grave  
## 📍 Recife — PE | Metodologia CADINSAN

---

## 📖 Visão Geral

Este repositório reúne a documentação, organização analítica e resultados da estimação da população em **Insegurança Alimentar Grave (IAG)** no município do Recife.

A metodologia adotada baseia-se no **CADINSAN (Cadastro de Insegurança Alimentar e Nutricional)**, desenvolvido pelo Governo Federal, que utiliza **registros administrativos e variáveis socioeconômicas** para inferir níveis de vulnerabilidade alimentar.

O projeto tem como foco principal a **produção de evidências territorializadas**, permitindo análises em diferentes escalas espaciais e subsidiando políticas públicas mais eficientes.

---

## 🎯 Objetivos do Projeto

- 📊 Estimar o quantitativo de pessoas em situação de **insegurança alimentar grave**
- 📍 Identificar padrões espaciais e desigualdades intraurbanas
- 🧭 Apoiar o direcionamento de políticas públicas e ações emergenciais
- 📈 Produzir indicadores consistentes para monitoramento contínuo

---

## 🧠 Abordagem Metodológica

A metodologia CADINSAN permite estimar a insegurança alimentar de forma indireta, a partir de **proxies de vulnerabilidade socioeconômica**.

### 🔎 Principais dimensões consideradas:

- 💰 Renda domiciliar per capita  
- 🏠 Condições habitacionais  
- 🚰 Acesso a serviços básicos (água, esgoto, coleta de lixo)  
- 👨‍👩‍👧 Composição domiciliar  
- ⚡ Infraestrutura e bens essenciais  

### ⚠️ Definição de Insegurança Alimentar Grave

Caracteriza-se por situações de:

- Restrição severa no acesso a alimentos  
- Episódios recorrentes de fome  
- Comprometimento da quantidade e qualidade alimentar  

---

## 🗂️ Estrutura do Repositório
├── data/
│ ├── raw/ # Dados brutos (Cadastro Único, IBGE, etc.)
│ ├── processed/ # Bases tratadas e consolidadas
│
├── scripts/
│ ├── preparacao/ # Limpeza e padronização dos dados
│ ├── modelagem/ # Modelos estatísticos (proxy CADINSAN)
│ ├── estimacao/ # Cálculo dos indicadores
│ ├── espacial/ # Integração geográfica e mapas
│
├── outputs/
│ ├── tabelas/ # Resultados consolidados
│ ├── graficos/ # Visualizações analíticas
│ ├── mapas/ # Mapas temáticos
│
├── docs/
│ ├── metodologia/ # Notas técnicas e documentação detalhada
│
└── README.md


---

## 📊 Produtos Gerados

O projeto resulta em um conjunto estruturado de outputs analíticos:

- 📌 Estimativas absolutas da população em IAG  
- 📉 Proporção da população afetada (%)  
- 🗺️ Mapas temáticos por bairro, RPA e setores censitários  
- 📊 Tabelas analíticas para uso institucional  
- 📈 Séries e comparações (quando aplicável)  

---

## 🧩 Aplicações

Os resultados podem ser utilizados para:

- Planejamento de políticas de segurança alimentar  
- Identificação de áreas prioritárias  
- Monitoramento de programas sociais  
- Apoio a diagnósticos territoriais  
- Subsídio a estudos acadêmicos e institucionais  

---

## ⚠️ Limitações

Apesar da robustez metodológica, algumas limitações devem ser consideradas:

- Dependência da qualidade e atualização do Cadastro Único  
- Possível subcobertura de populações não cadastradas  
- Uso de proxies (não mede diretamente consumo alimentar)  
- Sensibilidade a mudanças nos critérios metodológicos  

---

## 🔐 Considerações sobre Dados

Este projeto pode envolver dados administrativos sensíveis. Recomenda-se:

- Garantir anonimização dos microdados  
- Respeitar a LGPD e normas institucionais  
- Utilizar dados agregados sempre que possível  

---

## 📚 Referências

- Ministério do Desenvolvimento e Assistência Social  
- Metodologia CADINSAN  
- IBGE — Censo Demográfico  
- IBGE — PNAD Contínua  
- FAO — Food Security Indicators  

---

## 🤝 Contribuições

Contribuições são bem-vindas para aprimoramento metodológico e analítico.

**Fluxo sugerido:**
1. Fork do repositório  
2. Criação de branch (`feature/nome-da-feature`)  
3. Commit das alterações  
4. Abertura de Pull Request  

---

## 📬 Contato

Para dúvidas, sugestões ou parcerias institucionais, entre em contato com a equipe responsável pelo projeto.

---

## 🏷️ Palavras-chave

`segurança alimentar` `CADINSAN` `Cadastro Único` `Recife` `políticas públicas` `análise espacial` `vulnerabilidade social`
