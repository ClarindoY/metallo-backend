#!/usr/bin/env bash
cd "$(dirname "$0")"
if [ ! -d ".venv" ]; then
  echo "Primeiro uso: instalando dependencias..."
  python3 -m venv .venv
  # shellcheck disable=SC1091
  source .venv/bin/activate
  python -m pip install --upgrade pip
  pip install -r requirements.txt
else
  # shellcheck disable=SC1091
  source .venv/bin/activate
fi
python link.py
echo
echo " Para PARAR: pressione Ctrl+C"
echo
streamlit run app.py
