# 📊 Resumen de Archivos del Proyecto

## 🎯 Propósito de este Documento

Este documento te ayuda a entender **qué archivos son esenciales** para la ejecución del proyecto y cuáles son generados automáticamente.

---

## ✅ Archivos que DEBEN estar en Git

### 🔷 **1. Código Fuente (CRÍTICO)**
```
src/league_project/
├── __init__.py
├── __main__.py
├── hooks.py
├── pipeline_registry.py
├── settings.py
└── pipelines/
    ├── data_cleaning/
    │   ├── __init__.py
    │   ├── nodes.py
    │   └── pipeline.py
    ├── data_exploration/
    │   ├── __init__.py
    │   ├── nodes.py
    │   └── pipeline.py
    ├── data_processing/
    │   ├── __init__.py
    │   ├── nodes.py
    │   └── pipeline.py
    ├── data_science/
    │   ├── __init__.py
    │   ├── nodes.py
    │   └── pipeline.py
    └── evaluation/
        ├── __init__.py
        ├── nodes.py
        └── pipeline.py
```
**Tamaño:** ~50 KB  
**¿Por qué?** Contiene toda la lógica del proyecto

---

### 🔷 **2. Tests (IMPORTANTE)**
```
tests/
├── __init__.py
├── test_run.py
└── pipelines/
    └── __init__.py
```
**Tamaño:** ~5 KB  
**¿Por qué?** Valida que el código funcione correctamente

---

### 🔷 **3. Configuración (CRÍTICO)**
```
conf/
├── base/
│   ├── catalog.yml         → Define dónde leer/escribir datos
│   └── parameters.yml      → Parámetros de ML (test_size, etc)
└── logging.yml             → Configuración de logs

pyproject.toml              → Configuración del proyecto Python
requirements.txt            → Lista de dependencias
.gitignore                  → Archivos a ignorar en Git
```
**Tamaño:** ~15 KB  
**¿Por qué?** Sin estos archivos, Kedro no sabe cómo ejecutarse

---

### 🔷 **4. Datos Raw (ESENCIAL)**
```
data/01_raw/
├── LeagueofLegends.csv     → Dataset principal (6+ MB)
├── _columns.csv            → Descripción de columnas
├── bans.csv                → Bans de campeones
├── gold.csv                → Estadísticas de oro
├── kills.csv               → Estadísticas de kills
├── matchinfo.csv           → Información de partidas
├── monsters.csv            → Objetivos neutrales
└── structures.csv          → Torres y estructuras
```
**Tamaño:** ~7 MB  
**¿Por qué?** Son los datos originales del proyecto

---

### 🔷 **5. Docker y Airflow (DEPLOYMENT)**
```
Dockerfile                  → Imagen Docker de Kedro
Dockerfile.airflow          → Imagen Docker de Airflow
docker-compose.yml          → Orquestación de servicios
.dockerignore               → Archivos a ignorar en Docker

airflow/dags/
├── kedro_league_ml_dag.py  → DAG completo
├── kedro_eda_only_dag.py   → Solo EDA
├── kedro_training_only_dag.py → Solo training
└── README.md
```
**Tamaño:** ~20 KB  
**¿Por qué?** Permite ejecutar el proyecto en cualquier máquina

---

### 🔷 **6. Documentación (IMPORTANTE)**
```
README.md                   → Documentación principal
GUIA_EJECUCION_COMPLETA.md  → Cómo ejecutar todo
GUIA_GIT.md                 → Esta guía de Git
GUIA_PRESENTACION.md        → Script de presentación
INFORME_FINAL_ACADEMICO.md  → Informe académico
EVALUACION_PARCIAL_CUMPLIMIENTO.md → Cumplimiento de requisitos
RESUMEN_EJECUTIVO.md        → Resumen del proyecto
```
**Tamaño:** ~100 KB  
**¿Por qué?** Explica cómo usar el proyecto

---

### 🔷 **7. Scripts de Automatización**
```
setup_airflow_windows.ps1   → Setup inicial de Airflow
run_kedro_pipeline.ps1      → Ejecutar pipelines
SUBIR_A_GIT.ps1             → Script para subir a Git
LIMPIAR_GIT.ps1             → Script para limpiar Git
```
**Tamaño:** ~30 KB  
**¿Por qué?** Automatizan tareas comunes

---

### 🔷 **8. Estructura de Carpetas Vacías**
```
data/02_intermediate/.gitkeep
data/03_primary/.gitkeep
data/04_feature/.gitkeep
data/05_model_input/.gitkeep
data/06_models/.gitkeep
data/07_model_output/.gitkeep
data/08_reporting/.gitkeep
conf/local/.gitkeep
airflow/logs/.gitkeep
airflow/config/.gitkeep
airflow/plugins/.gitkeep
```
**Tamaño:** 0 KB (archivos vacíos)  
**¿Por qué?** Mantiene la estructura de carpetas en Git

---

## ❌ Archivos que NO deben estar en Git

### 🔴 **1. Entorno Virtual (NUNCA)**
```
venv/                       → ~500 MB - 1 GB
env/
ENV/
```
**¿Por qué no?** Se recrea con `pip install -r requirements.txt`  
**Tamaño si se sube:** ⚠️ 500 MB - 1 GB (¡ENORME!)

---

### 🔴 **2. Datos Generados (SE REGENERAN)**
```
data/02_intermediate/       → Datos limpios
data/03_primary/            → Datos procesados
data/04_feature/            → Features creadas
data/05_model_input/        → Input de modelos
data/06_models/             → Modelos .pkl (10+ MB)
data/07_model_output/       → Predicciones
data/08_reporting/          → Reportes JSON/CSV
```
**¿Por qué no?** Se regeneran con `kedro run` en 2 minutos  
**Tamaño si se sube:** ⚠️ 50-100 MB

