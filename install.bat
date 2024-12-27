@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

cls

set source=.\install\aliases
set destination=C:\aliases

echo ☑ Copie du dossier '%source%' vers '%destination%' ...
xcopy %source% %destination% /E /I /Y >nul

echo 🟢 Copie terminée !
echo.


echo ☑ Vérification si '%destination%' est dans la variable PATH...
echo.

echo %PATH% | findstr /I /C:"%destination%" >null
@REM echo %PATH% | findstr /I /C:"C:\aliases"

if %errorlevel%==0 (
    echo 🟢 '%destination%' existe déjà dans la variable PATH.

) else (

    echo 🔴 '%destination%' n'est pas dans la variable PATH.

    set "original_path=%PATH%"
    echo.
    @REM echo !original_path!
    @REM echo.


    @REM :: Initialiser des variables
    set "new_path="
    set "separator=;"

    @REM :: Boucler à travers chaque entrée du PATH
    for %%i in ("!original_path:;=" "!") do (
        if "!new_path!"=="" (
            set "new_path=%%~i"
        ) else (
            echo !new_path! | findstr /i /c:";%%~i;" >nul
            if !errorlevel! neq 0 (
                set "new_path=!new_path!!separator!%%~i"
            )
        )
    )
    @REM :: Afficher le nouveau chemin
    @REM echo !new_path!
    @REM echo.

    @REM :: Facultatif : Enregistrer le nouveau chemin dans une variable d'environnement
    setx PATH "!new_path!;%destination%"

    echo.

    echo 🟢 '%destination%' est créée dans la variable PATH.
    echo.
    @REM :: Demander à l'utilisateur s'il souhaite redémarrer le PC
    echo Veuillez redémarrer le PC pour activer la variable d'environnement
    choice /M "Voulez vous redémarrer maintenant "

    if %errorlevel%==1 (
        echo Redémarrage en cours...
        shutdown /r /t 0
    ) else (
        echo Redémarrage annulé.
    )
)
echo.





endlocal