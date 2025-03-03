# funciones.ps1

function InstalarClienteSSH {
    Write-Host "Instalando el cliente SSH..."
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
}

function ConectarSSH {
    Write-Host "Ingresa la dirección IP del servidor SSH:"
    $server_ip = Read-Host
    Write-Host "Ingresa el nombre de usuario en el servidor SSH:"
    $username = Read-Host
    Write-Host "Conectando al servidor SSH..."
    ssh "$username@$server_ip"
}
