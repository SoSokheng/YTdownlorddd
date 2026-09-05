@echo off
:: ====================================================================================
::  YT DOWNLOADER GANG - Windows CMD Edition
::  High-Speed YouTube MP3 & MP4 Downloader
::  Portable & Zero-Config for Any Windows PC
:: ====================================================================================

setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul 2>&1
title YT DOWNLOADER GANG - [CMD Edition]
mode con: cols=102 lines=36 >nul 2>&1

:: Default Color (Matrix Green)
if "%THEME_COLOR%"=="" set "THEME_COLOR=0A"
color %THEME_COLOR%

:: Set Paths
set "SCRIPT_DIR=%~dp0"
set "BIN_DIR=%SCRIPT_DIR%bin"
set "DOWNLOADS_DIR=%SCRIPT_DIR%Downloads"

if not exist "%BIN_DIR%" mkdir "%BIN_DIR%" >nul 2>&1
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%" >nul 2>&1

:CHECK_DEPENDENCIES
set "YTDLP="
set "FFMPEG="

if exist "%BIN_DIR%\yt-dlp.exe" (
    set "YTDLP=%BIN_DIR%\yt-dlp.exe"
) else (
    where.exe yt-dlp >nul 2>&1
    if !errorlevel! equ 0 set "YTDLP=yt-dlp"
)

if exist "%BIN_DIR%\ffmpeg.exe" (
    set "FFMPEG=%BIN_DIR%\ffmpeg.exe"
) else (
    where.exe ffmpeg >nul 2>&1
    if !errorlevel! equ 0 set "FFMPEG=ffmpeg"
)

if "!YTDLP!"=="" goto :INSTALL_DEPENDENCIES
if "!FFMPEG!"=="" goto :INSTALL_DEPENDENCIES
goto :MAIN_MENU

:INSTALL_DEPENDENCIES
cls
call :SHOW_BANNER
echo.
echo   [!] FIRST-TIME SETUP REQUIRED
echo   ---------------------------------------------------------------------------------------------
echo   YT DOWNLOADER GANG needs yt-dlp and FFmpeg to download ultra-high-quality MP4/MP3.
echo   These core tools were not detected on your PC.
echo.
echo   [1] Auto-Install Core Engine Now (Fast, portable, no admin needed)
echo   [2] Exit
echo.
set /p SETUP_CHOICE=">> Select option [1-2]: "
if "%SETUP_CHOICE%"=="2" exit /b 0
if not "%SETUP_CHOICE%"=="1" goto :INSTALL_DEPENDENCIES

echo.
echo   ---------------------------------------------------------------------------------------------
echo   [*] 1/2 Downloading yt-dlp core engine...
curl.exe -L -o "%BIN_DIR%\yt-dlp.exe" "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
if not exist "%BIN_DIR%\yt-dlp.exe" (
    echo   [!] ERROR: Failed to download yt-dlp.exe. Check your internet connection.
    pause
    goto :MAIN_MENU
)

echo.
echo   [*] 2/2 Downloading and unpacking FFmpeg multimedia engine...
curl.exe -L -o "%BIN_DIR%\ffmpeg.zip" "https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
if exist "%BIN_DIR%\ffmpeg.zip" (
    echo   [*] Extracting FFmpeg binaries...
    where.exe tar >nul 2>&1
    if !errorlevel! equ 0 (
        tar.exe -xf "%BIN_DIR%\ffmpeg.zip" -C "%BIN_DIR%" --strip-components=2 "ffmpeg-master-latest-win64-gpl/bin/ffmpeg.exe" "ffmpeg-master-latest-win64-gpl/bin/ffprobe.exe" >nul 2>&1
    ) else (
        powershell -Command "Expand-Archive -Path '%BIN_DIR%\ffmpeg.zip' -DestinationPath '%BIN_DIR%\tmp' -Force; Move-Item '%BIN_DIR%\tmp\*\bin\*.exe' '%BIN_DIR%\'; Remove-Item '%BIN_DIR%\tmp' -Recurse -Force" >nul 2>&1
    )
    del /f /q "%BIN_DIR%\ffmpeg.zip" >nul 2>&1
)

