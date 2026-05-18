@echo off
REM PC Lock System - Windows HTML Lock Screen
REM Creates fullscreen lock screen with password protection
REM No taskbar, no close button, no escape

setlocal enabledelayedexpansion

REM Create HTML lock screen
set "HTML_FILE=%TEMP%\pc_lock_system_%RANDOM%.html"

(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>PC LOCK SYSTEM^</title^>
echo     ^<style^>
echo         * {
echo             margin: 0;
echo             padding: 0;
echo             box-sizing: border-box;
echo         }
echo         
echo         html, body {
echo             width: 100%%;
echo             height: 100%%;
echo             overflow: hidden;
echo             background: linear-gradient(135deg, #1a1a2e 0%%, #16213e 100%%);
echo             font-family: 'Arial', sans-serif;
echo             display: flex;
echo             justify-content: center;
echo             align-items: center;
echo             position: fixed;
echo             top: 0;
echo             left: 0;
echo             right: 0;
echo             bottom: 0;
echo         }
echo         
echo         body {
echo             background: linear-gradient(135deg, #0f0f1e 0%%, #1a1a2e 100%%);
echo         }
echo         
echo         .lock-container {
echo             text-align: center;
echo             padding: 50px;
echo             background: rgba(0, 0, 0, 0.8);
echo             border-radius: 20px;
echo             box-shadow: 0 20px 60px rgba(0, 0, 0, 0.9);
echo             backdrop-filter: blur(10px);
echo             max-width: 600px;
echo             width: 90%%;
echo         }
echo         
echo         .lock-icon {
echo             font-size: 100px;
echo             margin-bottom: 20px;
echo             animation: pulse 2s infinite;
echo         }
echo         
echo         @keyframes pulse {
echo             0%%, 100%% { transform: scale(1); }
echo             50%% { transform: scale(1.1); }
echo         }
echo         
echo         h1 {
echo             color: #ff0000;
echo             font-size: 48px;
echo             margin-bottom: 20px;
echo             text-transform: uppercase;
echo             letter-spacing: 3px;
echo             text-shadow: 0 0 20px rgba(255, 0, 0, 0.5);
echo         }
echo         
echo         .status {
echo             color: #00ff00;
echo             font-size: 20px;
echo             margin-bottom: 30px;
echo             text-transform: uppercase;
echo             letter-spacing: 2px;
echo         }
echo         
echo         .time-display {
echo             color: #00ffff;
echo             font-size: 36px;
echo             font-weight: bold;
echo             margin-bottom: 30px;
echo             font-family: 'Courier New', monospace;
echo             letter-spacing: 2px;
echo         }
echo         
echo         .warning-box {
echo             background: rgba(255, 0, 0, 0.1);
echo             border: 2px solid #ff0000;
echo             padding: 20px;
echo             margin: 20px 0;
echo             border-radius: 10px;
echo             color: #ffcccc;
echo             font-size: 16px;
echo         }
echo         
echo         .password-section {
echo             margin-top: 30px;
echo         }
echo         
echo         .password-label {
echo             color: #ffff00;
echo             font-size: 18px;
echo             margin-bottom: 15px;
echo             text-transform: uppercase;
echo             letter-spacing: 2px;
echo         }
echo         
echo         #password-input {
echo             width: 100%%;
echo             padding: 15px;
echo             font-size: 24px;
echo             background: rgba(255, 255, 255, 0.1);
echo             border: 2px solid #00ff00;
echo             color: #00ff00;
echo             border-radius: 8px;
echo             text-align: center;
echo             font-weight: bold;
echo             letter-spacing: 3px;
echo             transition: all 0.3s ease;
echo         }
echo         
echo         #password-input:focus {
echo             outline: none;
echo             border-color: #ffff00;
echo             box-shadow: 0 0 20px rgba(0, 255, 0, 0.5);
echo             background: rgba(255, 255, 255, 0.15);
echo         }
echo         
echo         .button-group {
echo             margin-top: 20px;
echo             display: flex;
echo             gap: 10px;
echo         }
echo         
echo         #unlock-btn {
echo             flex: 1;
echo             padding: 15px;
echo             font-size: 18px;
echo             background: linear-gradient(135deg, #00ff00, #00cc00);
echo             color: #000;
echo             border: none;
echo             border-radius: 8px;
echo             cursor: pointer;
echo             text-transform: uppercase;
echo             font-weight: bold;
echo             letter-spacing: 2px;
echo             transition: all 0.3s ease;
echo         }
echo         
echo         #unlock-btn:hover {
echo             transform: translateY(-2px);
echo             box-shadow: 0 10px 30px rgba(0, 255, 0, 0.4);
echo         }
echo         
echo         #unlock-btn:active {
echo             transform: translateY(0);
echo         }
echo         
echo         .message {
echo             margin-top: 20px;
echo             font-size: 16px;
echo             min-height: 20px;
echo             text-transform: uppercase;
echo             letter-spacing: 1px;
echo         }
echo         
echo         .error-message {
echo             color: #ff0000;
echo             text-shadow: 0 0 10px rgba(255, 0, 0, 0.7);
echo         }
echo         
echo         .success-message {
echo             color: #00ff00;
echo             text-shadow: 0 0 10px rgba(0, 255, 0, 0.7);
echo         }
echo         
echo         .attempts {
echo             color: #ffff00;
echo             font-size: 14px;
echo             margin-top: 15px;
echo             text-transform: uppercase;
echo             letter-spacing: 1px;
echo         }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="lock-container"^>
echo         ^<div class="lock-icon"^>🔒^</div^>
echo         ^<h1^>PC LOCK SYSTEM^</h1^>
echo         
echo         ^<div class="status"^>⚠️ SYSTEM LOCKED ⚠️^</div^>
echo         
echo         ^<div class="time-display" id="time-display"^>00:00:00^</div^>
echo         
echo         ^<div class="warning-box"^>
echo             THIS PC IS COMPLETELY LOCKED^<br^>
echo             Only authorized users can unlock
echo         ^</div^>
echo         
echo         ^<div class="password-section"^>
echo             ^<div class="password-label"^>🔑 Enter Password to Unlock^</div^>
echo             ^<input type="password" id="password-input" placeholder="••••••••" autofocus^>
echo             ^<div class="button-group"^>
echo                 ^<button id="unlock-btn"^>UNLOCK^</button^>
echo             ^</div^>
echo             ^<div class="message" id="message"^>^</div^>
echo             ^<div class="attempts" id="attempts"^>Attempts: 3/3^</div^>
echo         ^</div^>
echo     ^</div^>
echo     
echo     ^<script^>
echo         const CORRECT_PASSWORD = "1234567890";
echo         let attempts = 3;
echo         
echo         function updateTime^(^) {
echo             const now = new Date^(^);
echo             const hours = String^(now.getHours^(^)^).padStart^(2, '0'^);
echo             const minutes = String^(now.getMinutes^(^)^).padStart^(2, '0'^);
echo             const seconds = String^(now.getSeconds^(^)^).padStart^(2, '0'^);
echo             document.getElementById^('time-display'^).textContent = `$^{hours^}:$^{minutes^}:$^{seconds^}`;
echo         }
echo         
echo         setInterval^(updateTime, 1000^);
echo         updateTime^(^);
echo         
echo         const passwordInput = document.getElementById^('password-input'^);
echo         const unlockBtn = document.getElementById^('unlock-btn'^);
echo         const messageDiv = document.getElementById^('message'^);
echo         const attemptsDiv = document.getElementById^('attempts'^);
echo         
echo         document.addEventListener^('contextmenu', ^(e^) =^> {
echo             e.preventDefault^(^);
echo             return false;
echo         }^);
echo         
echo         document.addEventListener^('keydown', ^(e^) =^> {
echo             if ^(e.key === 'F12' ^|^| ^(e.ctrlKey ^&^& e.shiftKey ^&^& ^(e.key === 'I' ^|^| e.key === 'J' ^|^| e.key === 'C'^)^) ^|^| ^(e.ctrlKey ^&^& e.key === 'u'^)^) {
echo                 e.preventDefault^(^);
echo                 return false;
echo             }
echo             if ^(e.key === 'Enter'^) {
echo                 unlockPC^(^);
echo             }
echo         }^);
echo         
echo         function unlockPC^(^) {
echo             const enteredPassword = passwordInput.value;
echo             if ^(enteredPassword === CORRECT_PASSWORD^) {
echo                 messageDiv.textContent = '✅ PASSWORD CORRECT! UNLOCKING...';
echo                 messageDiv.className = 'message success-message';
echo                 unlockBtn.disabled = true;
echo                 passwordInput.disabled = true;
echo                 setTimeout^(^(^) =^> {
echo                     alert^('System Unlocked!'^);
echo                     window.close^(^);
echo                 }, 1500^);
echo             } else {
echo                 attempts--;
echo                 passwordInput.value = '';
echo                 if ^(attempts ^> 0^) {
echo                     messageDiv.textContent = '❌ Incorrect Password!';
echo                     messageDiv.className = 'message error-message';
echo                     attemptsDiv.textContent = `Attempts: $^{attempts^}/3`;
echo                 } else {
echo                     messageDiv.textContent = '❌ Maximum Attempts Exceeded!';
echo                     messageDiv.className = 'message error-message';
echo                     unlockBtn.disabled = true;
echo                     passwordInput.disabled = true;
echo                     attemptsDiv.textContent = 'System Locked - Contact Administrator';
echo                 }
echo             }
echo         }
echo         
echo         unlockBtn.addEventListener^('click', unlockPC^);
echo         window.onbeforeunload = function^(^) { return true; };
echo         passwordInput.focus^(^);
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > "%HTML_FILE%"

REM Open HTML in fullscreen using Internet Explorer/Edge
start "" "%HTML_FILE%"

REM Keep script running
timeout /t 9999 /nobreak
