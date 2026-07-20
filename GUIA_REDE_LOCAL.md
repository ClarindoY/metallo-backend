# Guia — rodar o Gerador de Peças na rede da empresa

Objetivo: deixar o app rodando num PC da fábrica e acessar de qualquer máquina
da rede pelo navegador, por um endereço tipo `http://192.168.0.50:8501`.

> Escolha **um PC** para ser o "servidor" (pode ser um PC comum que fica ligado).
> Só ele precisa instalar; os outros só usam o navegador.

---

## Passo 1 — Instalar (só uma vez, no PC servidor)

1. Instale o **Python 3.11 ou 3.12**: https://www.python.org/downloads/
   - **Importante (Windows):** na tela de instalação marque **“Add python.exe to PATH”**.
2. Descompacte esta pasta do projeto num lugar fixo (ex.: `C:\MetalloGerador`).
3. **Windows:** dê duplo clique em **`instalar.bat`** e aguarde terminar.
   **Linux/Mac:** rode `bash instalar.sh`.
   - A primeira instalação baixa o motor de CAD (CadQuery/OCP) e pode levar alguns minutos.

## Passo 2 — Iniciar o app

- **Windows:** duplo clique em **`iniciar.bat`**.
- **Linux/Mac:** `bash iniciar.sh`.

Vai aparecer algo assim na tela:
```
  Neste PC:        http://localhost:8501
  Na rede local:   http://192.168.0.50:8501   <-- este é o link para a equipe
```
Deixe essa janela aberta (ela é o servidor). Para parar, feche a janela ou Ctrl+C.

## Passo 3 — Acessar de outro PC da empresa

Em qualquer computador na **mesma rede**, abra o navegador e digite o
**link “na rede local”** (ex.: `http://192.168.0.50:8501`). Pronto.

---

## Liberar no Firewall (Windows)

Na primeira vez que iniciar, o Windows pode perguntar se permite o acesso —
clique em **“Permitir acesso”** (marque **Redes privadas**).
Se a equipe não conseguir abrir o link, libere a porta manualmente:

1. Abra “Firewall do Windows Defender com Segurança Avançada”.
2. **Regras de Entrada → Nova Regra → Porta → TCP → 8501 → Permitir a conexão**.
3. Aplique para o perfil **Privado** e dê um nome (ex.: “Gerador Metallo”).

## Deixar o link fixo (recomendado)

Para o endereço não mudar quando o PC reiniciar:
- Configure **IP fixo** no PC servidor, **ou**
- No roteador, faça uma **reserva de DHCP** (fixa o IP pelo MAC do PC).

## Iniciar junto com o Windows (opcional)

Para o servidor subir sozinho quando ligar o PC:
1. Tecle `Win + R`, digite `shell:startup` e Enter.
2. Crie um **atalho** do `iniciar.bat` dentro dessa pasta.
(Ou use o **Agendador de Tarefas** com gatilho “Ao iniciar o computador”.)

## Acessar de FORA da empresa (opcional)

Por padrão o app só funciona dentro da rede (mais seguro). Se um dia precisar
acessar de fora, a forma simples é um **túnel** com o `cloudflared`
(Cloudflare Tunnel) apontando para `localhost:8501`, que gera um link público.
Posso te passar esse passo a passo quando precisar.

---

## Problemas comuns

- **“streamlit não é reconhecido”** → rode pelo `iniciar.bat` (ele ativa o ambiente).
- **Equipe não abre o link** → 99% das vezes é o **Firewall** (veja acima) ou o PC
  servidor está em outra rede/Wi-Fi diferente.
- **O link mudou** → o IP do PC mudou; configure IP fixo / reserva de DHCP.
- **Instalação travou** → confirme que o Python foi instalado com “Add to PATH”
  e rode o `instalar.bat` de novo.
