@echo off
chcp 65001 >nul
setlocal EnableExtensions
title Qualcomm Wi-Fi Installer (Windows Setup / OOBE)

:: ============================================================
::  Скрипт для экрана установки Windows "Давайте подключим вас к сети".
::  Грузит ТОЛЬКО Wi-Fi пакет Qualcomm FastConnect 7800 (WCN785x),
::  а не весь 1-ГБ набор (ADSP/PMIC/батарея). Так не переполняется
::  RAM-диск WinPE и не поднимается лишний стек драйверов.
::  Всё ставится во временное хранилище WinPE (X:), установленную
::  Windows это не затрагивает.
:: ============================================================

cd /d "%~dp0"

:: Поддержаны две раскладки:
::   1) скрипт в корне флешки:  <флешка>\install_wifi.bat + <флешка>\Acer_ARM64_Drivers\Drivers_files
::   2) скрипт внутри пакета:   <пакет>\install_wifi.bat    + <пакет>\Drivers_files
set "DRV=%~dp0Acer_ARM64_Drivers\Drivers_files"
if not exist "%DRV%\*.inf" set "DRV=%~dp0Drivers_files"

if not exist "%DRV%\*.inf" (
    echo [ERROR] Drivers_files was not found.
    echo [ОШИБКА] Папка Drivers_files не найдена.
    echo.
    echo Checked / Проверены пути:
    echo   %~dp0Acer_ARM64_Drivers\Drivers_files
    echo   %~dp0Drivers_files
    echo.
    pause
    exit /b 1
)

:: Точный INF под PCI\VEN_17CB&DEV_1107&SUBSYS_80011EAC (FastConnect 7800).
:: Ищем полный путь, чтобы не зависеть от регистра и вложенности папок.
set "WLANINF="
for /f "delims=" %%f in ('dir /b /s "%DRV%\qcwlanhmt8380.inf" 2^>nul') do if not defined WLANINF set "WLANINF=%%f"

if not defined WLANINF (
    echo [ERROR] qcwlanhmt8380.inf was not found in:
    echo [ОШИБКА] qcwlanhmt8380.inf не найден в:
    echo   %DRV%
    echo.
    pause
    exit /b 2
)

echo ========================================================
echo  Qualcomm FastConnect 7800 - Wi-Fi for Windows Setup
echo  Qualcomm FastConnect 7800 - Wi-Fi для установки Windows
echo  Telegram: https://t.me/codefort
echo ========================================================
echo.
echo [EN] Driver source: %DRV%
echo [RU] Источник драйверов: %DRV%
echo [EN] WLAN package:  %WLANINF%
echo [RU] Пакет WLAN:    %WLANINF%
echo.

echo [1/4] Staging the Wi-Fi package into the WinPE driver store...
echo [1/4] Добавление Wi-Fi пакета в хранилище WinPE...
pnputil /add-driver "%WLANINF%" /subdirs
if errorlevel 1 (
    echo.
    echo [WARN] The Wi-Fi package was not staged.
    echo [ПРЕДУПРЕЖДЕНИЕ] Wi-Fi пакет не добавлен.
    echo [EN] Trying the full driver set as a fallback...
    echo [RU] Пробую полный набор драйверов как запасной вариант...
    pnputil /add-driver "%DRV%\*.inf" /subdirs
)
echo.

echo [2/4] Scanning devices...
echo [2/4] Сканирование устройств...
pnputil /scan-devices
echo.

echo [3/4] Loading the WLAN driver in WinPE...
echo [3/4] Загрузка драйвера WLAN в WinPE...
where drvload >nul 2>&1
if errorlevel 1 (
    echo [INFO] drvload is not available; relying on the PnP scan.
    echo [ИНФО] drvload недоступен; используется скан PnP.
) else (
    echo   drvload "%WLANINF%"
    drvload "%WLANINF%"
)
echo.

echo [4/4] Starting WLAN service and checking the interface...
echo [4/4] Запуск службы WLAN и проверка интерфейса...
net start wlansvc >nul 2>&1
net start dot3svc >nul 2>&1
ping -n 9 127.0.0.1 >nul 2>&1
netsh wlan show interfaces
echo.

echo ========================================================
echo [EN] Done. Return to Setup - the Wi-Fi list should appear.
echo [RU] Готово. Вернитесь в установку - список Wi-Fi должен появиться.
echo [EN] If there is no list, run this script again and read the messages.
echo [RU] Если сетей нет, запустите скрипт ещё раз и посмотрите сообщения.
echo ========================================================
timeout /t 5 >nul 2>&1
exit /b 0
