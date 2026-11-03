@echo off
chcp 65001 >nul
setlocal EnableExtensions
title Acer Swift 14 AI - OEM Driver and Power Setup

:: ============================================================
::  Acer Swift 14 AI (SF14-11) / Snapdragon X Elite / ARM64
::  Безопасная установка OEM-драйверов:
::    - только добавление пакетов в DriverStore (без /install);
::    - дерево устройств строит сама Windows через scan-devices;
::    - импорт OEM-схемы питания (если файл .pow присутствует);
::    - чистая перезагрузка для инициализации firmware Qualcomm.
:: ============================================================

:: ---------- 1. Проверка прав администратора ----------
net session >nul 2>&1
if errorlevel 1 (
    fltmc >nul 2>&1
    if errorlevel 1 (
        echo ========================================================
        echo  [EN] Administrator rights are required.
        echo  [RU] Требуются права администратора.
        echo ========================================================
        echo [EN] Requesting elevation...
        echo [RU] Запрос повышения прав...
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath '%~f0' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
        if errorlevel 1 (
            echo.
            echo [ERROR] Elevation was cancelled or failed.
            echo [ОШИБКА] Повышение прав отменено или не удалось.
            pause
        )
        exit /b
    )
)

cd /d "%~dp0"

echo ========================================================
echo  Acer Swift 14 AI - OEM driver setup (ARM64)
echo  Acer Swift 14 AI - установка OEM-драйверов (ARM64)
echo  Telegram: https://t.me/codefort
echo ========================================================
echo.

:: ---------- 2. Проверка архитектуры ----------
set "ARCH=%PROCESSOR_ARCHITECTURE%"
if /i "%PROCESSOR_ARCHITEW6432%"=="ARM64" set "ARCH=ARM64"

echo [EN] PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
echo [RU] Архитектура процесса     = %PROCESSOR_ARCHITECTURE%
echo.

if /i not "%ARCH%"=="ARM64" (
    echo ========================================================
    echo  [ERROR] This package is for ARM64 only.
    echo  [ОШИБКА] Пакет предназначен только для ARM64.
    echo ========================================================
    echo Detected / Обнаружено: %PROCESSOR_ARCHITECTURE% / %PROCESSOR_ARCHITEW6432%
    echo.
    pause
    exit /b 2
)
echo [OK] ARM64 platform confirmed.
echo [ОК] Платформа ARM64 подтверждена.
echo.

:: ---------- 3. Поиск драйверов ----------
set "DRV=%~dp0Acer_ARM64_Drivers\Drivers_files"
if not exist "%DRV%\*.inf" set "DRV=%~dp0Drivers_files"

if not exist "%DRV%\*.inf" (
    echo ========================================================
    echo  [ERROR] Drivers_files was not found.
    echo  [ОШИБКА] Папка Drivers_files не найдена.
    echo ========================================================
    echo Checked / Проверены пути:
    echo   %~dp0Acer_ARM64_Drivers\Drivers_files
    echo   %~dp0Drivers_files
    echo.
    pause
    exit /b 3
)

set "COUNT=0"
for /r "%DRV%" %%f in (*.inf) do set /a COUNT+=1

echo [EN] Driver source: %DRV%
echo [RU] Источник драйверов: %DRV%
echo [EN] INF packages found: %COUNT%
echo [RU] Найдено INF-пакетов: %COUNT%
echo.

echo [EN] The script will now: restore default power schemes, stage drivers,
echo      import the OEM power profile (if present), rescan devices and reboot.
echo [RU] Скрипт сейчас: сбросит схемы питания, добавит драйверы в хранилище,
echo      импортирует OEM-профиль питания (если есть), выполнит скан устройств
echo      и перезагрузит ноутбук.
echo.
echo [EN] Starting in 15 seconds. Press Ctrl+C to cancel.
echo [RU] Старт через 15 секунд. Ctrl+C - отмена.
timeout /t 15
echo.

