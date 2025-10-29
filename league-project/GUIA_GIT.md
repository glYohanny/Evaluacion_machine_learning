# 🚀 Guía Completa: Gestión de Git para el Proyecto

## 📊 Resumen de Archivos

### ✅ Archivos CRUCIALES (Deben estar en Git)

#### **Código Fuente:**
```
src/league_project/          → Todo el código Python
tests/                       → Tests del proyecto
```

#### **Configuración:**
```
conf/base/catalog.yml        → Catálogo de datos Kedro
conf/base/parameters.yml     → Parámetros del proyecto
conf/logging.yml             → Configuración de logs
pyproject.toml               → Configuración Python
requirements.txt             → Dependencias
.gitignore                   → Archivos a ignorar
```

#### **Datos Raw:**
```
data/01_raw/*.csv            → 8 archivos CSV originales
```

#### **Docker y Airflow:**
```
Dockerfile                   → Contenedor Kedro
Dockerfile.airflow           → Contenedor Airflow
docker-compose.yml           → Orquestación
airflow/dags/*.py            → DAGs de Airflow (3 archivos)
```

#### **Documentación:**
```
README.md                    → Documentación principal
GUIA_EJECUCION_COMPLETA.md   → Guía de ejecución
INFORME_FINAL_ACADEMICO.md   → Informe académico
```

#### **Scripts:**
```
setup_airflow_windows.ps1    → Setup de Airflow
run_kedro_pipeline.ps1       → Ejecución de Kedro
```

---

### ❌ Archivos que NO deben estar en Git

#### **Generados automáticamente:**
```
data/02_intermediate/        → Datos intermedios (se regeneran)
data/03_primary/             → Datos primarios (se regeneran)
data/04_feature/             → Features (se regeneran)
data/05_model_input/         → Input de modelos (se regenera)
data/06_models/              → Modelos entrenados (se regeneran)
data/07_model_output/        → Output de modelos (se regenera)
data/08_reporting/           → Reportes (se regeneran)
```

#### **Temporales y caché:**
```
__pycache__/                 → Caché de Python
.ipynb_checkpoints/          → Checkpoints de Jupyter
logs/                        → Logs del proyecto
*.log                        → Archivos de log
info.log                     → Log de información
```

#### **Entornos virtuales:**
```
venv/                        → Entorno virtual (pesado, se recrea)
env/                         → Otros entornos
```

#### **Airflow generados:**
```
airflow/logs/                → Logs de Airflow
airflow/config/              → Configuración generada
airflow/*.db                 → Base de datos de Airflow
```

#### **Documentos redundantes (según .gitignore):**
```
README_COMPLETO.md
README_KEDRO.md
README_DOCKER_AIRFLOW.md
QUICK_START.md
KEDRO_USAGE.md
DOCKER_AIRFLOW_GUIDE.md
DEPLOYMENT_SUMMARY.md
INSTRUCCIONES_EJECUCION.md
INSTRUCCIONES_ARREGLAR_AIRFLOW.md
SOLUCION_ERROR_AIRFLOW.md
SOLUCION_FINAL_AIRFLOW.md
CHECKLIST_DEPLOYMENT.md
CHECKLIST_EVALUACION.md
```

---

## 🔧 Comandos para Gestionar Git

### **Paso 1: Ver el estado actual**
```powershell
cd league-project
git status
```

### **Paso 2: Añadir archivos cruciales**
```powershell
# Usar el script automático (recomendado)
.\SUBIR_A_GIT.ps1
```

O manualmente:
```powershell
# Código fuente
git add src/
git add tests/

# Configuración
git add conf/base/catalog.yml
git add conf/base/parameters.yml
git add conf/logging.yml
git add pyproject.toml
git add requirements.txt
git add .gitignore

# Datos raw
git add data/01_raw/*.csv

# Docker y Airflow
git add Dockerfile
git add Dockerfile.airflow
git add docker-compose.yml
git add airflow/dags/*.py

# Documentación
git add README.md
git add GUIA_EJECUCION_COMPLETA.md
git add INFORME_FINAL_ACADEMICO.md

# Scripts
git add setup_airflow_windows.ps1
git add run_kedro_pipeline.ps1
```

### **Paso 3: Hacer commit**
```powershell
git commit -m "Proyecto ML completo - League of Legends Worlds"
```

### **Paso 4: Subir a GitHub**
```powershell
git push origin main
```

---

## 🧹 Limpiar archivos innecesarios del repositorio

### **Si ya subiste archivos que no deberías:**

#### **1. Remover archivos de Git (sin borrarlos localmente):**
```powershell
# Remover documentos redundantes
git rm --cached README_COMPLETO.md
git rm --cached README_KEDRO.md
git rm --cached README_DOCKER_AIRFLOW.md
git rm --cached QUICK_START.md
git rm --cached KEDRO_USAGE.md
git rm --cached DOCKER_AIRFLOW_GUIDE.md
git rm --cached DEPLOYMENT_SUMMARY.md
git rm --cached INSTRUCCIONES_EJECUCION.md
git rm --cached INSTRUCCIONES_ARREGLAR_AIRFLOW.md
git rm --cached SOLUCION_ERROR_AIRFLOW.md
git rm --cached SOLUCION_FINAL_AIRFLOW.md
git rm --cached CHECKLIST_DEPLOYMENT.md
git rm --cached CHECKLIST_EVALUACION.md

# Remover logs si se subieron
git rm --cached -r logs/
git rm --cached info.log

# Remover datos generados si se subieron
git rm --cached -r data/02_intermediate/
git rm --cached -r data/03_primary/
git rm --cached -r data/04_feature/
git rm --cached -r data/05_model_input/
git rm --cached -r data/06_models/
git rm --cached -r data/07_model_output/
git rm --cached -r data/08_reporting/

# Hacer commit de la limpieza
git commit -m "Limpieza: Removidos archivos generados y redundantes"
git push origin main
```