echo.
echo   [+] Setup Complete! Core engines successfully installed in: %BIN_DIR%
ping 127.0.0.1 -n 2 >nul
goto :CHECK_DEPENDENCIES

:SHOW_BANNER
if exist "%BIN_DIR%\banner.txt" (
    type "%BIN_DIR%\banner.txt"
    exit /b 0
)
echo ====================================================================================================
echo   [+] YT DOWNLOADER GANG - [ CMD HACKER EDITION ]
echo ====================================================================================================
echo   Engine: yt-dlp [ACTIVE]   ::   FFmpeg: [ACTIVE]   ::   Save Dir: Downloads\
echo ====================================================================================================
exit /b 0

:MAIN_MENU
color %THEME_COLOR%
cls
call :SHOW_BANNER
echo.
echo   [1] Download Video  - MP4  (Best Ultra HD / 4K / 1080p 60FPS + Audio Merged)
echo   [2] Download Video  - MP4  (Standard 1080p/720p - Fast and Compact)
echo   [3] Download Music  - MP3  (Studio 320kbps + Album Artwork + ID3 Tags)
echo   [4] Download Audio  - M4A  (Original Bitrate - Instant Direct Extraction)
echo   [5] Download Playlist      (Batch download entire playlist as MP4 or MP3)
echo   [6] Custom Download        (Inspect stream formats and choose custom code)
echo   ---------------------------------------------------------------------------------------------
echo   [7] Open Downloads Folder
echo   [8] Update Core Engine     (Update yt-dlp to latest version)
echo   [9] Change Theme Color     (Green, Cyan, Red, Purple, Yellow, White)
echo   [0] Exit
echo.
echo ====================================================================================================
set /p MENU_CHOICE=">> Choose an option [0-9]: "

if "%MENU_CHOICE%"=="1" goto :DL_MP4_BEST
if "%MENU_CHOICE%"=="2" goto :DL_MP4_FAST
if "%MENU_CHOICE%"=="3" goto :DL_MP3
if "%MENU_CHOICE%"=="4" goto :DL_M4A
if "%MENU_CHOICE%"=="5" goto :DL_PLAYLIST
if "%MENU_CHOICE%"=="6" goto :DL_CUSTOM
if "%MENU_CHOICE%"=="7" goto :OPEN_FOLDER
if "%MENU_CHOICE%"=="8" goto :UPDATE_ENGINE
if "%MENU_CHOICE%"=="9" goto :THEME_SELECT
if "%MENU_CHOICE%"=="0" goto :QUIT

echo [!] Invalid selection. Please choose a number from 0 to 9.
ping 127.0.0.1 -n 2 >nul
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: URL PROMPT HELPER
:: --------------------------------------------------------------------------------------
:PROMPT_URL
set "TARGET_URL="
echo.
echo ----------------------------------------------------------------------------------------------------
set /p TARGET_URL=">> Paste YouTube URL (or type M to return to Menu): "
if /i "!TARGET_URL!"=="M" exit /b 1
if "!TARGET_URL!"=="" (
    echo [!] URL cannot be empty!
    goto :PROMPT_URL
)
:: Strip double quotes from pasted URL
set "TARGET_URL=!TARGET_URL:"=!"
exit /b 0

