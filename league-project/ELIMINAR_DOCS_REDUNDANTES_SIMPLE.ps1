# ============================================
# Script para eliminar documentacion redundante
# Proyecto: League of Legends ML
# Autor: Pedro Torres
# Fecha: Octubre 2025
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "ELIMINAR DOCUMENTACION REDUNDANTE" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "Este script eliminara 11 documentos redundantes." -ForegroundColor White
Write-Host "Solo se mantendran 6 documentos esenciales." -ForegroundColor Gray
Write-Host ""

# Listar documentos a eliminar
Write-Host "Documentos que se eliminaran:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Categoria Kedro (3 docs):" -ForegroundColor Yellow
Write-Host "  - README_KEDRO.md" -ForegroundColor Gray
Write-Host "  - KEDRO_USAGE.md" -ForegroundColor Gray
Write-Host "  - docs/RESUMEN_PIPELINES.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoria Airflow (5 docs):" -ForegroundColor Yellow
Write-Host "  - DEPLOYMENT_SUMMARY.md" -ForegroundColor Gray
Write-Host "  - CHECKLIST_DEPLOYMENT.md" -ForegroundColor Gray
Write-Host "  - INSTRUCCIONES_EJECUCION.md" -ForegroundColor Gray
Write-Host "  - INSTRUCCIONES_ARREGLAR_AIRFLOW.md" -ForegroundColor Gray
Write-Host "  - airflow/dags/README.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoria Quick Start (1 doc):" -ForegroundColor Yellow
Write-Host "  - QUICK_START.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoria Datos (2 docs):" -ForegroundColor Yellow
Write-Host "  - docs/GUIA_DATOS_CSV.md" -ForegroundColor Gray
Write-Host "  - docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md" -ForegroundColor Gray
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Documentos que se MANTENDRAN:" -ForegroundColor Green
Write-Host "  [OK] README.md" -ForegroundColor White
Write-Host "  [OK] GUIA_EJECUCION_COMPLETA.md" -ForegroundColor White
Write-Host "  [OK] GUIA_GIT.md" -ForegroundColor White
Write-Host "  [OK] INSTRUCCIONES_RAPIDAS_GIT.md" -ForegroundColor White
Write-Host "  [OK] INFORME_FINAL_ACADEMICO.md" -ForegroundColor White
Write-Host "  [OK] conf/README.md" -ForegroundColor White
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Confirmar accion
$confirm = Read-Host "Continuar con la eliminacion? (S/N)"
if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host ""
    Write-Host "[!] Operacion cancelada" -ForegroundColor Yellow
    Write-Host ""
    exit
}

Write-Host ""
Write-Host "Iniciando eliminacion..." -ForegroundColor Yellow
Write-Host ""

# Contador
$eliminados = 0
$noEncontrados = 0

# ============================================
# ELIMINAR DOCUMENTOS REDUNDANTES
# ============================================

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
Write-Host "   ELIMINACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Resumen
Write-Host "Resumen:" -ForegroundColor Cyan
Write-Host "  - Archivos eliminados: $eliminados" -ForegroundColor White
Write-Host "  - Archivos no encontrados: $noEncontrados" -ForegroundColor Gray
Write-Host ""

# Verificar documentos restantes
Write-Host "Documentos .md restantes en el proyecto:" -ForegroundColor Cyan
Write-Host ""

$docsRestantes = Get-ChildItem -Path . -Filter "*.md" -Recurse | Where-Object { 
    $_.FullName -notmatch "node_modules|venv|__pycache__|\.git"
}

$docsRestantes | ForEach-Object {
    $relativePath = $_.FullName.Replace((Get-Location).Path + "\", "")
    Write-Host "  [FILE] $relativePath" -ForegroundColor White
}

Write-Host ""
Write-Host "  Total: $($docsRestantes.Count) documentos" -ForegroundColor White
Write-Host ""

# Verificar si es la cantidad esperada
if ($docsRestantes.Count -le 8) {
    Write-Host "[OK] Cantidad de documentos es correcta (<= 8)" -ForegroundColor Green
} else {
    Write-Host "[!] Todavia hay $($docsRestantes.Count) documentos (esperados: ~6-8)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   SIGUIENTES PASOS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Los archivos han sido eliminados de tu disco local." -ForegroundColor White
Write-Host ""

Write-Host "Opciones:" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. Si estos archivos NO estaban en Git:" -ForegroundColor Cyan
Write-Host "   No necesitas hacer nada mas." -ForegroundColor Gray
Write-Host ""

Write-Host "2. Si estos archivos SI estaban en Git:" -ForegroundColor Cyan
Write-Host "   Debes removerlos del repositorio:" -ForegroundColor Gray
Write-Host ""
Write-Host "   git rm --cached README_KEDRO.md KEDRO_USAGE.md QUICK_START.md" -ForegroundColor White
Write-Host "   git rm --cached DEPLOYMENT_SUMMARY.md CHECKLIST_DEPLOYMENT.md" -ForegroundColor White
Write-Host "   git rm --cached INSTRUCCIONES_EJECUCION.md INSTRUCCIONES_ARREGLAR_AIRFLOW.md" -ForegroundColor White
Write-Host "   git rm --cached airflow/dags/README.md" -ForegroundColor White
Write-Host "   git rm --cached docs/GUIA_DATOS_CSV.md" -ForegroundColor White
Write-Host "   git rm --cached docs/RESUMEN_PIPELINES.md" -ForegroundColor White
Write-Host "   git rm --cached docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md" -ForegroundColor White
Write-Host ""
Write-Host "   git commit -m 'Limpieza: Eliminada documentacion redundante (18 a 6 docs)'" -ForegroundColor White
Write-Host "   git push origin main" -ForegroundColor White
Write-Host ""

Write-Host "3. Verificar documentos restantes:" -ForegroundColor Cyan
Write-Host "   cat README.md" -ForegroundColor White
Write-Host "   cat GUIA_EJECUCION_COMPLETA.md" -ForegroundColor White
Write-Host "   cat GUIA_GIT.md" -ForegroundColor White
Write-Host ""

Write-Host "============================================" -ForegroundColor Green
Write-Host ""

Write-Host "[OK] Proceso completado" -ForegroundColor Green
Write-Host ""