#### **2. Verificar que .gitignore está actualizado:**
```powershell
# Ver contenido de .gitignore
cat .gitignore

# Si necesitas añadir algo más
git add .gitignore
git commit -m "Actualizado .gitignore"
git push origin main
```

---

## 📦 Clonar y configurar el proyecto en otro equipo

### **Pasos para otra persona/equipo:**

```powershell
# 1. Clonar el repositorio
git clone https://github.com/glYohanny/Evaluacion_machine_learning.git
cd Evaluacion_machine_learning/league-project

# 2. Crear entorno virtual
python -m venv venv
.\venv\Scripts\Activate.ps1

# 3. Instalar dependencias
pip install -r requirements.txt

# 4. Ejecutar pipeline (genera automáticamente datos intermedios)
kedro run
```

**Resultado esperado:**
- ✅ Todas las carpetas de datos se llenan automáticamente
- ✅ Se generan los 10 modelos entrenados
- ✅ Se crean todos los reportes y métricas
- ⏱️ Duración: ~2 minutos

---

## 🎯 Verificación Final

### **¿Qué debe tener tu repositorio Git?**

#### **Sí debe estar:**
✅ Código fuente (`src/`)
✅ Tests (`tests/`)
✅ Configuración (`conf/`, `pyproject.toml`, `requirements.txt`)
✅ Datos raw (`data/01_raw/*.csv`)
✅ Dockerfiles y docker-compose
✅ DAGs de Airflow
✅ Documentación principal (README.md, guías)
✅ Scripts de automatización

#### **No debe estar:**
❌ Entorno virtual (`venv/`)
❌ Datos generados (`data/02_*` hasta `data/08_*`)
❌ Logs (`logs/`, `*.log`)
❌ Caché (`__pycache__/`, `.ipynb_checkpoints/`)
❌ Documentos redundantes (listados arriba)

### **Comando de verificación:**
```powershell
# Ver todos los archivos trackeados por Git
git ls-files

# Ver tamaño del repositorio
git count-objects -vH
```

**Tamaño esperado del repositorio:**
- Sin limpiar: 50-100 MB (incluye archivos innecesarios)
- Limpio: 5-15 MB (solo archivos cruciales)

---

## 🔍 Comandos útiles de Git

### **Ver qué cambió:**
```powershell
git status                    # Ver estado actual
git diff                      # Ver cambios no staged
git log --oneline             # Ver historial de commits
```

### **Deshacer cambios:**
```powershell
git restore <archivo>         # Deshacer cambios locales
git restore --staged <archivo> # Quitar de staging
git reset HEAD~1              # Deshacer último commit (mantiene cambios)
```

### **Ver archivos ignorados:**
```powershell
git status --ignored          # Ver archivos ignorados por .gitignore
```

---

## 📝 Resumen de acciones recomendadas

### **Acción 1: Subir cambios actuales**
```powershell
cd league-project
.\SUBIR_A_GIT.ps1
git commit -m "Proyecto ML completo - League of Legends Worlds"
git push origin main
```

### **Acción 2: Limpiar archivos innecesarios (opcional)**
```powershell
# Remover documentos redundantes del repositorio
git rm --cached README_COMPLETO.md README_KEDRO.md README_DOCKER_AIRFLOW.md
git rm --cached QUICK_START.md KEDRO_USAGE.md DOCKER_AIRFLOW_GUIDE.md
git rm --cached DEPLOYMENT_SUMMARY.md INSTRUCCIONES_EJECUCION.md
git rm --cached INSTRUCCIONES_ARREGLAR_AIRFLOW.md SOLUCION_ERROR_AIRFLOW.md
git rm --cached SOLUCION_FINAL_AIRFLOW.md CHECKLIST_DEPLOYMENT.md CHECKLIST_EVALUACION.md

git commit -m "Limpieza: Removidos documentos redundantes"
git push origin main
```

### **Acción 3: Verificar**
```powershell
git ls-files | Measure-Object -Line  # Contar archivos trackeados
git status                            # Ver estado final
```

---

## ✅ Checklist Final

Antes de hacer push, verifica:

- [ ] `.gitignore` está configurado correctamente
- [ ] No subes `venv/`
- [ ] No subes datos generados (`data/02_*` hasta `data/08_*`)
- [ ] No subes logs (`logs/`, `*.log`)
- [ ] Sí subes código fuente (`src/`, `tests/`)
- [ ] Sí subes configuración (`conf/`, `pyproject.toml`, `requirements.txt`)
- [ ] Sí subes datos raw (`data/01_raw/*.csv`)
- [ ] Sí subes Dockerfiles y docker-compose
- [ ] Sí subes DAGs de Airflow
- [ ] Sí subes documentación principal

---

## 🎓 Para evaluadores

Cuando alguien clone tu repositorio y ejecute:
```powershell
kedro run
```

Debe generar automáticamente:
- ✅ Todos los datos intermedios
- ✅ Todos los modelos entrenados
- ✅ Todos los reportes y métricas
- ✅ En ~2 minutos

**Esto demuestra que tu repositorio tiene EXACTAMENTE lo necesario.**

---

## 📞 Ayuda

Si tienes dudas:
1. Revisa el estado: `git status`
2. Verifica .gitignore: `cat .gitignore`
3. Lista archivos trackeados: `git ls-files`

---

**Última actualización:** Octubre 29, 2025  
**Autor:** Pedro Torres

