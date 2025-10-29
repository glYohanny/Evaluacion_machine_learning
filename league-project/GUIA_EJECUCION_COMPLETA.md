# 🚀 Guía Completa de Ejecución - League of Legends ML Project

**Autor:** Pedro Torres (glYohanny)  
**Email:** ped.torres@duocuc.cl  
**Repositorio:** https://github.com/glYohanny/Evaluacion_machine_learning

---

## 📋 Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Instalación](#instalación)
3. [Opción 1: Ejecución con Kedro (Recomendado)](#opción-1-ejecución-con-kedro-recomendado)
4. [Opción 2: Ejecución con Docker + Airflow](#opción-2-ejecución-con-docker--airflow)
5. [Ver Resultados](#ver-resultados)
6. [Troubleshooting](#troubleshooting)

---

## 🔧 Requisitos Previos

### **Software Necesario:**

1. **Python 3.11** (o superior)
   - Descargar: https://www.python.org/downloads/
   - Verificar: `python --version`

2. **Git** (para clonar el repositorio)
   - Descargar: https://git-scm.com/downloads
   - Verificar: `git --version`

3. **Docker Desktop** (OPCIONAL - solo para Airflow)
   - Descargar: https://www.docker.com/products/docker-desktop
   - Verificar: `docker --version`

### **Hardware Recomendado:**
- RAM: 8GB mínimo (16GB recomendado)
- Disco: 2GB libres
- CPU: 4 cores o más

---

## 📥 Instalación

### **Paso 1: Clonar el Repositorio**

```bash
# Clonar el proyecto
git clone https://github.com/glYohanny/Evaluacion_machine_learning.git

# Navegar a la carpeta del proyecto
cd Evaluacion_machine_learning/league-project
```

### **Paso 2: Crear Virtual Environment**

**En Windows (PowerShell):**
```powershell
# Crear virtual environment
python -m venv venv

# Activar
.\venv\Scripts\Activate.ps1
```

**En Windows (CMD):**
```cmd
# Crear virtual environment
python -m venv venv

# Activar
venv\Scripts\activate.bat
```

**En Linux/Mac:**
```bash
# Crear virtual environment
python -m venv venv

# Activar
source venv/bin/activate
```

### **Paso 3: Instalar Dependencias**

```bash
# Actualizar pip
pip install --upgrade pip

# Instalar todas las dependencias
pip install -r requirements.txt
```

**Duración:** 2-3 minutos

### **Paso 4: Verificar Instalación**

```bash
# Verificar que Kedro está instalado
kedro --version

# Debería mostrar: kedro, version 1.0.0 (o similar)
```

---

## 🎯 Opción 1: Ejecución con Kedro (Recomendado)

Esta es la forma **MÁS RÁPIDA y SIMPLE** de ejecutar el proyecto.

### **A. Pipeline Completo (Recomendado)**

Ejecuta TODO el sistema de ML de principio a fin:

```bash
kedro run
```

**¿Qué hace?**
1. ✅ Limpia 7 datasets raw
2. ✅ Realiza análisis exploratorio completo
3. ✅ Crea 18 features ingenieradas
4. ✅ Entrena 10 modelos de ML
5. ✅ Evalúa con métricas completas

**Duración:** ~1-2 minutos  
**Output esperado:**
```
[INFO] Pipeline execution completed successfully in XX.X sec.
[INFO] Completed 33 out of 33 tasks
```

---

### **B. Pipelines Individuales**

Ejecuta partes específicas del sistema:

#### **1. Solo Limpieza de Datos**
```bash
kedro run --pipeline data_cleaning
```
**Duración:** ~15 segundos  
**Output:** Datasets limpios en `data/02_intermediate/`

#### **2. Solo Análisis Exploratorio (EDA)**
```bash
kedro run --pipeline data_exploration
```
**Duración:** ~30 segundos  
**Output:** Reportes CSV en `data/08_reporting/`

#### **3. Limpieza + EDA (Recomendado para Demo Rápida)**
```bash
kedro run --pipeline eda
```
**Duración:** ~45 segundos  
**Output:** Datos limpios + 8 reportes de análisis

#### **4. Feature Engineering**
```bash
kedro run --pipeline data_processing
```
**Duración:** ~20 segundos  
**Output:** Features en `data/05_model_input/`

#### **5. Entrenamiento de Modelos**
```bash
kedro run --pipeline data_science
```
**Duración:** ~30 segundos  
**Output:** 10 modelos en `data/06_models/`

#### **6. Evaluación de Modelos**
```bash
kedro run --pipeline evaluation
```
**Duración:** ~10 segundos  
**Output:** Métricas en `data/08_reporting/`

---

### **C. Ver Catálogo de Datos**

```bash
# Listar todos los datasets disponibles
kedro catalog list

# Ver estructura de un pipeline específico
kedro catalog ds --pipeline data_cleaning
```

---

### **D. Ver Pipelines Disponibles**

```bash
# Listar todos los pipelines
kedro registry list
```

**Output esperado:**
```
- data_cleaning
- data_exploration
- data_processing
- data_science
- evaluation
- eda (combinado)
- __default__ (completo)
```

---

## 🐳 Opción 2: Ejecución con Docker + Airflow

Esta opción es más avanzada y muestra el sistema en **producción**.

### **Requisitos:**
- Docker Desktop instalado y corriendo
- 8GB RAM disponible

---

### **A. Setup Inicial (Solo Primera Vez)**

```powershell
# 1. Navegar a la carpeta del proyecto
cd league-project

# 2. Ejecutar script de setup
.\setup_airflow_windows.ps1
```

**¿Qué hace este script?**
1. ✅ Verifica Docker Desktop
2. ✅ Crea archivo `.env`
3. ✅ Crea directorios de Airflow
4. ✅ Construye imagen Docker con Kedro
5. ✅ Inicializa base de datos de Airflow

**Duración:** 10-15 minutos (primera vez)

---

### **B. Iniciar Servicios**

```powershell
# Levantar todos los servicios
docker-compose up -d
```

**¿Qué se inicia?**
- PostgreSQL (base de datos)
- Redis (message broker)
- Airflow Webserver (UI)
- Airflow Scheduler (orquestador)
- Aplicación Kedro

**Duración:** 30-60 segundos

---

### **C. Acceder a Airflow UI**

1. Abre navegador: http://localhost:8080
2. Login:
   - **Usuario:** `admin`
   - **Password:** `admin`

---

### **D. Ejecutar Pipelines en Airflow**

#### **DAG 1: kedro_eda_pipeline (Análisis Exploratorio)**

**Schedule:** Diario (@daily)

**Pasos:**
1. En la UI de Airflow, busca `kedro_eda_pipeline`
2. Click en el botón **▶️ azul** (Trigger DAG)
3. Confirma "Trigger"
4. Click en el nombre del DAG para ver progreso
5. Ve a **"Graph View"** para ver el flujo

**Duración:** ~3 minutos

**Tareas que ejecuta:**
- Clean 7 datasets
- Analyze teams (246 equipos)
- Analyze champions (137 campeones)
- Analyze correlations
- Generate reports

---

#### **DAG 2: kedro_league_ml_pipeline (Pipeline Completo)**

**Schedule:** Semanal (@weekly)

**Pasos:**
1. Click en `kedro_league_ml_pipeline`
2. Click en **▶️ Trigger DAG**
3. Ve a **"Graph View"**

**Duración:** ~15 minutos

**Tareas que ejecuta:**
1. data_cleaning
2. data_exploration
3. data_processing
4. model_training (10 modelos)
5. model_evaluation
6. generate_final_report

---

#### **DAG 3: kedro_model_training_pipeline (Solo Modelos)**

**Schedule:** Manual (None)

**Para qué sirve:** Reentrenar modelos sin reprocesar datos

**Pasos:**
1. Click en `kedro_model_training_pipeline`
2. Click en **▶️ Trigger DAG**

**Duración:** ~8 minutos

---

### **E. Ver Logs en Airflow**

1. Click en cualquier tarea (caja verde/amarilla/roja)
2. Click en **"Log"**
3. Verás el output completo de Kedro

---

### **F. Detener Servicios**

```powershell
# Detener todos los servicios
docker-compose down

# Detener y eliminar volúmenes (limpieza completa)
docker-compose down -v
```

---

## 📊 Ver Resultados

### **1. Reportes de Análisis Exploratorio**

```bash
# Listar todos los reportes
dir data/08_reporting/

# Ver estadísticas descriptivas
type data/08_reporting/descriptive_statistics.csv

# Ver análisis de equipos
type data/08_reporting/team_performance_analysis.csv

# Ver análisis de campeones
type data/08_reporting/champion_bans_analysis.csv
```

**Reportes generados:**
- `descriptive_statistics.csv` - Estadísticas básicas
- `team_performance_analysis.csv` - 246 equipos analizados
- `champion_bans_analysis.csv` - 137 campeones
- `neutral_objectives_analysis.csv` - Dragones, Barones
- `structures_analysis.csv` - Torres, Inhibidores
- `correlations_analysis.csv` - Matriz de correlación
- `game_duration_analysis.csv` - Análisis temporal
- `data_quality_report.csv` - Calidad de datos
- `eda_complete_report.json` - Reporte consolidado

---

### **2. Métricas de Modelos**

```bash
# Ver métricas de clasificación
type data/08_reporting/classification_metrics.parquet

# Ver métricas de regresión
type data/08_reporting/regression_metrics.parquet

# Ver reporte completo de clasificación
type data/08_reporting/classification_report.json

# Ver reporte completo de regresión
type data/08_reporting/regression_report.json
```

---

### **3. Modelos Entrenados**

```bash
# Listar modelos guardados
dir data/06_models/

# Deberías ver 10 archivos .pkl:
# - linear_regression.pkl
# - ridge_regression.pkl
# - lasso_regression.pkl
# - random_forest_regressor.pkl
# - gradient_boosting_regressor.pkl
# - logistic_regression.pkl
# - random_forest_classifier.pkl
# - gradient_boosting_classifier.pkl
# - svm.pkl
# - naive_bayes.pkl
```

---

### **4. Resultados Esperados**

#### **Clasificación (Predicción de Ganador):**

| Modelo | Accuracy | F1-Score | AUC-ROC |
|--------|----------|----------|---------|
| **SVM** 🥇 | **98.56%** | **0.9868** | **0.9988** |
| Logistic Regression | 98.36% | 0.9851 | 0.9991 |
| Random Forest | 98.23% | 0.9838 | 0.9988 |
| Gradient Boosting | 98.16% | 0.9832 | 0.9990 |
| Naive Bayes | 97.05% | 0.9729 | 0.9895 |

**🏆 Mejor Modelo:** SVM con 98.56% accuracy

---

#### **Regresión (Predicción de Duración):**

| Modelo | RMSE | MAE | R² |
|--------|------|-----|-----|
| **Gradient Boosting** 🥇 | **3.70** | **2.85** | **0.7928** |
| Ridge | 3.95 | 3.08 | 0.7634 |
| Linear Regression | 3.95 | 3.08 | 0.7633 |
| Random Forest | 3.96 | 3.02 | 0.7624 |
| Lasso | 3.97 | 3.10 | 0.7610 |

**🏆 Mejor Modelo:** Gradient Boosting con R² 0.7928

---

## 🔍 Troubleshooting

### **Problema 1: "ModuleNotFoundError: No module named 'kedro'"**

**Solución:**
```bash
# Verificar que el virtual environment está activado
# Debe aparecer (venv) al inicio de la línea de comando

# Si no está activado:
.\venv\Scripts\Activate.ps1  # Windows PowerShell
# o
venv\Scripts\activate.bat     # Windows CMD
# o
source venv/bin/activate      # Linux/Mac

# Reinstalar dependencias
pip install -r requirements.txt
```

---

### **Problema 2: "No such file or directory: data/01_raw/..."**

**Causa:** Los datos raw no están incluidos en el repositorio (son muy grandes)

**Solución:**
Los datos raw deben descargarse por separado. El proyecto incluye datasets de ejemplo en `.gitkeep` para mantener la estructura.

Para ejecutar con datos reales, coloca los CSV en:
```
data/01_raw/
├── LeagueofLegends.csv
├── matchinfo.csv
├── bans.csv
├── gold.csv
├── kills.csv
├── monsters.csv
└── structures.csv
```

---

### **Problema 3: Docker no inicia / Puerto 8080 ocupado**

**Solución:**
```powershell
# Verificar que Docker Desktop está corriendo
docker --version

# Verificar servicios
docker-compose ps

# Si el puerto 8080 está ocupado
netstat -ano | findstr :8080
# Matar el proceso que lo usa o cambiar el puerto en docker-compose.yml
```

---

### **Problema 4: "Pipeline input not found in DataCatalog"**

**Solución:**
```bash
# Verificar que el catálogo está bien configurado
kedro catalog list

# Limpiar cache de Kedro
kedro clean

# Verificar que los datos existen
dir data/01_raw/
```

---

### **Problema 5: Kedro tarda mucho / No responde**

**Solución:**
```bash
# Ejecutar con modo async para mejor performance
kedro run --async

# O ejecutar un pipeline más pequeño primero
kedro run --pipeline data_cleaning
```

---

### **Problema 6: Error de permisos en Windows**

**Solución:**
```powershell
# Ejecutar PowerShell como Administrador
# Right-click PowerShell → "Run as Administrator"

# Permitir ejecución de scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📞 Comandos Útiles de Referencia

### **Kedro:**
```bash
# Ver versión
kedro --version

# Ver ayuda
kedro --help

# Listar pipelines
kedro registry list

# Listar datasets
kedro catalog list

# Ejecutar pipeline específico
kedro run --pipeline NOMBRE_PIPELINE

# Ejecutar desde un nodo
kedro run --from-nodes NOMBRE_NODO

# Ejecutar hasta un nodo
kedro run --to-nodes NOMBRE_NODO

# Ver visualización del pipeline (si kedro-viz está instalado)
kedro viz
```

### **Docker:**
```bash
# Ver servicios corriendo
docker-compose ps

# Ver logs
docker-compose logs

# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs airflow-scheduler

# Reiniciar servicios
docker-compose restart

# Detener servicios
docker-compose down

# Construir imágenes
docker-compose build

# Ver imágenes
docker images
```

### **Git:**
```bash
# Ver estado
git status

# Ver historial
git log --oneline

# Ver remoto
git remote -v

# Actualizar desde GitHub
git pull origin main
```

---

## 🎓 Estructura del Proyecto

```
league-project/
├── data/                          # Datos y resultados
│   ├── 01_raw/                   # Datos originales
│   ├── 02_intermediate/          # Datos limpios
│   ├── 05_model_input/           # Features procesadas
│   ├── 06_models/                # Modelos entrenados
│   └── 08_reporting/             # Reportes y métricas
├── src/league_project/           # Código fuente
│   └── pipelines/                # 5 pipelines
│       ├── data_cleaning/        # Limpieza de datos
│       ├── data_exploration/     # Análisis exploratorio
│       ├── data_processing/      # Feature engineering
│       ├── data_science/         # Entrenamiento
│       └── evaluation/           # Evaluación
├── conf/                         # Configuración
│   ├── base/
│   │   ├── catalog.yml          # Data catalog
│   │   └── parameters.yml       # Parámetros
│   └── logging.yml              # Logging config
├── airflow/                      # Apache Airflow
│   └── dags/                    # 3 DAGs
├── notebooks/                    # Jupyter notebooks
├── Dockerfile                    # Imagen Docker de Kedro
├── Dockerfile.airflow           # Imagen Docker de Airflow
├── docker-compose.yml           # Orquestación
├── requirements.txt             # Dependencias Python
└── pyproject.toml              # Configuración del proyecto
```

---

## 📚 Documentación Adicional

- `README.md` - Descripción general del proyecto
- `GUIA_PRESENTACION.md` - Script para presentación oral
- `README_COMPLETO.md` - Documentación técnica exhaustiva
- `EVALUACION_PARCIAL_CUMPLIMIENTO.md` - Verificación de requisitos
- `DOCKER_AIRFLOW_GUIDE.md` - Guía detallada de Docker/Airflow
- `QUICK_START.md` - Inicio rápido en 5 minutos

---

## ✅ Checklist de Verificación

Después de ejecutar, verifica que:

- [ ] El pipeline se ejecutó sin errores
- [ ] Se generaron reportes en `data/08_reporting/`
- [ ] Se crearon modelos en `data/06_models/`
- [ ] Los logs muestran "Pipeline execution completed successfully"
- [ ] Las métricas de accuracy son > 95%
- [ ] El R² de regresión es > 0.75

---

## 🎯 Resumen de Ejecución Rápida

**Para evaluadores con poco tiempo:**

```bash
# 1. Clonar
git clone https://github.com/glYohanny/Evaluacion_machine_learning.git
cd Evaluacion_machine_learning/league-project

# 2. Setup
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt

# 3. Ejecutar (1 comando)
kedro run

# 4. Ver resultados
dir data\08_reporting\
```

**Duración total:** ~5 minutos

---

## 🏆 Resultados Esperados

Al finalizar la ejecución completa, tendrás:

1. ✅ **7 datasets limpios** sin duplicados ni outliers
2. ✅ **8 reportes de análisis** exploratorio
3. ✅ **18 features** ingenieradas
4. ✅ **10 modelos** de ML entrenados
5. ✅ **Métricas completas**: 98.56% accuracy, R² 0.7928
6. ✅ **Feature importance** identificada
7. ✅ **Reportes JSON/CSV** listos para visualización

---

## 📧 Contacto y Soporte

**Autor:** Pedro Torres (glYohanny)  
**Email:** ped.torres@duocuc.cl  
**GitHub:** https://github.com/glYohanny/Evaluacion_machine_learning  
**Curso:** Machine Learning - MLY0100  
**Institución:** DuocUC

---

## 📄 Licencia

Este proyecto es parte de un trabajo académico para el curso de Machine Learning.

---

**Última actualización:** Octubre 27, 2025  
**Versión:** 1.0.0  
**Estado:** ✅ Production Ready

