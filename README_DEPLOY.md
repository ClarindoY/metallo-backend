# METALLO IA — publicar online (3 passos, sem comandos)

## 1. Subir os arquivos no GitHub (pelo navegador)
1. Crie conta em github.com (gratis) e clique em **New repository** -> nome: `metallo-ia` -> **Private** -> Create.
2. Na pagina do repositorio, clique em **uploading an existing file**.
3. ARRASTE todo o CONTEUDO desta pasta kit (app.py, metallo_cad, requirements.txt, render.yaml e a pasta .streamlit) para a janela e clique **Commit changes**.
   - Obs.: se a pasta .streamlit nao aparecer para arrastar (oculta), use o botao "Add file -> Upload files" e selecione-a.

## 2. Publicar no Render
1. Crie conta em render.com (gratis) usando **Sign in with GitHub**.
2. Clique **New + -> Blueprint**, escolha o repositorio `metallo-ia` e clique **Apply**.
   - O arquivo render.yaml configura tudo sozinho (build, start, porta).
3. Aguarde o primeiro deploy (~5 min). A URL aparece no topo: algo como
   `https://metallo-ia.onrender.com` — pronto, online.

## 3. Atualizacoes (quando eu te mandar um kit novo)
1. No GitHub: **Add file -> Upload files**, arraste os arquivos novos por cima e Commit.
2. No Render: **Manual Deploy -> Clear build cache & deploy**.

## Avisos
- Plano free: o app "dorme" apos ~15 min sem uso (primeiro acesso demora ~1 min) e o
  disco e apagado a cada deploy — as bibliotecas (Minhas bancadas / Meus ralos) sao
  temporarias. Para persistir: plano pago + Persistent Disk + variavel DATA_DIR
  apontando para o disco (o app ja le DATA_DIR).
- Nao suba a pasta `dados/` nem `__pycache__/`.
