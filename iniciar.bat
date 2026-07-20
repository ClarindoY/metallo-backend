@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Gerador de Pecas Metallo

REM cria o ambiente automaticamente se ainda nao existir
if not exist ".venv\Scripts\activate.bat" (
  echo Primeiro uso: instalando dependencias...
  python -m venv .venv
  call ".venv\Scripts\activate"
  python -m pip install --upgrade pip
  pip install -r requirements.txt
) else (
  call ".venv\Scripts\activate"
)

python link.py
echo.
echo  Para PARAR o servidor: feche esta janela ou pressione Ctrl+C
echo.
start "" http://localhost:8501
streamlit run app.py --server.headless true
pause
