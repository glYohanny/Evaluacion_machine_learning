# 🎮 League of Legends ML Project - Guía Completa de Ejecución

## 📋 Índice
1. [Descripción del Proyecto](#descripción-del-proyecto)
2. [Arquitectura del Sistema](#arquitectura-del-sistema)
3. [Requisitos Previos](#requisitos-previos)
4. [Instalación](#instalación)
5. [Ejecución del Proyecto](#ejecución-del-proyecto)
6. [Estructura de Datos](#estructura-de-datos)
7. [Pipelines Implementados](#pipelines-implementados)
8. [Modelos de Machine Learning](#modelos-de-machine-learning)
9. [Resultados y Reportes](#resultados-y-reportes)
10. [Troubleshooting](#troubleshooting)

---

## 🎯 Descripción del Proyecto

Sistema completo de Machine Learning para análisis y predicción de partidas de League of Legends, implementado con **Kedro**, **Docker** y **Apache Airflow**.

### Objetivos
- **Predicción de duración de partidas** (Regresión)
- **Predicción del equipo ganador** (Clasificación)
- **Análisis exploratorio** de estadísticas de Worlds
- **Sistema automatizado** de entrenamiento y evaluación

### Metodología
Implementación completa de **CRISP-DM**:
1. Business Understanding
2. Data Understanding
3. Data Preparation
4. Modeling
5. Evaluation
6. Deployment

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────────┐
│                      APACHE AIRFLOW                         │
│              (Orquestación y Scheduling)                    │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                    KEDRO PIPELINES                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Data    │→ │   Data   │→ │   Data   │→ │   Data   │  │
│  │Cleaning  │  │Exploration│  │Processing│  │  Science │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
│                                                  ↓          │
│                                         ┌──────────────┐   │
│                                         │  Evaluation  │   │
│                                         └──────────────┘   │
└─────────────────────────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                   DOCKER CONTAINERS                         │
│  • PostgreSQL (Base de datos Airflow)                      │
│  • Redis (Message broker)                                  │
│  • Kedro App (Aplicación ML)                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 Requisitos Previos

### Software Necesario
1. **Docker Desktop** (Windows 10/11)
   - Descargar: https://www.docker.com/products/docker-desktop
   - Versión mínima: 20.10.x
   - WSL 2 habilitado

2. **PowerShell** (Incluido en Windows)
   - Versión mínima: 5.1

3. **Git** (Opcional, para control de versiones)
   - Descargar: https://git-scm.com/downloads

### Especificaciones Hardware
- **RAM**: Mínimo 8GB (Recomendado 16GB)
- **Disco**: 10GB libres
- **CPU**: 4 cores o más

---

## 📥 Instalación

### Paso 1: Verificar Docker
```powershell
# Abrir PowerShell y verificar
docker --version
docker-compose --version
```

**Salida esperada:**
```
Docker version 24.x.x
Docker Compose version v2.x.x
```

### Paso 2: Clonar/Descargar el Proyecto
```powershell
# Si usas Git
git clone <repository-url>
cd league-project

# O simplemente navega a la carpeta del proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig\league-project
```

### Paso 3: Configuración Inicial
```powershell
# Ejecutar script de setup (hace todo automáticamente)
.\setup_airflow_windows.ps1
```

**¿Qué hace este script?**
1. ✅ Verifica Docker Desktop
2. ✅ Crea archivo `.env` con variables de entorno
3. ✅ Crea directorios de Airflow
4. ✅ Construye la imagen Docker de Kedro
5. ✅ Inicializa la base de datos de Airflow
6. ✅ Crea usuario admin de Airflow

**Tiempo estimado:** 5-10 minutos

---

## 🚀 Ejecución del Proyecto

### Opción 1: Sistema Completo con Airflow (Recomendado)

#### 1. Iniciar Servicios Docker
```powershell
docker-compose up -d
```

**Servicios que se inician:**
- `postgres` - Base de datos
- `redis` - Message broker
- `airflow-webserver` - UI de Airflow (puerto 8080)
- `airflow-scheduler` - Programador de tareas
- `airflow-worker` - Ejecutor de tareas
- `kedro-app` - Aplicación ML

#### 2. Acceder a Airflow
- **URL**: http://localhost:8080
- **Usuario**: `admin`
- **Password**: `admin`

#### 3. Ejecutar Pipelines

**Desde Airflow UI:**
1. Ve a la lista de DAGs
2. Activa el DAG que quieras ejecutar (toggle ON)
3. Click en el nombre del DAG
4. Click en "▶️ Trigger DAG"

**DAGs Disponibles:**

##### a) `kedro_eda_pipeline` (Análisis Exploratorio)
- **Duración:** ~3 minutos
- **Qué hace:**
  - Limpia datos raw
  - Genera estadísticas descriptivas
  - Analiza equipos y campeones
  - Crea reportes de calidad de datos
- **Cuándo usarlo:** Exploración inicial de datos

##### b) `kedro_league_ml_pipeline` (Pipeline Completo)
- **Duración:** ~15 minutos
- **Qué hace:**
  - Limpieza de datos
  - Análisis exploratorio
  - Feature engineering
  - Entrenamiento de 10 modelos
  - Evaluación y reportes
- **Cuándo usarlo:** Entrenamiento completo end-to-end

##### c) `kedro_model_training_pipeline` (Solo Modelos)
- **Duración:** ~8 minutos
- **Qué hace:**
  - Feature engineering
  - Entrenamiento de modelos
  - Evaluación de modelos
- **Cuándo usarlo:** Reentrenar modelos sin reprocesar datos

#### 4. Monitorear Ejecución
- **Graph View**: Ver flujo de tareas
- **Logs**: Click en tarea → "Log" para ver detalles
- **Grid View**: Historial de ejecuciones

#### 5. Detener Servicios
```powershell
docker-compose down
```

---

### Opción 2: Ejecución Directa con Kedro (Sin Docker)

#### 1. Activar Entorno Virtual
```powershell
# Navegar al directorio del proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig

# Activar virtual environment
.\venv\Scripts\Activate.ps1
```

#### 2. Instalar Dependencias
```powershell
pip install -r league-project/requirements.txt
```

#### 3. Navegar a la Carpeta del Proyecto
```powershell
cd league-project
```

#### 4. Ejecutar Pipelines

**Pipeline Completo:**
```powershell
kedro run
```

**Pipelines Individuales:**
```powershell
# Solo limpieza de datos
kedro run --pipeline data_cleaning

# Solo análisis exploratorio
kedro run --pipeline data_exploration

# Limpieza + Exploración
kedro run --pipeline eda

# Feature engineering
kedro run --pipeline data_processing

# Entrenamiento de modelos
kedro run --pipeline data_science

# Evaluación de modelos
kedro run --pipeline evaluation
```

**Ejecutar Nodos Específicos:**
```powershell
# Desde un nodo específico
kedro run --from-nodes clean_main_dataset_node

# Hasta un nodo específico
kedro run --to-nodes generate_eda_report_node

# Solo un nodo
kedro run --node clean_main_dataset_node
```

---

## 📊 Estructura de Datos

### Datos de Entrada (data/01_raw/)
```
data/01_raw/
├── LeagueofLegends.csv      # Dataset principal (10,000+ partidas)
├── matchinfo.csv            # Información de partidas
├── bans.csv                 # Campeones baneados
├── gold.csv                 # Economía del juego
├── kills.csv                # Asesinatos y kills
├── monsters.csv             # Objetivos neutrales
└── structures.csv           # Torres e inhibidores
```

### Datos Procesados

#### data/02_intermediate/ (Datos Limpios)
- `main_clean.csv`
- `matchinfo_clean.csv`
- `bans_clean.csv`, etc.

#### data/05_model_input/ (Features para ML)
- `worlds_final.csv` - Dataset consolidado con features

#### data/06_models/ (Modelos Entrenados)
- `linear_regression.pkl`
- `random_forest_regressor.pkl`
- `logistic_regression.pkl`
- `random_forest_classifier.pkl`, etc.

#### data/08_reporting/ (Reportes y Métricas)
- `descriptive_statistics.csv`
- `team_performance_analysis.csv`
- `champion_bans_analysis.csv`
- `regression_metrics.csv`
- `classification_metrics.csv`
- `eda_complete_report.json`

---

## 🔄 Pipelines Implementados

### 1. Data Cleaning Pipeline
**Objetivo:** Limpiar datos raw y prepararlos para análisis

**Nodos (8):**
1. `clean_main_dataset` - Limpia dataset principal
2. `clean_matchinfo` - Limpia info de partidas
3. `clean_bans` - Limpia datos de bans
4. `clean_gold` - Limpia datos de oro
5. `clean_kills` - Limpia datos de kills
6. `clean_monsters` - Limpia objetivos neutrales
7. `clean_structures` - Limpia estructuras
8. `generate_data_quality_report` - Genera reporte de calidad

**Técnicas Aplicadas:**
- Eliminación de duplicados
- Imputación de valores nulos
- Detección de outliers (método IQR)
- Validación de tipos de datos

**Duración:** ~1 minuto

---

### 2. Data Exploration Pipeline
**Objetivo:** Análisis exploratorio de datos limpios

**Nodos (8):**
1. `generate_descriptive_statistics` - Estadísticas descriptivas
2. `analyze_team_performance` - Análisis de equipos (246 equipos)
3. `analyze_champion_bans` - Análisis de bans (137 campeones)
4. `analyze_neutral_objectives` - Dragones, Barones, Heralds
5. `analyze_structures` - Torres e inhibidores
6. `analyze_correlations` - Matriz de correlación
7. `analyze_game_duration` - Análisis temporal
8. `generate_eda_report` - Reporte completo JSON

**Análisis Generados:**
- Media, mediana, desviación estándar
- Win rate por equipo
- Frecuencia de bans por campeón
- Correlaciones entre variables
- Distribución de duración de partidas

**Duración:** ~2 minutos

---

### 3. Data Processing Pipeline
**Objetivo:** Feature engineering y preparación para ML

**Nodos (7):**
1. `aggregate_kills` - Agrega kills por equipo
2. `aggregate_monsters` - Agrega objetivos neutrales
3. `aggregate_structures` - Agrega estructuras
4. `aggregate_gold` - Agrega economía
5. `select_features` - Selecciona features relevantes
6. `split_data` - Train/test split (80/20)
7. `scale_features` - Normalización de features

**Features Creadas:**
- Diferencia de kills (blue - red)
- Diferencia de dragones
- Diferencia de barones
- Diferencia de torres
- Diferencia de oro

**Duración:** ~2 minutos

---

### 4. Data Science Pipeline
**Objetivo:** Entrenamiento de modelos de ML

**Modelos de Regresión (5):**
1. Linear Regression
2. Ridge Regression
3. Lasso Regression
4. Random Forest Regressor
5. Gradient Boosting Regressor

**Modelos de Clasificación (5):**
1. Logistic Regression
2. Random Forest Classifier
3. Gradient Boosting Classifier
4. Support Vector Machine (SVM)
5. Naive Bayes

**Duración:** ~8 minutos

---

### 5. Evaluation Pipeline
**Objetivo:** Evaluación de modelos y generación de reportes

**Métricas de Regresión:**
- RMSE (Root Mean Squared Error)
- MAE (Mean Absolute Error)
- R² (Coeficiente de Determinación)

**Métricas de Clasificación:**
- Accuracy
- Precision
- Recall
- F1-Score
- AUC-ROC

**Reportes Generados:**
- Feature importance (modelos basados en árboles)
- Comparación de modelos
- Reporte JSON completo

**Duración:** ~2 minutos

---

## 🤖 Modelos de Machine Learning

### Problema 1: Predicción de Duración (Regresión)
**Target:** `gamelength_minutes`

| Modelo | RMSE | MAE | R² | Descripción |
|--------|------|-----|-------|------------|
| Linear Regression | ~X.X | ~X.X | ~0.XX | Baseline simple |
| Ridge Regression | ~X.X | ~X.X | ~0.XX | Regularización L2 |
| Lasso Regression | ~X.X | ~X.X | ~0.XX | Regularización L1 |
| Random Forest | ~X.X | ~X.X | ~0.XX | Ensemble de árboles |
| Gradient Boosting | ~X.X | ~X.X | ~0.XX | Boosting iterativo |

### Problema 2: Predicción de Ganador (Clasificación)
**Target:** `bresult` (1 = Blue gana, 0 = Red gana)

| Modelo | Accuracy | Precision | Recall | F1-Score |
|--------|----------|-----------|--------|----------|
| Logistic Regression | ~X.XX | ~X.XX | ~X.XX | ~X.XX |
| Random Forest | ~X.XX | ~X.XX | ~X.XX | ~X.XX |
| Gradient Boosting | ~X.XX | ~X.XX | ~X.XX | ~X.XX |
| SVM | ~X.XX | ~X.XX | ~X.XX | ~X.XX |
| Naive Bayes | ~X.XX | ~X.XX | ~X.XX | ~X.XX |

**Nota:** Los valores exactos se encuentran en `data/08_reporting/regression_metrics.csv` y `classification_metrics.csv`

---

## 📈 Resultados y Reportes

### Acceder a Resultados

#### 1. Desde Airflow
- Ve a "Browse" → "Data" → Busca el dataset de reporte
- Descarga el CSV o JSON

#### 2. Directamente en el Sistema de Archivos
```powershell
# Ver reportes
cd data/08_reporting
dir

# Abrir reporte CSV
notepad descriptive_statistics.csv

# Abrir reporte JSON
notepad eda_complete_report.json
```

### Reportes Clave

#### data/08_reporting/team_performance_analysis.csv
```csv
team,total_games,wins,losses,win_rate,avg_game_length
T1,50,35,15,0.700,32.5
GEN,48,32,16,0.667,31.8
...
```

#### data/08_reporting/regression_metrics.csv
```csv
model,rmse,mae,r2_train,r2_test
linear_regression,5.2,4.1,0.82,0.78
random_forest,3.8,2.9,0.91,0.85
...
```

#### data/08_reporting/classification_metrics.csv
```csv
model,accuracy,precision,recall,f1_score,auc_roc
logistic_regression,0.85,0.84,0.86,0.85,0.89
random_forest,0.89,0.88,0.90,0.89,0.94
...
```

---

## 🔧 Troubleshooting

### Problema 1: Docker no está instalado
**Error:** `docker : El término 'docker' no se reconoce...`

**Solución:**
1. Instalar Docker Desktop: https://www.docker.com/products/docker-desktop
2. Reiniciar la computadora
3. Verificar: `docker --version`

---

### Problema 2: Puerto 8080 ocupado
**Error:** `Bind for 0.0.0.0:8080 failed: port is already allocated`

**Solución:**
```powershell
# Opción 1: Detener el servicio que usa el puerto
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Opción 2: Cambiar puerto en docker-compose.yml
# Editar línea:
ports:
  - "8081:8080"  # Usar 8081 en lugar de 8080
```

---

### Problema 3: Kedro no encuentra datasets
**Error:** `Pipeline input(s) {'raw_main_data'} not found...`

**Solución:**
```powershell
# Verificar que existen los datos
dir data\01_raw

# Verificar configuración del catálogo
notepad conf\base\catalog.yml

# Re-ejecutar con verbose
kedro run --pipeline data_cleaning -v
```

---

### Problema 4: Memoria insuficiente
**Error:** Container killed (OOMKilled)

**Solución:**
1. Abrir Docker Desktop
2. Settings → Resources
3. Aumentar Memory a 8GB o más
4. Apply & Restart

---

### Problema 5: Airflow no muestra DAGs
**Solución:**
```powershell
# Reiniciar scheduler
docker-compose restart airflow-scheduler

# Ver logs del scheduler
docker-compose logs airflow-scheduler

# Verificar que los DAGs están en la carpeta correcta
dir airflow\dags
```

---

## 📚 Comandos Útiles

### Docker
```powershell
# Ver servicios corriendo
docker-compose ps

# Ver logs de un servicio
docker-compose logs airflow-webserver
docker-compose logs kedro-app

# Reiniciar un servicio
docker-compose restart airflow-scheduler

# Detener todos los servicios
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v

# Reconstruir imagen
docker-compose build kedro-app
```

### Kedro
```powershell
# Ver pipelines disponibles
kedro registry list

# Ver catálogo de datos
kedro catalog list

# Ver estructura del proyecto
kedro catalog ds --pipeline data_cleaning

# Ejecutar con más información
kedro run --pipeline eda -v

# Limpiar archivos temporales
kedro clean
```

### Airflow CLI (dentro del container)
```powershell
# Entrar al container
docker-compose exec airflow-webserver bash

# Listar DAGs
airflow dags list

# Probar un DAG
airflow dags test kedro_eda_pipeline 2024-01-01

# Ver tareas de un DAG
airflow tasks list kedro_eda_pipeline
```

---

## 📞 Contacto y Soporte

**Autor:** Pedro (Tu nombre completo)  
**Email:** tu_email@ejemplo.com  
**GitHub:** https://github.com/tu-usuario/league-ml-project  

---

## 📄 Licencia

Este proyecto es parte de un trabajo académico para el curso de Machine Learning.

---

## 🎓 Referencias

1. Kedro Documentation: https://kedro.readthedocs.io/
2. Apache Airflow Documentation: https://airflow.apache.org/docs/
3. Docker Documentation: https://docs.docker.com/
4. Scikit-learn Documentation: https://scikit-learn.org/stable/

---

**Última actualización:** Octubre 2024  
**Versión:** 1.0.0

