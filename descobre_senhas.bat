@echo off
setlocal enabledelayedexpansion

for /f "tokens=*: delims=" %%A in ('netsh wlan show profiles') do (
    echo %%A | findstr /c:"Todos os Perfis de Usuários" >nul
    if not errorlevel 1 (
        set "wifi_name=%%A"
        set "wifi_name=!wifi_name:~36!"
        
        for /f "tokens=*: delims=" %%B in ('netsh wlan show profile name^="!wifi_name!" key^=clear') do (
            echo %%B | findstr /c:"Conteúdo da Chave" >nul
            if not errorlevel 1 (
                set "senha=%%B"
                set "senha=!senha:~24!"
                echo wi-fi: !wifi_name!                  |   Senha: !senha!
            )
        )
    )
)
pause
