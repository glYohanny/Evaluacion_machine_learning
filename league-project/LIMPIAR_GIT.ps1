# ============================================
# Script para limpiar archivos innecesarios del repositorio Git
# Proyecto: League of Legends ML
# Autor: Pedro Torres
# Fecha: Octubre 2025
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Red
Write-Host "   🧹 LIMPIANDO REPOSITORIO GIT" -ForegroundColor Red
Write-Host "============================================" -ForegroundColor Red
Write-Host ""

Write-Host "⚠️  ADVERTENCIA: Este script removerá archivos innecesarios del repositorio" -ForegroundColor Yellow
Write-Host "   Los archivos NO se borrarán de tu disco, solo se quitarán del tracking de Git" -ForegroundColor Gray
Write-Host ""

# Confirmar acción
$confirm = Read-Host "¿Continuar? (S/N)"
if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "Operación cancelada" -ForegroundColor Yellow
    exit
}

# Navegar al directorio del proyecto
Set-Location -Path "league-project"

Write-Host ""
Write-Host "📂 Directorio actual: $(Get-Location)" -ForegroundColor Gray
Write-Host ""

# ============================================
# 1. REMOVER DOCUMENTOS REDUNDANTES
# ============================================
Write-Host "[1/4] 📄 Removiendo documentos redundantes del repositorio..." -ForegroundColor Yellow

$redundantDocs = @(
    "README_COMPLETO.md",
    "README_KEDRO.md",
    "README_DOCKER_AIRFLOW.md",
    "QUICK_START.md",
    "KEDRO_USAGE.md",
    "DOCKER_AIRFLOW_GUIDE.md",
    "DEPLOYMENT_SUMMARY.md",
    "INSTRUCCIONES_EJECUCION.md",
    "INSTRUCCIONES_ARREGLAR_AIRFLOW.md",
    "SOLUCION_ERROR_AIRFLOW.md",
    "SOLUCION_FINAL_AIRFLOW.md",
    "CHECKLIST_DEPLOYMENT.md",
    "CHECKLIST_EVALUACION.md",
    "RESUMEN_EJECUTIVO.md",
    "EVALUACION_PARCIAL_CUMPLIMIENTO.md",
    "airflow/dags/README.md",
    "docs/GUIA_DATOS_CSV.md",
    "docs/RESUMEN_PIPELINES.md",
    "docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md"
)

$removedDocs = 0
foreach ($doc in $redundantDocs) {
    if (Test-Path $doc) {
        try {
            git rm --cached $doc 2>$null
            $removedDocs++
            Write-Host "   ✅ Removido: $doc" -ForegroundColor Green
        } catch {
            Write-Host "   ⚠️  No se pudo remover: $doc" -ForegroundColor Gray
        }
    }
}
Write-Host "   Total de documentos removidos: $removedDocs" -ForegroundColor White
Write-Host ""

# ============================================
# 2. REMOVER LOGS Y ARCHIVOS TEMPORALES
# ============================================
Write-Host "[2/4] 🗑️  Removiendo logs y archivos temporales..." -ForegroundColor Yellow

$tempFiles = @(
    "info.log",
    "logs/*",
    "*.log",
    "*.tmp",
    "*.bak"
)

$removedLogs = 0
foreach ($pattern in $tempFiles) {
    try {
        git rm --cached -r $pattern 2>$null
        $removedLogs++
    } catch {
        # Silenciar errores si el archivo no existe
    }
}
Write-Host "   ✅ Logs removidos" -ForegroundColor Green
Write-Host ""

# ============================================
# 3. REMOVER DATOS GENERADOS
# ============================================
Write-Host "[3/4] 📊 Removiendo datos generados (se regeneran con kedro run)..." -ForegroundColor Yellow

$dataFolders = @(
    "data/02_intermediate",
    "data/03_primary",
    "data/04_feature",
    "data/05_model_input",
    "data/06_models",
    "data/07_model_output",
    "data/08_reporting"
)

$removedData = 0
foreach ($folder in $dataFolders) {
    if (Test-Path $folder) {
        # Remover todo EXCEPTO .gitkeep
        Get-ChildItem -Path $folder -Recurse -File | Where-Object { $_.Name -ne ".gitkeep" } | ForEach-Object {
            try {
                git rm --cached $_.FullName 2>$null
                $removedData++
            } catch {
                # Silenciar errores
            }
        }
    }
}
Write-Host "   ✅ Datos generados removidos: $removedData archivos" -ForegroundColor Green
Write-Host ""

