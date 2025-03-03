# principal.ps1

# Importar los scripts de funciones y mensajes
. .\funciones.ps1
. .\mensajes.ps1

# Mostrar mensaje de inicio
MensajeInicio

# Menú de opciones
while ($true) {
    Write-Host "Selecciona una opcion:"
    Write-Host "1. Instalar cliente SSH"
    Write-Host "2. Conectar al servidor SSH"
    Write-Host "3. Salir"
    $opcion = Read-Host "Opcion"

    switch ($opcion) {
        1 {
            InstalarClienteSSH
        }
        2 {
            ConectarSSH
        }
        3 {
            Write-Host "Saliendo..."
            break
        }
        default {
            Write-Host "Opcion no valida. Intenta de nuevo."
        }
    }
}

# Mostrar mensaje de éxito
MensajeExito
