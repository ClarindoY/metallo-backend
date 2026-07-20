# Metallo • Gerador de Peças (kit base)

Gerador paramétrico de peças para a Metallo / Concetto. Você preenche as medidas
numa interface web e recebe um `.zip` com **IGES + STEP + desenho técnico em PDF**
(e, no caso da mesa, os **tubos mitrados individuais** para o laser de tubo / TubeKit).

Peças incluídas:
- **Tubo redondo** (seção circular) por **bitola de 1/2" a 10"** (OD = polegada × 25,4 mm, ajustável), com parede, comprimento e furos radiais opcionais (passante ou em 1 parede)
- **Flanges em DXF** (quadrado / redondo / retangular): tamanho externo, furo central opcional, furos de parafuso (quantidade, formato redondo/oblongo/quadrado, distância da borda, tamanho), compensação de corte e espessura. Biblioteca de até 10 modelos + **nesting** numa chapa só (1 DXF)
- **Tubo retangular com furos** (furo redondo ou **sextavado** com chave 8/10/12/15 ou personalizada; orientação face/vértice; **escolha do par de faces**: topo/fundo (largura W) e/ou **laterais** (altura T), com posições independentes e opção **passante** em cada par; **raio de canto**; **compensação de furo** em mm)
- **Torre sextavada** (tubo com furo hexagonal; mesmas opções)
- **Mesa em metalon** (estrutura com meia esquadria 45°; raio de canto)
- **Chapa — polígono em L** (recorte no canto + furos, com compensação) → gera **DXF de corte**
- **Chapa — hexágono** (escudo, chanfros 45°) → gera **DXF de corte**

Aba **Corte angular (em lote)**: gerador rápido para tubos com corte angular nas pontas (ângulo 90° = reto; menor = chanfro), 1 ou 2 pontas, plano/lado do corte, quantidade — adiciona vários à lista e gera todos num único .zip (1 PDF único multipágina, uma peça por página + IGES/STEP por peça + lista de corte).

Aba **Mesas**: gerador rápido de mesas em metalon com modelos prontos (jantar, centro, aparador, bancada, banqueta) + medidas livres; gera a estrutura montada e os tubos mitrados (meia-esquadria 45°) para o laser. Inclui seletor de **modelo de base**: **estrutura metalon (4 pernas)** ou **pés laterais em C (cantilever)** — este com tampo, travessa opcional e pés espelháveis.

As peças de tubo/mesa saem em **IGES + STEP + PDF**; as de chapa em **DXF + STEP + IGES + PDF**.

Aba **⏱ Tempo de corte (laser 3000 W)**: estima o tempo de corte a laser de fibra a partir
de uma tabela de parâmetros (material × espessura → velocidade, gás, bico, foco). Toda peça
gerada já mostra a estimativa; nessa aba você pode **importar um DXF** (calcula comprimento de
corte, nº de perfurações, peso e tempo), fazer um **cálculo manual**, consultar a **tabela**
e informar o **custo de máquina (R$/min)** para estimar o custo do corte.

Aba **🏷️ Gerar etiqueta**: gera os adesivos de peça em PDF (1 por página, tamanho físico
60×40 mm, 150×50 mm ou personalizado) com descrição/medida, material, data, OP e cliente
(opcional). Monte a lista de peças da ordem e o arquivo sai com a quantidade de adesivos por peça.

Aba **📋 Ordens de produção**: o funcionário faz **login**, anexa a folha da semana
(.csv, .xlsx **ou foto .jpg/.png**), define a **meta** e acompanha a evolução num **termômetro**.
Registra a produção por dia (com observações) e gera **relatório do dia/semana** em PDF; os
relatórios ficam **salvos por 1 ano**.

> **Persistência (importante):** os dados de produção (logins, ordens, apontamentos e relatórios)
> ficam num banco **SQLite** em `DATA_DIR` (variável de ambiente) ou na pasta `./dados`.
> No Render, **monte um disco persistente** e aponte `DATA_DIR` para ele — caso contrário o banco
> é apagado a cada novo deploy/reinício. As senhas são guardadas com hash (PBKDF2), nunca em texto puro.
> O funcionário **continua logado após recarregar a página** (token de sessão na URL, validade 30 dias).

---

## ⚡ Modo rápido (rede da empresa)

Para rodar num PC e acessar de qualquer máquina da rede:

- **Windows:** duplo clique em **`instalar.bat`** (1ª vez) e depois em **`iniciar.bat`**.
- **Linux/Mac:** `bash instalar.sh` e depois `bash iniciar.sh`.

Ao iniciar, aparece o link **“na rede local”** (ex.: `http://192.168.0.50:8501`) —
é esse que você compartilha com a equipe. Passo a passo completo (firewall, IP fixo,
iniciar com o Windows) em **`GUIA_REDE_LOCAL.md`**.

> Os passos manuais abaixo são uma alternativa caso prefira rodar pela linha de comando.

---

## 1. Instalação (uma vez, em qualquer PC da empresa)

Pré-requisito: **Python 3.10 ou 3.11** instalado (https://www.python.org/downloads/).

```bash
# dentro da pasta do projeto
python -m venv .venv

# Windows:
.venv\Scripts\activate
# Linux/Mac:
source .venv/bin/activate

pip install -r requirements.txt
```

> Observação: a primeira instalação do `cadquery` baixa o motor de CAD (OCP) e
> pode demorar alguns minutos.

## 2. Rodar a interface

```bash
streamlit run app.py
```

Abre no navegador (normalmente em `http://localhost:8501`). Para outros PCs da
rede acessarem, rode com:

```bash
streamlit run app.py --server.address 0.0.0.0
```

e acesse `http://IP-DO-PC:8501` nas outras máquinas.

## 3. Usar

1. Escolha a **família** na barra lateral.
2. Preencha as **medidas**.
3. Clique em **GERAR**.
4. Confira massa / lista de corte e baixe o **.zip**.

---

## 4. Estrutura do projeto

```
app.py                     # interface Streamlit
requirements.txt
metallo_cad/
  __init__.py
  config.py                # densidade, logo, dados do carimbo
  parts.py                 # construtores paramétricos (a "engenharia")
  laser.py                 # tabela 3000 W + cálculo de tempo de corte / peso
  etiquetas.py             # adesivos/etiquetas de peça em PDF (60×40, 150×50, custom)
  producao.py              # login, banco SQLite, termômetro de meta e relatórios
  exporters.py             # IGES / STEP
  drawing.py               # desenho técnico em PDF (carimbo Metallo)
  assets/logo.jpeg
```

## 5. Como adicionar uma nova peça

1. Em `metallo_cad/parts.py`, crie uma função que monte o sólido com **CadQuery**
   e devolva um `Result` (veja os exemplos). Defina `kind="tubo"` ou `"mesa"`,
   `dims`, `mass`, `cut_list` e, se houver, `feats`/`parts`.
2. Em `app.py`, adicione o nome na lista do `selectbox` e um bloco com os campos
   e a chamada da sua função.
3. (Opcional) Se o desenho padrão não servir, crie uma função em
   `metallo_cad/drawing.py` e trate-a em `draw()`.

O motor de geometria já resolve o trabalho pesado — peça nova costuma ser só uma
função nova.

## 6. Ideias de evolução (v2/v3)

- Validações de fabricação (folga furo↔borda, paredes disponíveis, limites).
- Geração **em lote** a partir de uma planilha Excel/CSV.
- Saída automática para a **pasta da estação do laser** e nomenclatura padronizada.
- Integração com ERP / etiquetas / Mercado Livre.
