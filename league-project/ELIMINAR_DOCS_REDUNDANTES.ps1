# ============================================
# Script para eliminar documentación redundante
# Proyecto: League of Legends ML
# Autor: Pedro Torres
# Fecha: Octubre 2025
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "   🗑️  ELIMINAR DOCUMENTACIÓN REDUNDANTE" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "Este script eliminará 11 documentos redundantes." -ForegroundColor White
Write-Host "Solo se mantendrán 6 documentos esenciales." -ForegroundColor Gray
Write-Host ""

# Listar documentos a eliminar
Write-Host "📋 Documentos que se eliminarán:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Categoría Kedro (3 docs):" -ForegroundColor Yellow
Write-Host "  - README_KEDRO.md" -ForegroundColor Gray
Write-Host "  - KEDRO_USAGE.md" -ForegroundColor Gray
Write-Host "  - docs/RESUMEN_PIPELINES.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoría Airflow (5 docs):" -ForegroundColor Yellow
Write-Host "  - DEPLOYMENT_SUMMARY.md" -ForegroundColor Gray
Write-Host "  - CHECKLIST_DEPLOYMENT.md" -ForegroundColor Gray
Write-Host "  - INSTRUCCIONES_EJECUCION.md" -ForegroundColor Gray
Write-Host "  - INSTRUCCIONES_ARREGLAR_AIRFLOW.md" -ForegroundColor Gray
Write-Host "  - airflow/dags/README.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoría Quick Start (1 doc):" -ForegroundColor Yellow
Write-Host "  - QUICK_START.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Categoría Datos (2 docs):" -ForegroundColor Yellow
Write-Host "  - docs/GUIA_DATOS_CSV.md" -ForegroundColor Gray
Write-Host "  - docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md" -ForegroundColor Gray
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "📌 Documentos que se MANTENDRÁN:" -ForegroundColor Green
Write-Host "  ✅ README.md" -ForegroundColor White
Write-Host "  ✅ GUIA_EJECUCION_COMPLETA.md" -ForegroundColor White
Write-Host "  ✅ GUIA_GIT.md" -ForegroundColor White
Write-Host "  ✅ INSTRUCCIONES_RAPIDAS_GIT.md" -ForegroundColor White
Write-Host "  ✅ INFORME_FINAL_ACADEMICO.md" -ForegroundColor White
Write-Host "  ✅ conf/README.md" -ForegroundColor White
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Confirmar acción
$confirm = Read-Host "¿Continuar con la eliminación? (S/N)"
if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host ""
    Write-Host "❌ Operación cancelada" -ForegroundColor Yellow
    Write-Host ""
    exit
}

Write-Host ""
Write-Host "Iniciando eliminación..." -ForegroundColor Yellow
Write-Host ""

