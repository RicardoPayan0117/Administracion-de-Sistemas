# mensajes.ps1

function MensajeInicio {
    Write-Host "Bienvenido al script de configuracion del servidor DHCP en Windows Server 2025!"
}

function MensajeExito {
    Write-Host "Servidor DHCP configurado correctamente y en ejecucion." -ForegroundColor Green
}

function MensajeError {
    Write-Host "Hubo un error durante la configuracion. Por favor, revisa los logs." -ForegroundColor Red
}

function MensajeSubredInvalida {
    Write-Host "Error: La direccion de red ingresada no es valida. Debe estar en formato CIDR (ej. 192.168.1.0/24)." -ForegroundColor Red
}

function MensajeIpInvalida {
    Write-Host "Error: La direccion IP ingresada no es valida." -ForegroundColor Red
}

function MensajeMascaraInvalida {
    Write-Host "Error: La mascara de subred ingresada no es valida." -ForegroundColor Red
}

function MensajeDuracionInvalida {
    Write-Host "Error: La duración de la concesion debe ser un numero entero." -ForegroundColor Red
}