---

### 🔴 **3. Logs y Temporales**
```
logs/
*.log
info.log
.ipynb_checkpoints/
*.tmp
*.bak
```
**¿Por qué no?** Archivos temporales sin valor  
**Tamaño si se sube:** ⚠️ 10-50 MB

---

### 🔴 **4. Caché de Python**
```
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so
```
**¿Por qué no?** Se regeneran automáticamente  
**Tamaño si se sube:** ⚠️ 20-50 MB

---

### 🔴 **5. Archivos de Airflow Generados**
```
airflow/logs/               → Logs de ejecución
airflow/config/             → Config generada
airflow/*.db                → Base de datos SQLite
airflow/*.pid               → Process IDs
airflow/*.cfg               → Configuración auto
```
**¿Por qué no?** Se generan al iniciar Airflow  
**Tamaño si se sube:** ⚠️ 10-30 MB

---

### 🔴 **6. Documentos Redundantes**
```
README_COMPLETO.md          → Ya está en README.md
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
**¿Por qué no?** Duplican información  
**Tamaño si se sube:** ⚠️ 5-10 MB

---

## 📊 Comparación de Tamaño

| Tipo de Archivo | Tamaño en Git | Impacto |
|-----------------|---------------|---------|
| **✅ Archivos Esenciales** | ~7-10 MB | ✅ Perfecto |
| **❌ Con archivos innecesarios** | 600+ MB | ❌ ¡MALO! |
| **Diferencia** | ~590 MB | 😱 60x más pesado |

---

## 🎯 ¿Cómo verificar que tu repositorio está limpio?

### **Comando 1: Ver tamaño del repositorio**
```powershell
cd league-project
git count-objects -vH
```

**✅ Resultado esperado:**
```
size: 7-10 MiB
```

**❌ Si ves más de 50 MiB, tienes archivos innecesarios**

---

### **Comando 2: Contar archivos trackeados**
```powershell
git ls-files | Measure-Object
```

**✅ Resultado esperado:**
```
Count: 80-120 archivos
```

**❌ Si ves más de 200 archivos, tienes demasiados**

---

### **Comando 3: Ver archivos trackeados**
```powershell
git ls-files
```

**✅ NO deberías ver:**
- Rutas con `venv/`
- Rutas con `__pycache__/`
- Archivos `.log`
- Rutas con `data/02_*` hasta `data/08_*` (excepto `.gitkeep`)

---

## 🚀 Flujo de Trabajo Recomendado

### **Escenario 1: Primera vez subiendo a Git**
```powershell
# 1. Ir al proyecto
cd Proyecto_machine_learnig

# 2. Ejecutar script de subida
.\SUBIR_A_GIT.ps1

# 3. Hacer commit
git commit -m "Proyecto ML completo - League of Legends Worlds"

# 4. Subir a GitHub
git push origin main
```

---

### **Escenario 2: Ya subiste archivos innecesarios**
```powershell
# 1. Ir al proyecto
cd Proyecto_machine_learnig

# 2. Limpiar archivos innecesarios
.\LIMPIAR_GIT.ps1

# 3. Hacer commit
git commit -m "Limpieza: Removidos archivos innecesarios"

# 4. Subir cambios
git push origin main
```

---

### **Escenario 3: Actualizar archivos específicos**
```powershell
# 1. Ver qué cambió
git status

# 2. Añadir archivos modificados
git add src/
git add conf/

# 3. Commit y push
git commit -m "Actualización de pipelines y configuración"
git push origin main
```

---

## ✅ Checklist Final

Antes de hacer push, verifica:

- [ ] ✅ `.gitignore` está actualizado
- [ ] ✅ Solo hay archivos de código fuente, config y datos raw
- [ ] ✅ NO hay carpeta `venv/`
- [ ] ✅ NO hay archivos `.log`
- [ ] ✅ NO hay `__pycache__/`
- [ ] ✅ NO hay datos generados (data/02 a data/08, excepto .gitkeep)
- [ ] ✅ Tamaño del repo < 15 MB
- [ ] ✅ Menos de 150 archivos trackeados

---

## 🎓 ¿Por qué es importante mantener un repositorio limpio?

### **1. Velocidad**
- ⚡ Clone rápido: 7 MB en segundos vs 600 MB en minutos
- ⚡ Push/pull rápidos

### **2. Profesionalismo**
- 🎯 Muestra que sabes qué es importante
- 🎯 Facilita la revisión de código

### **3. Colaboración**
- 👥 Otros pueden clonar y ejecutar fácilmente
- 👥 No pierden tiempo descargando archivos innecesarios

### **4. Almacenamiento**
- 💾 GitHub tiene límites de tamaño
- 💾 Repositorios grandes pueden ser rechazados

---

## 📞 Comandos de Ayuda Rápida

```powershell
# Ver estado actual
git status

# Ver archivos trackeados
git ls-files

# Ver tamaño del repositorio
git count-objects -vH

# Ver .gitignore
cat .gitignore

# Verificar qué se subirá
git diff --cached --name-only

# Ver historial
git log --oneline

# Ayuda con cualquier comando
git help <comando>
```

---

## 🎉 Resultado Final Esperado

Cuando alguien clone tu repositorio:

```powershell
git clone https://github.com/glYohanny/Evaluacion_machine_learning.git
cd Evaluacion_machine_learning/league-project
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
kedro run
```

**¡Y funciona perfectamente en 2 minutos!** 🚀

---

**Última actualización:** Octubre 29, 2025  
**Autor:** Pedro Torres