# Navegar al directorio del proyecto
Set-Location -Path "league-project"

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
            Write-Host "  ✅ Eliminado: $archivo" -ForegroundColor Green
            $eliminados++
        } catch {
            Write-Host "  ❌ Error al eliminar: $archivo" -ForegroundColor Red
        }
    } else {
        Write-Host "  ⚠️  No encontrado: $archivo" -ForegroundColor Gray
        $noEncontrados++
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   ✅ ELIMINACIÓN COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Resumen
Write-Host "📊 Resumen:" -ForegroundColor Cyan
Write-Host "  - Archivos eliminados: $eliminados" -ForegroundColor White
Write-Host "  - Archivos no encontrados: $noEncontrados" -ForegroundColor Gray
Write-Host ""

# Verificar documentos restantes
Write-Host "📋 Documentos .md restantes en el proyecto:" -ForegroundColor Cyan
Write-Host ""

$docsRestantes = Get-ChildItem -Path . -Filter "*.md" -Recurse | Where-Object { 
    $_.FullName -notmatch "node_modules|venv|__pycache__|\.git"
}

$docsRestantes | ForEach-Object {
    $relativePath = $_.FullName.Replace((Get-Location).Path + "\", "")
    Write-Host "  📄 $relativePath" -ForegroundColor White
}

Write-Host ""
Write-Host "  Total: $($docsRestantes.Count) documentos" -ForegroundColor White
Write-Host ""

# Verificar si es la cantidad esperada
if ($docsRestantes.Count -le 8) {
    Write-Host "✅ Cantidad de documentos es correcta (≤8)" -ForegroundColor Green
} else {
    Write-Host "⚠️  Todavía hay $($docsRestantes.Count) documentos (esperados: ~6-8)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   📝 SIGUIENTES PASOS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Los archivos han sido eliminados de tu disco local." -ForegroundColor White
Write-Host ""

Write-Host "Opciones:" -ForegroundColor Yellow
Write-Host ""

Write-Host "1️⃣  Si estos archivos NO estaban en Git:" -ForegroundColor Cyan
Write-Host "   No necesitas hacer nada más." -ForegroundColor Gray
Write-Host ""

Write-Host "2️⃣  Si estos archivos SÍ estaban en Git:" -ForegroundColor Cyan
Write-Host "   Debes removerlos del repositorio:" -ForegroundColor Gray
Write-Host ""
Write-Host "   git rm --cached README_KEDRO.md KEDRO_USAGE.md QUICK_START.md" -ForegroundColor White
Write-Host "   git rm --cached DEPLOYMENT_SUMMARY.md CHECKLIST_DEPLOYMENT.md" -ForegroundColor White
Write-Host "   git rm --cached INSTRUCCIONES_EJECUCION.md INSTRUCCIONES_ARREGLAR_AIRFLOW.md" -ForegroundColor White
Write-Host "   git rm --cached 'airflow/dags/README.md'" -ForegroundColor White
Write-Host "   git rm --cached 'docs/GUIA_DATOS_CSV.md'" -ForegroundColor White
Write-Host "   git rm --cached 'docs/RESUMEN_PIPELINES.md'" -ForegroundColor White
Write-Host "   git rm --cached 'docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md'" -ForegroundColor White
Write-Host ""
Write-Host "   git commit -m 'Limpieza: Eliminada documentacion redundante (18 a 6 docs)'" -ForegroundColor White
Write-Host "   git push origin main" -ForegroundColor White
Write-Host ""

Write-Host "3️⃣  Verificar documentos restantes:" -ForegroundColor Cyan
Write-Host "   cat README.md" -ForegroundColor White
Write-Host "   cat GUIA_EJECUCION_COMPLETA.md" -ForegroundColor White
Write-Host "   cat GUIA_GIT.md" -ForegroundColor White
Write-Host ""

Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Crear un resumen en archivo
$resumenPath = "RESUMEN_ELIMINACION.txt"
$resumen = @"
================================================================
RESUMEN DE ELIMINACIÓN DE DOCUMENTACIÓN REDUNDANTE
================================================================

Fecha: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

ARCHIVOS ELIMINADOS: $eliminados
- README_KEDRO.md
- KEDRO_USAGE.md
- QUICK_START.md
- DEPLOYMENT_SUMMARY.md
- CHECKLIST_DEPLOYMENT.md
- INSTRUCCIONES_EJECUCION.md
- INSTRUCCIONES_ARREGLAR_AIRFLOW.md
- airflow/dags/README.md
- docs/GUIA_DATOS_CSV.md
- docs/RESUMEN_PIPELINES.md
- docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md

ARCHIVOS NO ENCONTRADOS: $noEncontrados

DOCUMENTOS RESTANTES: $($docsRestantes.Count)
"@

foreach ($doc in $docsRestantes) {
    $relativePath = $doc.FullName.Replace((Get-Location).Path + "\", "")
    $resumen += "`n- $relativePath"
}

$resumen += @"

================================================================
SIGUIENTES PASOS:
================================================================

1. Verificar que los documentos esenciales están completos:
   - README.md
   - GUIA_EJECUCION_COMPLETA.md
   - GUIA_GIT.md
   - INSTRUCCIONES_RAPIDAS_GIT.md
   - INFORME_FINAL_ACADEMICO.md
   - conf/README.md

2. Si los archivos estaban en Git, removerlos:
   git rm --cached [archivos eliminados]
   git commit -m "Limpieza: Eliminada documentación redundante"
   git push origin main

3. Leer el análisis completo:
   cat ANALISIS_REDUNDANCIA.md

================================================================
"@

Set-Content -Path $resumenPath -Value $resumen -Encoding UTF8

Write-Host "📄 Resumen guardado en: $resumenPath" -ForegroundColor Cyan
Write-Host ""

# Regresar al directorio padre
Set-Location ..

Write-Host "✅ Proceso completado" -ForegroundColor Green
Write-Host ""

