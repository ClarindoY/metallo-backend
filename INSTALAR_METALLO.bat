@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Instalador METALLO IA
echo ============================================================
echo   INSTALADOR - METALLO IA (Gerador de Pecas)
echo ============================================================
echo.

REM ---------- 1) Python ----------
where python >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Python nao encontrado neste computador.
  echo.
  echo  1. Baixe o Python 3.12 em:  https://www.python.org/downloads/
  echo  2. Na instalacao, MARQUE a opcao "Add python.exe to PATH".
  echo  3. Rode este instalador de novo.
  echo.
  pause
  exit /b 1
)

REM ---------- 2) Ambiente + dependencias ----------
echo Instalando o METALLO IA (a primeira vez demora alguns minutos)...
echo.
if not exist ".venv\Scripts\activate.bat" python -m venv .venv
call ".venv\Scripts\activate"
python -m pip install --upgrade pip -q
pip install -r requirements.txt
if errorlevel 1 (
  echo.
  echo [ERRO] Falha ao instalar as dependencias. Verifique a internet e rode de novo.
  pause
  exit /b 1
)

REM ---------- 3) Atalho na Area de Trabalho ----------
echo.
echo Criando o atalho "METALLO IA" na Area de Trabalho...
powershell -NoProfile -Command ^
 "$d=[Environment]::GetFolderPath('Desktop');" ^
 "$s=(New-Object -ComObject WScript.Shell).CreateShortcut(\"$d\METALLO IA.lnk\");" ^
 "$s.TargetPath='%~dp0iniciar.bat';" ^
 "$s.WorkingDirectory='%~dp0';" ^
 "$s.IconLocation='%~dp0metallo_cad\assets\metallo.ico';" ^
 "$s.Description='METALLO IA - Gerador de Pecas';" ^
 "$s.WindowStyle=7;" ^
 "$s.Save()"

echo.
echo ============================================================
echo   PRONTO!  O icone "METALLO IA" esta na Area de Trabalho.
echo   Duplo clique nele para abrir o sistema.
echo ============================================================
echo.
pause
