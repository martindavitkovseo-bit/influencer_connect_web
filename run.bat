@echo off
REM Influencer Connect Web - Setup and Run Script for Windows

echo ======================================
echo Influencer Connect Web Platform
echo ======================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Flutter is not installed. Please install from https://flutter.dev
    exit /b 1
)

echo Flutter found
echo.

REM Get dependencies
echo Installing dependencies...
call flutter pub get

if %errorlevel% neq 0 (
    echo Error: Failed to install dependencies
    exit /b 1
)

echo Dependencies installed
echo.

REM Show menu
echo Choose an option:
echo 1 - Run development server (local)
echo 2 - Build for web (release)
echo 3 - Install dependencies only
echo.
set /p choice="Select option (1-3): "

if "%choice%"=="1" (
    echo.
    echo Starting development server...
    echo The app will open at http://localhost:5000
    echo.
    call flutter run -d chrome
) else if "%choice%"=="2" (
    echo.
    echo Building for production...
    call flutter build web --release
    echo Build complete! Output: build/web/
) else if "%choice%"=="3" (
    echo Dependencies installed
) else (
    echo Invalid option
    exit /b 1
)

echo.
echo ======================================
echo Done!
echo ======================================
