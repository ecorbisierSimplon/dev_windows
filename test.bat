@echo off
setlocal enabledelayedexpansion

set "original_path=%PATH%"
echo.
echo !original_path!
echo.

:: Initialiser des variables
set "new_path="
set "separator=;"

:: Boucler à travers chaque entrée du PATH
for %%i in ("%original_path:;=" "%") do (
    if "!new_path!"=="" (
        set "new_path=%%~i"
    ) else (
        echo !new_path! | findstr /i /c:";%%~i;" >nul
        if !errorlevel! neq 0 (
            set "new_path=!new_path!%separator%%%~i"
        )
    )
)

:: Afficher le nouveau chemin
echo !new_path!
echo.

:: Facultatif : Enregistrer le nouveau chemin dans une variable d'environnement
setx PATH "%new_path%;C:/aliases"
echo.

endlocal
