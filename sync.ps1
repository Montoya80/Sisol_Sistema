# Sisol_Sistema Auto-Sync Script
# Este script sincroniza los cambios locales con GitHub automáticamente.

function Sync-Git {
    Write-Host "Iniciando sincronización con GitHub..." -ForegroundColor Cyan
    
    # Refrescar entorno para asegurar que git y node están disponibles
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    
    # Verificar si el repo de GitHub existe, si no, crearlo (requiere login)
    $repoStatus = gh repo view --json name 2>$null | ConvertFrom-Json
    if (-not $repoStatus) {
        Write-Host "El repositorio no existe en GitHub. Intentando crear..." -ForegroundColor Yellow
        gh repo create Sisol_Sistema --public --source=. --remote=origin --push
    }
    else {
        # Agregar cambios
        git add .
        
        # Hacer commit con fecha/hora
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        git commit -m "Auto-sync: $timestamp"
        
        # Empujar cambios a ambas ramas
        git push origin master
        git push origin main
    }
    
    Write-Host "Sincronización completada con éxito." -ForegroundColor Green
}

# Ejecutar una vez
Sync-Git
