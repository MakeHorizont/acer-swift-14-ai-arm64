# Acer Swift 14 AI ARM64 drivers — v1.0

Дата: 2026-11-03

Пакет OEM-драйверов и скриптов для чистой установки Windows 11 ARM64 на Acer Swift 14 AI SF14-11 (Snapdragon X Elite X1E78100).

## Файл ZIP

- `Acer_ARM64_Drivers_v1.0.zip`
- Размер: **507 294 909 байт (483,79 МиБ)**
- Внутри: 778 файлов, 1 087 285 488 байт (1,01 ГБ) до сжатия
- SHA-256: `1c39a1ce86fb201894379817644aee92ea0b9eb092e58cac1f8f640da8781efe`

Проверка:

```powershell
Get-FileHash .\Acer_ARM64_Drivers_v1.0.zip -Algorithm SHA256
```

## Торренты

### ZIP-торрент (рекомендую)

- `Acer_ARM64_Drivers_v1.0.torrent`
- Содержимое: `Acer_ARM64_Drivers_v1.0.zip` (483,79 МиБ)
- Info hash: `0c7c384318fe0251c43b34bbc9691e231a140bc2`
- SHA-256 `.torrent`: `7e80e0a39bd84a156add022a7ed343e63b7c5d3c1aca9f570cfc250441eeaeac`
- Magnet:

```text
magnet:?xt=urn:btih:0c7c384318fe0251c43b34bbc9691e231a140bc2&dn=Acer_ARM64_Drivers_v1.0.zip&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&ws=https%3A%2F%2Fgithub.com%2FMakeHorizont%2Facer-swift-14-ai-arm64%2Freleases%2Fdownload%2Fv1.0%2FAcer_ARM64_Drivers_v1.0.zip
```

### Торрент папки (без сжатия)

- `Acer_ARM64_Drivers.torrent`
- Содержимое: папка `Acer_ARM64_Drivers` — 778 файлов, 1 087 285 488 байт (1,01 ГБ)
- Info hash: `99e55818e010c18f7ff1ce7a85807cfcc0d3b080`
- SHA-256 `.torrent`: `88ade8b245986744a8301ead87050b8e01584510c9b510761da525f036d9646b`
- Magnet:

```text
magnet:?xt=urn:btih:99e55818e010c18f7ff1ce7a85807cfcc0d3b080&dn=Acer_ARM64_Drivers&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce
```

## Что внутри

- `Drivers_files/` — 133 INF-пакета, только ARM64 (`NTarm64`)
- `ColorProfiles/` — заводские профили экрана
- `install_wifi.bat` — Wi-Fi для экрана OOBE (WinPE)
- `setup_and_check.bat` — установка OEM-драйверов на рабочем столе
- `Check_notebook_for_drivers.bat` — устаревший скрипт, только для истории
- `drivers_list.txt` — инвентаризация пакетов
- `README.md` / `READ_ME.txt` — документация

Ключевые версии:

- `qcsubsys_ext_adsp8380.inf` — 2.0.4005.7400 (28.04.2024)
- `qcacsp_crd8380.inf` — 1.0.3999.7000 (01.04.2024)
- `qcsubsys8380.inf` — 2.0.4005.7300 (08.04.2024)
- `qcwlanhmt8380.inf` — 1.0.4018.8200 (24.04.2024)

## Что изменилось в v1.0

- `install_wifi.bat` ставит точный пакет `qcwlanhmt8380.inf` под `PCI\VEN_17CB&DEV_1107&SUBSYS_80011EAC`; `pnputil /add-driver` без `/install`, затем `scan-devices` и `drvload`.
- `setup_and_check.bat` сначала сбрасывает схемы питания, затем добавляет все INF в DriverStore без `/install`, импортирует `.pow` (если есть), делает `scan-devices` и перезагружает ноутбук.
- Кредит `https://t.me/codefort` теперь кликабельный в Windows Terminal.
- В `Check_notebook_for_drivers.bat` добавлено предупреждение «устаревший скрипт».
- Добавлен полноценный `README.md`.

## Важно

- В архиве есть `PerceptionCoreResources.dll` на 267,13 МБ. GitHub не принимает файлы >100 МБ в git, поэтому ZIP распространяется через Releases, а не через дерево репозитория.
- `acer_power_profile.pow` в пакет не входит; шаг импорта схемы питания будет пропущен с предупреждением.
- Торренты работают, только пока есть сидеры. После скачивания желательно оставить раздачу включённой.
- ZIP-торрент меньше и удобнее для обычных пользователей. Торрент папки — 1,01 ГБ, зато внутри сразу 778 отдельных файлов.
- Торрент папки создан в qBittorrent без трекеров. Для него используй magnet из раздела выше — в нём трекеры уже прописаны.

## Зеркала

- GitHub Release: https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/tag/v1.0
- ZIP (GitHub): https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers_v1.0.zip
- ZIP-торрент (GitHub): https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers_v1.0.torrent
- Торрент папки (GitHub): https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers.torrent
- Google Drive: https://drive.google.com/file/d/16i_lzauXH1sledXWDcj0kTpl-nJRXhSY/view?usp=sharing
- Telegram: https://t.me/codefort/187

## Правовая информация

Драйверы и firmware — собственность Qualcomm, Acer и их правообладателей. Пакет публикуется «как есть» для восстановления конкретной модели ноутбука. Использование — на свой риск. Скрипты и документация — MIT; драйверы в эту лицензию не входят.
