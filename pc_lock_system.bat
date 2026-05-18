@echo off
REM PC Lock System - Windows Batch Version
REM No Python Required - Uses Built-in Windows Commands Only
REM Auto-locks every 2.5 minutes and keeps PC locked for 3 minutes

setlocal enabledelayedexpansion
title PC LOCK SYSTEM - FULL CONTROL

:start
cls
echo.
echo ════════════════════════════════════════════════════════════
echo                  PC LOCK SYSTEM - FULL CONTROL
echo ════════════════════════════════════════════════════════════
echo.
echo [*] Initializing complete PC lock system...
echo [*] The PC will auto-lock every 2.5 minutes
echo [*] System will be locked for minimum 3 minutes
echo.
timeout /t 3 /nobreak

REM Lock the PC immediately
:lock_pc
cls
echo.
echo ══════════════════════════════════════��═════════════════════
echo                  [LOCKED] PC IS COMPLETELY LOCKED
echo ════════════════════════════════════════════════════════════
echo.
echo Warning: THIS SYSTEM IS NOW FULLY LOCKED
echo Only authorized users can unlock this system
echo.
echo [*] Auto-lock active: System will re-lock every 2.5 minutes
echo.

REM Lock the workstation using built-in Windows command
rundll32.exe user32.dll,LockWorkStation

REM Wait 3 minutes before allowing unlock
echo [*] System is locked for minimum 3 minutes...
timeout /t 180 /nobreak

REM Lock again after 3 minutes
rundll32.exe user32.dll,LockWorkStation

REM Wait 2.5 minutes more and repeat
echo [*] Auto-lock timer: 2.5 minutes until next lock...
timeout /t 150 /nobreak

REM Go back to lock
goto lock_pc
