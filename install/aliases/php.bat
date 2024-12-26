@echo off
set key=%1
if "%key%"=="r" (
    composer require %2
) else if "%key%"=="m" (
    php bin\console make:%2
) else if "%key%"=="c" (
    php bin\console make:controller %2
) else if "%key%"=="e" (
    php bin\console make:entity %2
) else if "%key%"=="b" (
    php bin\console %2
) else if "%key%"=="d" (
    php bin\console doctrine:%2
) else if "%key%"=="df" (
    php bin\console doctrine:fixtures:load
) else if "%key%"=="crud" (
    php bin\console make:crud %2
) else if "%key%"=="mm" (
    php bin\console make:migration
) else if "%key%"=="dm" (
    php bin\console doctrine:migration:migrate
) else if "%key%"=="mdm" (
    php bin\console make:migration
    php bin\console doctrine:migration:migrate
) else if "%key%"=="cdb" (
    php bin\console doctrine:database:create
    php bin\console make:migration
    php bin\console doctrine:migration:migrate
) else (
    echo La commande "%*" nest pas une commande PHP
    echo Essayez avec "php %*"
)