:: ---------- 4. Схемы питания: сброс ДО импорта ----------
:: ВАЖНО: restoredefaultschemes удаляет пользовательские схемы, поэтому он
:: выполняется ПЕРЕД импортом. Если сделать наоборот, OEM-схема будет удалена.
echo [1/5] Restoring default power schemes...
echo [1/5] Сброс схем питания к стандартным...
powercfg -restoredefaultschemes
if errorlevel 1 (
    echo [WARN] powercfg -restoredefaultschemes failed.
    echo [ПРЕДУПРЕЖДЕНИЕ] Не удалось сбросить схемы питания.
)
echo.

:: ---------- 5. Безопасное добавление драйверов ----------
echo [2/5] Staging drivers into the driver store (WITHOUT /install)...
echo [2/5] Добавление драйверов в хранилище (БЕЗ /install)...
echo [EN] This may take several minutes. Do not close this window.
echo [RU] Это может занять несколько минут. Не закрывайте окно.
echo.

pnputil /add-driver "%DRV%\*.inf" /subdirs
set "RC=%ERRORLEVEL%"

echo.
if not "%RC%"=="0" (
    echo [WARN] pnputil returned code %RC%.
    echo [ПРЕДУПРЕЖДЕНИЕ] pnputil вернул код %RC%.
    echo [EN] Some packages may have been skipped; the rest were staged.
    echo [RU] Часть пакетов могла быть пропущена; остальные добавлены.
    echo.
)
echo [EN] Driver staging finished.
echo [RU] Добавление драйверов завершено.
echo.

:: ---------- 6. OEM-схема питания ----------
echo [3/5] Importing OEM power profile (.pow)...
echo [3/5] Импорт OEM-схемы питания (.pow)...

set "POW="
if exist "%~dp0Acer_ARM64_Drivers\acer_power_profile.pow" set "POW=%~dp0Acer_ARM64_Drivers\acer_power_profile.pow"
if not defined POW if exist "%~dp0acer_power_profile.pow" set "POW=%~dp0acer_power_profile.pow"
if not defined POW for /r "%~dp0" %%f in (*.pow) do if not defined POW set "POW=%%f"

if not defined POW (
    echo [WARN] acer_power_profile.pow not found - step skipped.
    echo [ПРЕДУПРЕЖДЕНИЕ] acer_power_profile.pow не найден - шаг пропущен.
) else (
    echo [EN] File: %POW%
    echo [RU] Файл: %POW%
    :: Фиксированный GUID вместо разбора локализованного вывода powercfg.
    powercfg -delete {8f2f5a3e-6c1b-4d2a-9e7f-3b5c1d0a4e21} >nul 2>&1
    powercfg -import "%POW%" {8f2f5a3e-6c1b-4d2a-9e7f-3b5c1d0a4e21}
    if errorlevel 1 (
        echo [WARN] Import failed. The default scheme remains active.
        echo [ПРЕДУПРЕЖДЕНИЕ] Импорт не удался. Останется стандартная схема.
    ) else (
        powercfg -setactive {8f2f5a3e-6c1b-4d2a-9e7f-3b5c1d0a4e21}
        if errorlevel 1 (
            echo [WARN] Could not activate the imported scheme.
            echo [ПРЕДУПРЕЖДЕНИЕ] Не удалось активировать импортированную схему.
        ) else (
            echo [OK] Power scheme imported and activated.
            echo [ОК] Схема питания импортирована и активирована.
        )
    )
)
echo.

:: ---------- 7. Сборка дерева устройств ----------
echo [4/5] Scanning devices (Windows builds the device tree)...
echo [4/5] Сканирование устройств (Windows строит дерево устройств)...
pnputil /scan-devices
echo.

echo [5/5] Problem devices (informational):
echo [5/5] Проблемные устройства (для информации):
pnputil /enum-devices /problem 2>nul
echo.

echo ========================================================
echo [EN] Setup complete. Rebooting in 10 seconds...
echo [RU] Установка завершена. Перезагрузка через 10 секунд...
echo ========================================================
timeout /t 5
shutdown /r /t 10 /f
exit /b 0
