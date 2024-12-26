@echo off
chcp 65001 >nul

cls

set source=".\install\aliases"
set destination="C:\aliases"

echo ☑ Copie du dossier %source% vers %destination%...
xcopy %source% %destination% /E /I /Y >nul

echo 🟢 Copie terminée !
echo.

echo ☑ Vérification si C:\aliases est dans la variable PATH...

echo %PATH% | findstr /I /C:"C:\aliases" >nul

if %errorlevel%==0 (
    echo 🟢 C:\aliases existe déjà dans la variable PATH.
) else (
    echo 🔴 C:\aliases n'est pas dans la variable PATH.
	setx PATH "%PATH%;C:\aliases" >nul
    echo 🟢 C:\aliases est créée dans la variable PATH.
)
echo.

@REM pause