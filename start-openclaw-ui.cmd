@echo off
setlocal enableextensions

REM OpenClaw + Tailscale Serve (HTTPS) one-click launcher
REM - Keeps OpenClaw Gateway on localhost (gateway.bind=auto)
REM - Exposes Control UI to tailnet via Tailscale Serve (HTTPS)
REM - Opens the HTTPS URL in your default browser

set "OPENCLAW_URL=https://desktop-6b46las.tail1a4556.ts.net/"
set "OPENCLAW_LOCAL=http://127.0.0.1:18789"
set "OPENCLAW_PORT=18789"

REM --- Elevate to admin (needed sometimes for service restart / tailscale serve) ---
net session >nul 2>&1
if %errorlevel% neq 0 (
  powershell -NoProfile -Command "Start-Process '%~f0' -Verb RunAs"
  exit /b
)

echo [1/5] Ensuring OpenClaw Gateway bind=auto (localhost)...
openclaw config set gateway.bind auto

echo [2/5] Restarting OpenClaw Gateway...
openclaw gateway restart

echo [3/5] Configuring Tailscale Serve (HTTPS -> %OPENCLAW_LOCAL%)...
tailscale serve reset
tailscale serve --bg %OPENCLAW_LOCAL%
tailscale serve status

echo [4/5] Opening Control UI (tailnet HTTPS)...
start "OpenClaw Control" %OPENCLAW_URL%

echo [5/5] Done.
echo If you see token missing: run `openclaw dashboard --no-open` and append #token=... to the URL.
echo If you see pairing required: run `openclaw devices list` then `openclaw devices approve ^<requestId^>`.
echo.
pause
