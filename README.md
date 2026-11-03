# Acer Swift 14 AI (SF14-11) — ARM64: Wi-Fi + OEM drivers

Скрипты и OEM-пакет драйверов для чистой установки **Windows 11 ARM64** на **Acer Swift 14 AI** (Snapdragon X Elite X1E78100).

**English TL;DR:** batch scripts + OEM driver backup for Acer Swift 14 AI (SF14-11, Snapdragon X Elite, ARM64). `install_wifi.bat` loads the Qualcomm FastConnect 7800 driver during Windows Setup; `setup_and_check.bat` stages the OEM driver package **without `/install`**, applies the power profile and reboots. The driver archive is distributed via GitHub Releases / Google Drive / Telegram / Torrent. Use at your own risk.

Версия: **v1.0** (2026-11-03).

> ⚠️ **Только для Acer Swift 14 AI SF14-11 / SF14-11T на Snapdragon X Elite.**
> На Intel-версии (SF14-51) и любых других ноутбуках эти драйверы применять нельзя.

---

## Скачать

Драйверы **не хранятся в git-репозитории**: в пакете есть файл `PerceptionCoreResources.dll` на 267 МБ, а GitHub блокирует файлы больше 100 МБ. Поэтому архив лежит отдельно.

| Канал | Ссылка | Примечание |
|---|---|---|
| **GitHub Release v1.0** | [Открыть релиз](https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/tag/v1.0) | ZIP + два торрента |
| **ZIP (GitHub)** | [Acer_ARM64_Drivers_v1.0.zip](https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers_v1.0.zip) | 483,79 МиБ |
| **Google Drive** | [Зеркало](https://drive.google.com/file/d/16i_lzauXH1sledXWDcj0kTpl-nJRXhSY/view?usp=sharing) | тот же ZIP |
| **Telegram** | [Пост в канале](https://t.me/codefort/187) | тот же ZIP |
| **Torrent (ZIP)** | [Acer_ARM64_Drivers_v1.0.torrent](https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers_v1.0.torrent) | 483,79 МиБ, рекомендую |
| **Torrent (папка)** | [Acer_ARM64_Drivers.torrent](https://github.com/MakeHorizont/acer-swift-14-ai-arm64/releases/download/v1.0/Acer_ARM64_Drivers.torrent) | 1,01 ГБ, 778 файлов |

Файл: `Acer_ARM64_Drivers_v1.0.zip` — **507 294 909 байт (483,79 МиБ)**.

**SHA-256:**

```text
1c39a1ce86fb201894379817644aee92ea0b9eb092e58cac1f8f640da8781efe
```

Проверка в Windows:

```powershell
Get-FileHash .\Acer_ARM64_Drivers_v1.0.zip -Algorithm SHA256
```

**Magnet для ZIP-торрента** (если torrent-клиент не открывает `.torrent`):

```text
magnet:?xt=urn:btih:0c7c384318fe0251c43b34bbc9691e231a140bc2&dn=Acer_ARM64_Drivers_v1.0.zip&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&ws=https%3A%2F%2Fgithub.com%2FMakeHorizont%2Facer-swift-14-ai-arm64%2Freleases%2Fdownload%2Fv1.0%2FAcer_ARM64_Drivers_v1.0.zip
```

<details>
<summary>Magnet для торрента папки (1,01 ГБ, 778 файлов)</summary>

```text
magnet:?xt=urn:btih:99e55818e010c18f7ff1ce7a85807cfcc0d3b080&dn=Acer_ARM64_Drivers&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce
```

</details>

> Торренты работают, пока есть сидеры. ZIP-торрент меньше (483,79 МиБ); торрент папки — 1,01 ГБ, зато внутри сразу 778 отдельных файлов. Торрент папки создан в qBittorrent без трекеров, поэтому для него лучше брать magnet из спойлера выше — там трекеры прописаны. Контрольные суммы всех файлов — в `SHA256SUMS.txt`.

---

## Зачем это нужно

Стандартный образ Windows 11 ARM64 не содержит драйверов Qualcomm для этой платформы. После чистой установки:

- установщик не видит Wi-Fi и не даёт завершить настройку без сети;
- не работает звук (ADSP в Диспетчере устройств — «Код 31»);
- не работает тачпад, GPU, камера, сенсоры;
- возможны проблемы с зарядкой и отображением батареи.

Пакет драйверов снят с заводского SSD этого ноутбука. Скрипты добавляют его в DriverStore **без принудительной установки** и дают Windows самой собрать дерево устройств.

---

## Поддерживаемое железо

| Параметр | Значение |
|---|---|
| Модель | Acer Swift 14 AI SF14-11 / SF14-11T |
| Архитектура | Windows on ARM (ARM64) |
| SoC | Qualcomm Snapdragon X Elite X1E78100 |
| BIOS (пример) | Insyde `D0.40.01.05` от 28.04.2024, строки `CRD` / `SCP_HAMOA` |
| Board ID | `SUBSYS_CRD08380` |
| Wi-Fi | Qualcomm FastConnect 7800, `PCI\VEN_17CB&DEV_1107&SUBSYS_80011EAC` |
| Audio DSP | `ACPI\QCOM0C1B` + `ADSP\VEN_QCOM&DEV_0C22&SUBSYS_27822205` |
| GPU | Adreno X1-85, `SUBSYS_27822100` |
| Батарея | `ACPI\QCOM0C2A` (Qualcomm PM Battery Miniclass) |

---

## Что в архиве

| Путь | Назначение |
|---|---|
| `Drivers_files/` | 133 INF-пакета, только ARM64 (`NTarm64`), ~1.01 ГБ до сжатия |
| `ColorProfiles/` | Заводские профили экрана (`RSWOP.icm`, `sRGB`) |
| `install_wifi.bat` | Wi-Fi на этапе установки Windows (OOBE) |
| `setup_and_check.bat` | Основной установщик OEM-драйверов на рабочем столе |
| `Check_notebook_for_drivers.bat` | **Устаревший** скрипт, не использовать (см. ниже) |
| `drivers_list.txt` | Инвентаризация пакетов |
| `READ_ME.txt` | Исходное описание пакета |

Ключевые версии OEM-набора (2024 год, совпадает с BIOS от 28.04.2024):

- `qcsubsys_ext_adsp8380.inf` — **2.0.4005.7400** (28.04.2024)
- `qcacsp_crd8380.inf` — 1.0.3999.7000 (01.04.2024) — CRD-расширение под `SUBSYS_27822205`
- `qcsubsys8380.inf` — 2.0.4005.7300 (08.04.2024)
- `qcwlanhmt8380.inf` — 1.0.4018.8200 (24.04.2024)

---

## Быстрый старт

### 1. Подготовить флешку

Скачай ZIP, распакуй и скопируй на флешку. Удобная раскладка:

```text
<флешка>\
├── install_wifi.bat
├── setup_and_check.bat
└── Acer_ARM64_Drivers\
    ├── Drivers_files\
    ├── ColorProfiles\
    └── (acer_power_profile.pow — если есть)
```

Скрипты понимают и вторую раскладку, когда `install_wifi.bat` и `setup_and_check.bat` лежат **внутри** папки пакета, рядом с `Drivers_files`. В архиве они уже лежат именно так — можно запускать прямо из `Acer_ARM64_Drivers`.

### 2. Wi-Fi на этапе установки Windows

На экране **«Давайте подключим вас к сети»**:

1. Нажми `Shift + F10` (или `Fn + Shift + F10`) — откроется командная строка.
2. Определи букву флешки (`D:`, `E:`, `F:` …).
3. Запусти:

```bat
D:\install_wifi.bat
:: или, если скрипт лежит внутри папки пакета:
D:\Acer_ARM64_Drivers\install_wifi.bat
```

Скрипт:

- находит `qcwlanhmt8380.inf` (FastConnect 7800);
- добавляет пакет в DriverStore WinPE **без `/install`**;
- выполняет `pnputil /scan-devices`;
- загружает драйвер через `drvload` (штатный загрузчик WinPE);
- запускает `wlansvc` и показывает `netsh wlan show interfaces`.

Через несколько секунд список Wi-Fi сетей должен появиться. Вернись в установку и подключись.

### 3. После первого входа в Windows

Скопируй папку пакета на рабочий стол (или запусти прямо с флешки), затем:

- правый клик по `setup_and_check.bat` → **«Запуск от имени администратора»**;
- скрипт сам проверит ARM64, добавит все INF в DriverStore, применит схему питания и перезагрузит ноутбук.

После перезагрузки проверь звук, Wi-Fi, тачпад, GPU и батарею.

---

## Как работают скрипты

### `install_wifi.bat` (OOBE)

- Работает в WinPE (среда установщика), не в установленной Windows.
- Ставит **только Wi-Fi пакет**, а не весь 1-ГБ набор: в WinPE хранилище драйверов находится на RAM-диске `X:`, и лишний гигабайт там не нужен.
- `pnputil /add-driver "<INF>" /subdirs` — только добавление в хранилище.
- `pnputil /scan-devices` — PnP-скан.
- `drvload "<INF>"` — немедленная загрузка драйвера в WinPE.
- Всё это живёт только в `X:` и **не попадает в установленную Windows**.

### `setup_and_check.bat` (рабочий стол)

1. Проверка прав администратора (при необходимости — самоподъём через UAC).
2. Проверка `%PROCESSOR_ARCHITECTURE%` = `ARM64`; иначе выход.
3. Поиск `Drivers_files` (обе раскладки).
4. `powercfg -restoredefaultschemes` — сброс схем питания **до** импорта OEM-профиля.
5. `pnputil /add-driver "Drivers_files\*.inf" /subdirs` — **без `/install`**.
6. Импорт `acer_power_profile.pow` (если файл есть) и `powercfg -setactive`.
7. `pnputil /scan-devices` — Windows сама строит дерево устройств.
8. Показ проблемных устройств, пауза 5 секунд и `shutdown /r /t 10 /f`.

> **Почему `restoredefaultschemes` идёт до импорта:** эта команда удаляет пользовательские схемы питания. Если выполнить её после импорта, OEM-схема Acer будет удалена, и `setactive` станет бессмысленным.

---

## Почему без `/install`

Массовый `pnputil /add-driver *.inf /subdirs /install` на ARM64-платформе Qualcomm — плохая идея:

- Windows начинает активировать расширения (ADSP, PMIC, audio, battery) в произвольном порядке;
- звуковое расширение может подняться раньше, чем система разберётся с управлением питанием;
- на этой платформе это приводило к падению `charger_process`, зависанию зарядки и «Код 31» у ADSP.

Правильный порядок:

1. Сложить **все** пакеты в DriverStore без `/install`.
2. Дать Windows выполнить `scan-devices` и самой построить топологию: чипсет → питание → компоненты → звук.
3. Перезагрузиться.

`setup_and_check.bat` делает именно так.

---

## Если что-то пошло не так

### ADSP «Код 31», нет звука

Причина — нет OEM-расширения под конкретный Board ID (`SUBSYS_27822205` / `SUBSYS_CRD08380`), либо установлен несовместимый generic-пакет.

- Убедись, что в пакете есть `qcacsp_crd8380.inf` и `qcsubsys_ext_adsp8380.inf`.
- Не форсируй более новый generic-пакет (например, 2.0.7800.0002): на этой плате он ронял `charger_process`.
- После установки OEM-набора — перезагрузка обязательна.

### Пропала батарея, «подключено, не заряжается»

Проверь, не отключено ли устройство батареи:

```bat
pnputil /enum-devices /class Battery
```

Если в статусе `Disabled` / `Problem 22`:

```bat
pnputil /enable-device "ACPI\QCOM0C2A\2&DABA3FF&0"
```

Затем перезагрузись. При 100% заряда `Charging = False` — это нормально; проверяй при разряде ниже ~95%.

### Wi-Fi не появился в установщике

- Убедись, что флешка содержит `qcwlanhmt8380.inf` (папка `Drivers_files`).
- Запусти `install_wifi.bat` ещё раз и посмотри вывод `drvload` / `netsh wlan show interfaces`.
- Проверь, что адаптер именно `PCI\VEN_17CB&DEV_1107&SUBSYS_80011EAC` (FastConnect 7800). Для других модулей нужен другой INF.

### Проверка после установки

```bat
pnputil /enum-devices /problem
pnputil /enum-devices /class Battery
pnputil /enum-devices /class Net
```

Или в PowerShell:

```powershell
Get-PnpDevice | Where-Object Status -ne 'OK' | Select-Object Status,Class,FriendlyName,InstanceId
```

---

## Устаревший скрипт

`Check_notebook_for_drivers.bat` лежит в архиве только для истории. Он использует массовый `/install` и может снова вызвать конфликт зарядки/звука. **Не запускай его** — используй `setup_and_check.bat`.

---

## Почему драйверы не в git

В архиве есть `Drivers_files\microsofteffectpack_extension.inf_arm64_8881111f8f333d4e\PerceptionCoreResources.dll` размером **267,13 МБ**. GitHub не принимает файлы больше 100 МБ в git-историю. Поэтому:

- в репозитории лежат только скрипты, README и `.torrent`;
- сам архив `Acer_ARM64_Drivers_v1.0.zip` (483,79 МиБ) публикуется в **Releases** (лимит 2 ГБ на файл);
- Google Drive и Telegram — зеркала;
- torrent — резервный канал.

Так репозиторий остаётся лёгким, а пользователи скачивают один ZIP без Git LFS.

---

## FAQ

**Можно ли применить на другой модели Acer?**
Нет. Пакет привязан к Board ID `SUBSYS_CRD08380` / `SUBSYS_27822205` и к BIOS конкретной ревизии.

**Нужен ли `acer_power_profile.pow`?**
Не обязателен. Если файла нет, `setup_and_check.bat` пропустит шаг с предупреждением.

**Можно ли ставить драйверы повторно?**
Да, `setup_and_check.bat` можно запускать повторно: он не использует `/install` и не удаляет существующие пакеты.

**Почему `install_wifi.bat` не ставит весь набор?**
Для Wi-Fi в WinPE достаточно одного пакета. Полный набор ставится уже на рабочем столе, в нормальной среде.

**Почему ZIP меньше 1 ГБ, хотя драйверов 1,01 ГБ?**
Драйверы хорошо сжимаются: 1 087 285 488 байт → 507 294 909 байт ZIP.

---

## Правовая информация

- Драйверы и firmware — собственность Qualcomm, Acer и их правообладателей. Пакет публикуется «как есть» для восстановления конкретной модели ноутбука.
- Авторы не связаны с Acer или Qualcomm.
- Использование — на свой риск. Перед установкой сделай резервную копию системы и данных.
- Скрипты и документация — MIT (см. `LICENSE`). Драйверы в архив не входят в эту лицензию.

---

## Благодарности

Спасибо сообществу **t.me/codefort** за исходную идею и скрипты.

Telegram: **[https://t.me/codefort](https://t.me/codefort)**