:: --------------------------------------------------------------------------------------
:: [1] MP4 BEST QUALITY
:: --------------------------------------------------------------------------------------
:DL_MP4_BEST
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo [*] Fetching and downloading BEST available MP4 (up to 4K/60FPS)...
echo [*] Destination: %DOWNLOADS_DIR%
echo ----------------------------------------------------------------------------------------------------
"%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
  -P "%DOWNLOADS_DIR%" ^
  -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" ^
  --merge-output-format mp4 ^
  --embed-thumbnail ^
  --embed-metadata ^
  --embed-chapters ^
  -o "%%(title)s [%%(resolution)s].%%(ext)s" ^
  "!TARGET_URL!"

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [2] MP4 BALANCED / 1080p
:: --------------------------------------------------------------------------------------
:DL_MP4_FAST
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo [*] Fetching and downloading Balanced MP4 (Max 1080p)...
echo [*] Destination: %DOWNLOADS_DIR%
echo ----------------------------------------------------------------------------------------------------
"%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
  -P "%DOWNLOADS_DIR%" ^
  -f "bv*[height<=1080][ext=mp4]+ba[ext=m4a]/b[height<=1080][ext=mp4] / bv*[height<=1080]+ba/b[height<=1080]" ^
  --merge-output-format mp4 ^
  --embed-thumbnail ^
  --embed-metadata ^
  -o "%%(title)s [1080p].%%(ext)s" ^
  "!TARGET_URL!"

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [3] MP3 320kbps HIGH QUALITY
:: --------------------------------------------------------------------------------------
:DL_MP3
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo [*] Extracting studio-quality MP3 (320kbps) with album artwork and metadata...
echo [*] Destination: %DOWNLOADS_DIR%
echo ----------------------------------------------------------------------------------------------------
"%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
  -P "%DOWNLOADS_DIR%" ^
  -x ^
  --audio-format mp3 ^
  --audio-quality 0 ^
  --embed-thumbnail ^
  --embed-metadata ^
  -o "%%(title)s.%%(ext)s" ^
  "!TARGET_URL!"

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [4] M4A FAST DIRECT
:: --------------------------------------------------------------------------------------
:DL_M4A
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo [*] Extracting original M4A audio stream (Ultra Fast)...
echo [*] Destination: %DOWNLOADS_DIR%
echo ----------------------------------------------------------------------------------------------------
"%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
  -P "%DOWNLOADS_DIR%" ^
  -x ^
  --audio-format m4a ^
  --embed-thumbnail ^
  --embed-metadata ^
  -o "%%(title)s.%%(ext)s" ^
  "!TARGET_URL!"

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [5] PLAYLIST DOWNLOADER
:: --------------------------------------------------------------------------------------
:DL_PLAYLIST
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo   [ PLAYLIST MODE ]
echo   [1] Download as MP4 Videos (Best Quality)
echo   [2] Download as MP3 Music (320kbps + Album Art)
echo   [M] Back to Main Menu
echo.
set /p PL_CHOICE=">> Select playlist format [1-2]: "
if /i "%PL_CHOICE%"=="M" goto :MAIN_MENU
if "%PL_CHOICE%"=="1" (
    echo.
    echo [*] Downloading entire playlist in MP4 Video into dedicated folder...
    "%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
      -P "%DOWNLOADS_DIR%" ^
      --yes-playlist ^
      -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" ^
      --merge-output-format mp4 ^
      --embed-thumbnail ^
      --embed-metadata ^
      -o "%%(playlist_title)s/%%(playlist_index)02d - %%(title)s.%%(ext)s" ^
      "!TARGET_URL!"
) else if "%PL_CHOICE%"=="2" (
    echo.
    echo [*] Downloading entire playlist in MP3 Audio into dedicated folder...
    "%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
      -P "%DOWNLOADS_DIR%" ^
      --yes-playlist ^
      -x ^
      --audio-format mp3 ^
      --audio-quality 0 ^
      --embed-thumbnail ^
      --embed-metadata ^
      -o "%%(playlist_title)s/%%(playlist_index)02d - %%(title)s.%%(ext)s" ^
      "!TARGET_URL!"
) else (
    echo [!] Invalid selection!
    ping 127.0.0.1 -n 2 >nul
    goto :DL_PLAYLIST
)

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [6] CUSTOM FORMAT INSPECT & DOWNLOAD
:: --------------------------------------------------------------------------------------
:DL_CUSTOM
call :PROMPT_URL
if errorlevel 1 goto :MAIN_MENU

echo.
echo [*] Querying available formats from YouTube servers...
echo ----------------------------------------------------------------------------------------------------
"%YTDLP%" -F "!TARGET_URL!"
echo ----------------------------------------------------------------------------------------------------
echo.
set /p FORMAT_CODE=">> Enter format code (e.g., 137+140 or 22 or best): "
if "!FORMAT_CODE!"=="" set "FORMAT_CODE=best"

