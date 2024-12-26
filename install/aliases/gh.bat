@echo off
set key=%1
if "%key%"=="c" (
    gh issue create
) else (
    gh %*
)
