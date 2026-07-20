@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Atalho METALLO IA Online
echo ============================================================
echo   Atalho para o METALLO IA ONLINE (Render) - sem instalar nada
echo ============================================================
echo.
set "URL="
if exist url_online.txt set /p URL=<url_online.txt
if "%URL%"=="" (
  echo Cole a URL do sistema no Render (ex.: https://metallo-ia.onrender.com)
  set /p URL=URL: 
)
if "%URL%"=="" (
  echo [ERRO] Nenhuma URL informada.
  pause
  exit /b 1
)
echo %URL%> url_online.txt
powershell -NoProfile -Command ^
 "$d=[Environment]::GetFolderPath('Desktop');" ^
 "$w=(New-Object -ComObject WScript.Shell).CreateShortcut(\"$d\METALLO IA Online.url\");" ^
 "$w.TargetPath='%URL%';" ^
 "$w.Save();" ^
 "Add-Content -Path \"$d\METALLO IA Online.url\" -Value 'IconFile=%~dp0metallo_cad\assets\metallo.ico';" ^
 "Add-Content -Path \"$d\METALLO IA Online.url\" -Value 'IconIndex=0'"
echo.
echo   PRONTO! Atalho "METALLO IA Online" criado na Area de Trabalho.
echo.
pause
