@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ============================================================
echo   Instalacao - Gerador de Pecas Metallo
echo ============================================================
echo.
where python >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Python nao encontrado.
  echo Instale o Python 3.11 ou 3.12 em https://www.python.org/downloads/
  echo Marque a opcao "Add python.exe to PATH" durante a instalacao.
  pause
  exit /b 1
)
echo Criando ambiente (.venv) e instalando dependencias...
echo (a primeira vez pode demorar alguns minutos - o motor de CAD e grande)
echo.
python -m venv .venv
call ".venv\Scripts\activate"
python -m pip install --upgrade pip
pip install -r requirements.txt
echo.
echo ============================================================
echo   Instalacao concluida!  Agora rode o "iniciar.bat".
echo ============================================================
pause
