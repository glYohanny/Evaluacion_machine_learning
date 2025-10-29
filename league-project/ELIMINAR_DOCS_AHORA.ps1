# ============================================
# Script para eliminar documentacion redundante
# VERSION DIRECTA - Sin confirmacion
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "ELIMINANDO DOCUMENTACION REDUNDANTE" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""

# Contador
$eliminados = 0
$noEncontrados = 0

# Array de archivos a eliminar
$archivosAEliminar = @(
    "README_KEDRO.md",
    "KEDRO_USAGE.md",
    "QUICK_START.md",
    "DEPLOYMENT_SUMMARY.md",
    "CHECKLIST_DEPLOYMENT.md",
    "INSTRUCCIONES_EJECUCION.md",
    "INSTRUCCIONES_ARREGLAR_AIRFLOW.md",
    "airflow/dags/README.md",
    "docs/GUIA_DATOS_CSV.md",
    "docs/RESUMEN_PIPELINES.md",
    "docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md"
)

Write-Host "Eliminando archivos redundantes..." -ForegroundColor Yellow
Write-Host ""

foreach ($archivo in $archivosAEliminar) {
    if (Test-Path $archivo) {
        try {
            Remove-Item -Path $archivo -Force
            Write-Host "  [OK] Eliminado: $archivo" -ForegroundColor Green
            $eliminados++
        } catch {
            Write-Host "  [X] Error al eliminar: $archivo" -ForegroundColor Red
        }
    } else {
        Write-Host "  [!] No encontrado: $archivo" -ForegroundColor Gray
        $noEncontrados++
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "ELIMINACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

Write-Host "Resumen:" -ForegroundColor Cyan
Write-Host "  - Archivos eliminados: $eliminados" -ForegroundColor White
Write-Host "  - Archivos no encontrados: $noEncontrados" -ForegroundColor Gray
Write-Host ""

# Verificar documentos restantes
Write-Host "Documentos .md restantes:" -ForegroundColor Cyan
Write-Host ""

$docsRestantes = Get-ChildItem -Path . -Filter "*.md" -Recurse | Where-Object { 
    $_.FullName -notmatch "node_modules|venv|__pycache__|\.git"
}

$docsRestantes | ForEach-Object {
    $relativePath = $_.FullName.Replace((Get-Location).Path + "\", "")
    Write-Host "  [FILE] $relativePath" -ForegroundColor White
}

Write-Host ""
Write-Host "Total de documentos: $($docsRestantes.Count)" -ForegroundColor White
Write-Host ""

if ($docsRestantes.Count -le 10) {
    Write-Host "[OK] Cantidad de documentos es correcta" -ForegroundColor Green
} else {
    Write-Host "[!] Todavia hay $($docsRestantes.Count) documentos" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "SIGUIENTES PASOS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Si algunos archivos estaban en Git, removerlos:" -ForegroundColor Yellow
Write-Host ""
Write-Host "git rm --cached README_KEDRO.md KEDRO_USAGE.md QUICK_START.md" -ForegroundColor White
Write-Host "git rm --cached DEPLOYMENT_SUMMARY.md CHECKLIST_DEPLOYMENT.md" -ForegroundColor White
Write-Host "git rm --cached INSTRUCCIONES_EJECUCION.md INSTRUCCIONES_ARREGLAR_AIRFLOW.md" -ForegroundColor White
Write-Host "git rm --cached airflow/dags/README.md" -ForegroundColor White
Write-Host "git rm --cached docs/GUIA_DATOS_CSV.md docs/RESUMEN_PIPELINES.md" -ForegroundColor White
Write-Host "git rm --cached docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md" -ForegroundColor White
Write-Host ""
Write-Host "git commit -m 'Limpieza: Eliminada documentacion redundante'" -ForegroundColor White
Write-Host "git push origin main" -ForegroundColor White
Write-Host ""

Write-Host "[OK] Proceso completado" -ForegroundColor Green
Write-Host ""

