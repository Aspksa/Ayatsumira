@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul
cd /d "%~dp0"
set "AYATSUMIRA_ROOT=%CD%"
set "HERMES_HOME=%AYATSUMIRA_ROOT%\data\hermes"
set "HERMES_WEBUI_STATE_DIR=%AYATSUMIRA_ROOT%\data\webui"
set "HERMES_WEBUI_HOST=127.0.0.1"
set "HERMES_WEBUI_PORT=8789"
if not exist "%AYATSUMIRA_ROOT%\runtime\python\python.exe" (
  echo [Ayatsumira] Portable Python not installed: runtime\python\python.exe
  echo See docs\INTEGRATION.md. No system changes were made.
  exit /b 2
)
if not exist "%AYATSUMIRA_ROOT%\app\hermes-webui\server.py" (
  echo [Ayatsumira] Hermes WebUI sources not installed: app\hermes-webui
  echo See docs\INTEGRATION.md. No system changes were made.
  exit /b 3
)
if not exist "%HERMES_HOME%" mkdir "%HERMES_HOME%"
if not exist "%HERMES_WEBUI_STATE_DIR%" mkdir "%HERMES_WEBUI_STATE_DIR%"
"%AYATSUMIRA_ROOT%\runtime\python\python.exe" "%AYATSUMIRA_ROOT%\app\hermes-webui\server.py"
exit /b %errorlevel%
