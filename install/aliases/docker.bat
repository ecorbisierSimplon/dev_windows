@echo off
set key=%1
if "%key%"=="run" (
    "C:\Program Files\Docker\Docker\Docker Desktop.exe"
) else if "%key%"=="up" (
    docker compose up
) else if "%key%"=="up-d" (
    docker compose up -d
) else if "%key%"=="up-f" (
    docker-compose up --force-recreate -d
) else if "%key%"=="sp" (
    docker system prune
) else if "%key%"=="c" (
    docker compose %2
) else if "%key%"=="c-" (
    docker-compose %2
) else (
    gh %*
)