# ============================================
# 4. REMOVER ARCHIVOS DE AIRFLOW GENERADOS
# ============================================
Write-Host "[4/4] 🌊 Removiendo archivos generados de Airflow..." -ForegroundColor Yellow

$airflowGenerated = @(
    "airflow/logs",
    "airflow/config",
    "airflow/*.db",
    "airflow/*.pid",
    "airflow/*.cfg",
    "airflow/*.err",
    "airflow/*.out"
)

$removedAirflow = 0
foreach ($pattern in $airflowGenerated) {
    try {
        git rm --cached -r $pattern 2>$null
        $removedAirflow++
    } catch {
        # Silenciar errores si el archivo no existe
    }
}
Write-Host "   ✅ Archivos de Airflow removidos" -ForegroundColor Green
Write-Host ""

# ============================================
# 5. VERIFICAR .gitignore
# ============================================
Write-Host "📋 Verificando .gitignore..." -ForegroundColor Cyan
if (Test-Path ".gitignore") {
    Write-Host "   ✅ .gitignore existe" -ForegroundColor Green
    
    # Verificar que tenga las entradas importantes
    $gitignoreContent = Get-Content ".gitignore" -Raw
    $required = @("venv/", "__pycache__/", "*.log", "data/02_intermediate", "data/06_models")
    $missing = @()
    
    foreach ($entry in $required) {
        if ($gitignoreContent -notmatch [regex]::Escape($entry)) {
            $missing += $entry
        }
    }
    
    if ($missing.Count -gt 0) {
        Write-Host "   ⚠️  Faltan entradas importantes en .gitignore:" -ForegroundColor Yellow
        foreach ($item in $missing) {
            Write-Host "      - $item" -ForegroundColor Gray
        }
    } else {
        Write-Host "   ✅ .gitignore está completo" -ForegroundColor Green
    }
} else {
    Write-Host "   ❌ .gitignore NO existe (esto es un problema)" -ForegroundColor Red
}
Write-Host ""

# ============================================
# RESUMEN
# ============================================
Write-Host "============================================" -ForegroundColor Green
Write-Host "   ✅ LIMPIEZA COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

Write-Host "📊 Resumen de archivos removidos:" -ForegroundColor Cyan
Write-Host "   - Documentos redundantes: $removedDocs" -ForegroundColor White
Write-Host "   - Logs y temporales: $removedLogs patrones" -ForegroundColor White
Write-Host "   - Datos generados: $removedData archivos" -ForegroundColor White
Write-Host "   - Archivos de Airflow: $removedAirflow patrones" -ForegroundColor White
Write-Host ""

# Mostrar estado
Write-Host "📋 Estado actual del repositorio:" -ForegroundColor Cyan
Write-Host ""
git status --short
Write-Host ""

# Contar archivos trackeados
$trackedFiles = git ls-files | Measure-Object
Write-Host "📁 Total de archivos trackeados: $($trackedFiles.Count)" -ForegroundColor White
Write-Host ""

# ============================================
# SIGUIENTES PASOS
# ============================================
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "   📝 SIGUIENTES PASOS" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Los archivos han sido removidos del tracking de Git" -ForegroundColor White
Write-Host "pero NO se han borrado de tu disco local." -ForegroundColor Gray
Write-Host ""
Write-Host "Para aplicar los cambios:" -ForegroundColor White
Write-Host ""
Write-Host "1. Hacer commit de la limpieza:" -ForegroundColor Yellow
Write-Host '   git commit -m "Limpieza: Removidos archivos innecesarios del repositorio"' -ForegroundColor Gray
Write-Host ""
Write-Host "2. Subir cambios a GitHub:" -ForegroundColor Yellow
Write-Host '   git push origin main' -ForegroundColor Gray
Write-Host ""
Write-Host "3. Verificar el repositorio:" -ForegroundColor Yellow
Write-Host '   git ls-files | Measure-Object' -ForegroundColor Gray
Write-Host ""

Write-Host "NOTA: Los archivos removidos seguiran en tu disco local," -ForegroundColor Yellow
Write-Host "   solo se quitaron del seguimiento de Git." -ForegroundColor Yellow
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Regresar al directorio padre
Set-Location ..

