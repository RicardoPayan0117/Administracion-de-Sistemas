# Función para instalar y comprobar Apache
function instalar_apache {
    param (
        [int]$puerto
    )

    if (Get-Service -Name "httpd" -ErrorAction SilentlyContinue) {
        Write-Host "Apache ya está instalado." -ForegroundColor $VERDE
    } else {
        Write-Host "Instalando Apache..." -ForegroundColor $AMARILLO
        try {
            Invoke-WebRequest -Uri "https://www.apachelounge.com/download/VS16/binaries/httpd-2.4.58-win64-VS16.zip" -OutFile "$env:TEMP\httpd.zip"
            Expand-Archive -Path "$env:TEMP\httpd.zip" -DestinationPath "C:\Apache24"
            Remove-Item -Path "$env:TEMP\httpd.zip"
        } catch {
            Write-Host "Error: No se pudo instalar Apache. Detalles: $($_.Exception.Message)" -ForegroundColor $ROJO
            return
        }
    }

    try {
        Copy-Item -Path "C:\Apache24\conf\httpd.conf" -Destination "C:\Apache24\conf\httpd.conf.bak"
        (Get-Content "C:\Apache24\conf\httpd.conf") -replace "Listen\s+\d+", "Listen $puerto" | Set-Content "C:\Apache24\conf\httpd.conf"
    } catch {
        Write-Host "Error: No se pudo configurar Apache. Detalles: $($_.Exception.Message)" -ForegroundColor $ROJO
        return
    }

    Start-Service -Name "httpd" -ErrorAction SilentlyContinue
    if (Get-Service -Name "httpd" | Where-Object { $_.Status -eq 'Running' }) {
        Write-Host "✓ Apache funcionando en el puerto $puerto" -ForegroundColor $VERDE
    } else {
        Write-Host "✗ Error al iniciar Apache." -ForegroundColor $ROJO
    }
} # Llave de cierre añadida para la función instalar_apache


# Función para instalar Nginx
function instalar_nginx {
    param (
        [int]$puerto
    )

    $nginx_home = "C:\nginx"

    Write-Host "Instalando Nginx..." -ForegroundColor $AMARILLO
    try {
        Invoke-WebRequest -Uri "https://nginx.org/download/nginx-1.24.0.zip" -OutFile "$env:TEMP\nginx.zip"
        Expand-Archive -Path "$env:TEMP\nginx.zip" -DestinationPath $nginx_home
        Remove-Item -Path "$env:TEMP\nginx.zip"
    } catch {
        Write-Host "Error: No se pudo instalar Nginx. Detalles: $($_.Exception.Message)" -ForegroundColor $ROJO
        return
    }

    try {
        (Get-Content "$nginx_home\conf\nginx.conf") -replace "listen\s+80;", "listen $puerto;" | Set-Content "$nginx_home\conf\nginx.conf"
    } catch {
        Write-Host "Error: No se pudo configurar Nginx. Detalles: $($_.Exception.Message)" -ForegroundColor $ROJO
        return
    }

    New-Service -Name "Nginx" -BinaryPathName "$nginx_home\nginx.exe" -DisplayName "Nginx Web Server" -Description "Servidor web Nginx"
    Start-Service -Name "Nginx"
    Write-Host "✓ Nginx funcionando en el puerto $puerto" -ForegroundColor $VERDE
    Write-Host "Puede acceder a Nginx en: http://localhost:$puerto" -ForegroundColor $VERDE
} # Llave de cierre añadida para la función instalar_nginx