echo.
echo [*] Downloading format [!FORMAT_CODE!]...
"%YTDLP%" --ffmpeg-location "%BIN_DIR%" ^
  -P "%DOWNLOADS_DIR%" ^
  -f "!FORMAT_CODE!" ^
  --embed-thumbnail ^
  --embed-metadata ^
  -o "%%(title)s [custom].%%(ext)s" ^
  "!TARGET_URL!"

call :CHECK_DOWNLOAD_STATUS
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [7] OPEN DOWNLOADS FOLDER
:: --------------------------------------------------------------------------------------
:OPEN_FOLDER
echo [*] Opening Downloads folder in Windows Explorer...
start "" "%DOWNLOADS_DIR%"
ping 127.0.0.1 -n 2 >nul
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [8] UPDATE ENGINE
:: --------------------------------------------------------------------------------------
:UPDATE_ENGINE
cls
echo ====================================================================================================
echo   [ CORE ENGINE UPDATER ]
echo ====================================================================================================
echo.
echo [*] Checking for yt-dlp updates...
"%YTDLP%" -U
echo.
echo [*] Update check complete!
pause
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: [9] THEME COLOR SELECTOR
:: --------------------------------------------------------------------------------------
:THEME_SELECT
cls
echo ====================================================================================================
echo   [ CMD THEME COLOR SELECTOR ]
echo ====================================================================================================
echo.
echo   [1] Matrix Green    (Classic Hacker)
echo   [2] Cyber Cyan      (Neo Tokyo)
echo   [3] Crimson Red     (Warning Red)
echo   [4] Deep Purple     (Synthwave)
echo   [5] Amber Yellow    (Retro CRT)
echo   [6] Pure White      (Minimalist Clean)
echo   [7] Return to Main Menu
echo.
set /p T_CHOICE=">> Choose theme color [1-7]: "
if "%T_CHOICE%"=="1" set "THEME_COLOR=0A"
if "%T_CHOICE%"=="2" set "THEME_COLOR=0B"
if "%T_CHOICE%"=="3" set "THEME_COLOR=0C"
if "%T_CHOICE%"=="4" set "THEME_COLOR=0D"
if "%T_CHOICE%"=="5" set "THEME_COLOR=0E"
if "%T_CHOICE%"=="6" set "THEME_COLOR=0F"
if "%T_CHOICE%"=="7" goto :MAIN_MENU
color %THEME_COLOR%
goto :MAIN_MENU

:: --------------------------------------------------------------------------------------
:: STATUS & ACTION HELPER
:: --------------------------------------------------------------------------------------
:CHECK_DOWNLOAD_STATUS
if %errorlevel% equ 0 (
    powershell -Command "[console]::beep(880, 100); [console]::beep(1320, 180)" >nul 2>&1
    echo.
    echo ====================================================================================================
    echo   [+] DOWNLOAD COMPLETED SUCCESSFULLY!
    echo   [+] Saved to: %DOWNLOADS_DIR%
    echo ====================================================================================================
) else (
    powershell -Command "[console]::beep(350, 300)" >nul 2>&1
    echo.
    echo ====================================================================================================
    echo   [!] DOWNLOAD FAILED OR WAS INTERRUPTED (Exit Code: %errorlevel%)
    echo   [!] Check your URL or run option [8] to update the engine.
    echo ====================================================================================================
)

echo.
echo   [1] Download Another Link
echo   [2] Open Downloads Folder
echo   [3] Return to Main Menu
echo.
set /p POST_ACTION=">> Choose next step [1-3]: "
if "%POST_ACTION%"=="2" (
    start "" "%DOWNLOADS_DIR%"
    goto :MAIN_MENU
)
if "%POST_ACTION%"=="3" goto :MAIN_MENU
exit /b 0

:QUIT
cls
echo.
echo   ====================================================================================
echo     Thanks for using YT DOWNLOADER GANG!
echo     Peace out.
echo   ====================================================================================
echo.
ping 127.0.0.1 -n 2 >nul
exit /b 0
