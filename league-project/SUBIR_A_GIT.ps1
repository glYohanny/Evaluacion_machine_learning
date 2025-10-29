# ============================================
# Script para subir solo archivos cruciales a Git
# Proyecto: League of Legends ML
# Autor: Pedro Torres
# Fecha: Octubre 2025
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   SUBIENDO ARCHIVOS CRUCIALES A GIT" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Navegar al directorio del proyecto
Set-Location -Path "league-project"

Write-Host "📂 Directorio actual: $(Get-Location)" -ForegroundColor Gray
Write-Host ""

# 1. Añadir .gitignore primero
Write-Host "[1/10] ✅ Añadiendo .gitignore..." -ForegroundColor Yellow
git add .gitignore

# 2. Añadir documentación principal
Write-Host "[2/10] 📚 Añadiendo documentación principal..." -ForegroundColor Yellow
git add README.md
git add GUIA_EJECUCION_COMPLETA.md
git add GUIA_GIT.md
if (Test-Path "INFORME_FINAL_ACADEMICO.md") {
    git add INFORME_FINAL_ACADEMICO.md
}
if (Test-Path "GUIA_PRESENTACION.md") {
    git add GUIA_PRESENTACION.md
}
if (Test-Path "EVALUACION_PARCIAL_CUMPLIMIENTO.md") {
    git add EVALUACION_PARCIAL_CUMPLIMIENTO.md
}
if (Test-Path "RESUMEN_EJECUTIVO.md") {
    git add RESUMEN_EJECUTIVO.md
}

# 3. Añadir código fuente
Write-Host "[3/10] 💻 Añadiendo código fuente..." -ForegroundColor Yellow
git add src/

# 4. Añadir tests
Write-Host "[4/10] 🧪 Añadiendo tests..." -ForegroundColor Yellow
git add tests/

# 5. Añadir configuración base
Write-Host "[5/10] ⚙️  Añadiendo configuración..." -ForegroundColor Yellow
git add conf/base/catalog.yml
git add conf/base/parameters.yml
git add conf/logging.yml
git add conf/README.md

# 6. Añadir Docker y Airflow
Write-Host "[6/10] 🐳 Añadiendo Docker y Airflow..." -ForegroundColor Yellow
git add Dockerfile
git add Dockerfile.airflow
git add docker-compose.yml
if (Test-Path ".dockerignore") {
    git add .dockerignore
}
git add airflow/dags/*.py
if (Test-Path "airflow/dags/README.md") {
    git add airflow/dags/README.md
}

# 7. Añadir scripts de automatización
Write-Host "[7/10] 🔧 Añadiendo scripts de automatización..." -ForegroundColor Yellow
git add setup_airflow_windows.ps1
git add run_kedro_pipeline.ps1
git add SUBIR_A_GIT.ps1
if (Test-Path "LIMPIAR_GIT.ps1") {
    git add LIMPIAR_GIT.ps1
}

# 8. Añadir archivos Python de configuración
Write-Host "[8/10] 🐍 Añadiendo configuración Python..." -ForegroundColor Yellow
git add requirements.txt
git add pyproject.toml
if (Test-Path "setup.py") {
    git add setup.py
}
if (Test-Path "Makefile") {
    git add Makefile
}

# 9. Añadir datos raw
Write-Host "[9/10] 📊 Añadiendo datos raw (CSVs)..." -ForegroundColor Yellow
git add data/01_raw/*.csv

# 10. Añadir carpetas vacías con .gitkeep
Write-Host "[10/10] 📁 Añadiendo estructura de carpetas (.gitkeep)..." -ForegroundColor Yellow
$folders = @(
    "data/02_intermediate",
    "data/03_primary",
    "data/04_feature",
    "data/05_model_input",
    "data/06_models",
    "data/07_model_output",
    "data/08_reporting",
    "conf/local",
    "airflow/logs",
    "airflow/config",
    "airflow/plugins"
)

foreach ($folder in $folders) {
    $gitkeepPath = Join-Path $folder ".gitkeep"
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }
    if (-not (Test-Path $gitkeepPath)) {
        New-Item -ItemType File -Path $gitkeepPath -Force | Out-Null
    }
    git add $gitkeepPath
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   ✅ ARCHIVOS AÑADIDOS CON ÉXITO" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Mostrar resumen
Write-Host "📊 Resumen de archivos añadidos:" -ForegroundColor Cyan
Write-Host ""
git status --short | Where-Object { $_ -match "^A" } | Measure-Object | ForEach-Object {
    Write-Host "   Total de archivos staged: $($_.Count)" -ForegroundColor White
}
Write-Host ""

# Mostrar estado completo
Write-Host "📋 Estado actual del repositorio:" -ForegroundColor Cyan
Write-Host ""
git status --short
Write-Host ""

# Verificar archivos que NO deben estar
Write-Host "⚠️  Verificando archivos que NO deberían estar..." -ForegroundColor Yellow
$unwanted = @()

# Verificar si hay archivos no deseados staged
$stagedFiles = git diff --cached --name-only

foreach ($file in $stagedFiles) {
    if ($file -match "(venv|__pycache__|\.pyc|\.log|data/0[2-8])" -and $file -notmatch "\.gitkeep") {
        $unwanted += $file
    }
}

if ($unwanted.Count -gt 0) {
    Write-Host ""
    Write-Host "❌ ADVERTENCIA: Se encontraron archivos no deseados staged:" -ForegroundColor Red
    foreach ($file in $unwanted) {
        Write-Host "   - $file" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "Ejecuta .\LIMPIAR_GIT.ps1 para removerlos" -ForegroundColor Yellow
} else {
    Write-Host "   ✅ No se encontraron archivos no deseados" -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "   📝 SIGUIENTES PASOS" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Hacer commit:" -ForegroundColor White
Write-Host '   git commit -m "Proyecto ML completo - League of Legends Worlds"' -ForegroundColor Gray
Write-Host ""
Write-Host "2. Subir a GitHub:" -ForegroundColor White
Write-Host '   git push origin main' -ForegroundColor Gray
Write-Host ""
Write-Host "3. (Opcional) Limpiar archivos innecesarios del repo:" -ForegroundColor White
Write-Host '   .\LIMPIAR_GIT.ps1' -ForegroundColor Gray
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Regresar al directorio padre
Set-Location ..

