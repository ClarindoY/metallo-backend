#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
echo "============================================================"
echo "  Instalacao - Gerador de Pecas Metallo"
echo "============================================================"
if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERRO] python3 nao encontrado. Instale o Python 3.11/3.12."
  exit 1
fi
python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
echo
echo "Instalacao concluida. Rode:  ./iniciar.sh"
