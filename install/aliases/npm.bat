@echo off
set key=%1
if "%key%"=="d" (
    npm run dev -- --open
) else if "%key%"=="b" (
    npm run build
) else if "%key%"=="t" (
    npm run test %2
) else if "%key%"=="i" (
    npm install
) else (
    npm %*
)
