# Script para iniciar la aplicación Sputnik Core
Write-Host "Iniciando aplicación Sputnik Core..."
Write-Host "Verificando puerto 8080..."

# Matar cualquier proceso en el puerto 8080
$processes = Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue
if ($processes) {
    Write-Host "Matando procesos en puerto 8080..."
    $processes | ForEach-Object { Stop-Process -Id $_.OwningProcess -Force }
    Start-Sleep -Seconds 2
}

# Ejecutar la aplicación
Write-Host "Ejecutando aplicación..."
gradle bootRun --args='--spring.profiles.active=dev'
