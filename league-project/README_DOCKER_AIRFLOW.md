# 🎮 League of Legends ML Project - Docker + Airflow Edition

<div align="center">

![Project Status](https://img.shields.io/badge/Status-Production%20Ready-success)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue)
![Airflow](https://img.shields.io/badge/Airflow-2.8.0-red)
![Kedro](https://img.shields.io/badge/Kedro-1.0.0-orange)
![Python](https://img.shields.io/badge/Python-3.11-blue)

**Análisis de Machine Learning del League of Legends World Championship**  
**Con orquestación automática y deployment en Windows**

[Quick Start](#-quick-start) •
[Documentación](#-documentación) •
[Arquitectura](#-arquitectura) •
[Pipelines](#-pipelines) •
[DAGs](#-dags-de-airflow)

</div>

---

## 🌟 Características

- ✅ **5 Pipelines de Kedro** completamente funcionales
- ✅ **10 Modelos de ML** (5 regresión + 5 clasificación)
- ✅ **3 DAGs de Airflow** para orquestación automatizada
- ✅ **Docker Compose** para deployment multi-container
- ✅ **Scripts PowerShell** optimizados para Windows
- ✅ **Documentación completa** con guías paso a paso
- ✅ **33+ Nodos** de procesamiento modular
- ✅ **7 Datasets** procesados y analizados

---

## 🚀 Quick Start

### Prerrequisitos
- Docker Desktop instalado
- Windows 10/11
- 8+ GB RAM

### 3 Comandos para Empezar

```powershell
# 1. Setup automático
.\setup_airflow_windows.ps1

# 2. Iniciar servicios
docker-compose up -d

# 3. Ejecutar tu primer pipeline
.\run_kedro_pipeline.ps1 -Pipeline eda
```

### Acceder a Airflow
- **URL**: http://localhost:8080
- **Usuario**: `admin`
- **Contraseña**: `admin`

---

## 📚 Documentación

| Documento | Descripción |
|-----------|-------------|
| **[QUICK_START.md](QUICK_START.md)** | ⚡ Inicio rápido en 5 minutos |
| **[DOCKER_AIRFLOW_GUIDE.md](DOCKER_AIRFLOW_GUIDE.md)** | 📖 Guía completa y detallada |
| **[DEPLOYMENT_SUMMARY.md](DEPLOYMENT_SUMMARY.md)** | 📦 Resumen ejecutivo del deployment |
| **[airflow/dags/README.md](airflow/dags/README.md)** | 📊 Documentación de DAGs |
| **[GUIA_DATOS_CSV.md](docs/GUIA_DATOS_CSV.md)** | 📁 Guía de datos CSV |

---

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────┐
│                   AIRFLOW ORCHESTRATOR                 │
│                    (localhost:8080)                    │
└─────────────────────┬──────────────────────────────────┘
                      │
         ┌────────────┼────────────┐
         ▼            ▼            ▼
    ┌────────┐   ┌────────┐   ┌────────┐
    │  EDA   │   │   ML   │   │  Full  │
    │  DAG   │   │  DAG   │   │  DAG   │
    └────┬───┘   └───┬────┘   └───┬────┘
         │           │            │
         └───────────┼────────────┘
                     ▼
         ┌───────────────────────┐
         │   KEDRO PIPELINES     │
         │                       │
         │  1. Data Cleaning     │
         │  2. Data Exploration  │
         │  3. Data Processing   │
         │  4. Model Training    │
         │  5. Model Evaluation  │
         └───────────┬───────────┘
                     │
                     ▼
         ┌───────────────────────┐
         │    DATA & MODELS      │
         │                       │
         │  • Cleaned Data       │
         │  • Features           │
         │  • Trained Models     │
         │  • Reports            │
         └───────────────────────┘
```

---

## 📊 Pipelines

### 1. Data Cleaning Pipeline
**Nodos**: 8 | **Tiempo**: ~1 min  
Limpia 7 datasets raw eliminando duplicados, manejando nulos y detectando outliers.

### 2. Data Exploration Pipeline
**Nodos**: 8 | **Tiempo**: ~30 seg  
Genera análisis estadísticos completos incluyendo:
- 📈 Estadísticas descriptivas
- 🏆 Análisis de rendimiento de 246 equipos
- 🚫 Análisis de 137 campeones baneados
- 🐉 Objetivos neutrales y estructuras
- 🔗 Matriz de correlaciones

### 3. Data Processing Pipeline
**Nodos**: 7 | **Tiempo**: ~2 min  
Feature engineering con agregaciones de:
- 💀 Kills por equipo
- 🐉 Dragones y Barones
- 🏰 Torres e Inhibidores
- 💰 Diferencias de oro
- 📊 Escalado de features

### 4. Data Science Pipeline
**Nodos**: 4 | **Tiempo**: ~5 min  
Entrena 10 modelos de ML:

**Regresión** (predecir duración):
- Linear Regression, Ridge, Lasso
- Random Forest, Gradient Boosting

**Clasificación** (predecir ganador):
- Logistic Regression, Random Forest, GradientBoosting
- SVM, Naive Bayes

### 5. Evaluation Pipeline
**Nodos**: 6 | **Tiempo**: ~1 min  
Evalúa modelos con múltiples métricas:
- **Regresión**: RMSE, MAE, R²
- **Clasificación**: Accuracy, Precision, Recall, F1, AUC-ROC
- **Feature Importance** de modelos basados en árboles

---

## 📅 DAGs de Airflow

### 1. `kedro_league_ml_pipeline`
**Schedule**: Semanal  
**Duración**: ~15 min  
Pipeline completo de ML desde limpieza hasta evaluación.

### 2. `kedro_eda_pipeline`
**Schedule**: Diario  
**Duración**: ~3 min  
Solo limpieza y exploración para monitoreo de calidad de datos.

### 3. `kedro_model_training_pipeline`
**Schedule**: Manual  
**Duración**: ~8 min  
Solo entrenamiento y evaluación (con verificación de datos procesados).

---

## 🎯 Comandos Útiles

### Gestión de Servicios

```powershell
# Iniciar todo
docker-compose up -d

# Ver estado
docker-compose ps

# Ver logs
docker-compose logs -f

# Detener todo
docker-compose down

# Reiniciar un servicio
docker-compose restart airflow-scheduler
```

### Ejecutar Pipelines

```powershell
# Con script (recomendado)
.\run_kedro_pipeline.ps1 -Pipeline eda
.\run_kedro_pipeline.ps1 -Pipeline data_science

# Directo con docker-compose
docker-compose run --rm kedro-app kedro run
docker-compose run --rm kedro-app kedro run --pipeline eda

# Ver pipelines disponibles
docker-compose run --rm kedro-app kedro pipeline list
```

### Debugging

```powershell
# Logs de Airflow
docker-compose logs -f airflow-scheduler

# Shell en contenedor de Kedro
docker-compose run --rm kedro-app bash

# Ver catálogo de datos
docker-compose run --rm kedro-app kedro catalog list
```

---

## 📁 Estructura del Proyecto

```
league-project/
├── 📄 Dockerfile                    # Imagen de Kedro
├── 📄 docker-compose.yml            # Orquestación multi-container
├── 📄 setup_airflow_windows.ps1    # Script de setup
├── 📄 run_kedro_pipeline.ps1       # Ejecutor de pipelines
├── 📄 Makefile                      # Comandos útiles
│
├── 📁 airflow/
│   ├── 📁 dags/                     # DAGs de Airflow
│   │   ├── kedro_league_ml_dag.py
│   │   ├── kedro_eda_only_dag.py
│   │   ├── kedro_training_only_dag.py
│   │   └── README.md
│   ├── 📁 logs/                     # Logs de Airflow
│   ├── 📁 plugins/                  # Plugins personalizados
│   └── 📁 config/                   # Configuración
│
├── 📁 src/
│   └── 📁 league_project/
│       └── 📁 pipelines/
│           ├── 📁 data_cleaning/
│           ├── 📁 data_exploration/
│           ├── 📁 data_processing/
│           ├── 📁 data_science/
│           └── 📁 evaluation/
│
├── 📁 data/
│   ├── 📁 01_raw/                   # Datos originales
│   ├── 📁 02_intermediate/          # Datos limpios
│   ├── 📁 05_model_input/           # Features procesadas
│   ├── 📁 06_models/                # Modelos entrenados
│   └── 📁 08_reporting/             # Reportes y métricas
│
└── 📁 docs/                         # Documentación completa
```

---

## 🔍 Resultados Esperados

Después de ejecutar el pipeline completo, tendrás:

### Datos Procesados
- ✅ 7 datasets limpios en `data/02_intermediate/`
- ✅ Features engineered en `data/05_model_input/`

### Análisis Exploratorio
- ✅ Estadísticas de 246 equipos
- ✅ Análisis de 137 campeones
- ✅ Reporte completo de EDA en JSON

### Modelos Entrenados
- ✅ 5 modelos de regresión (duración de partida)
- ✅ 5 modelos de clasificación (predicción de ganador)
- ✅ Métricas comparativas en CSV

### Evaluación
- ✅ Feature importance por modelo
- ✅ Reportes JSON con mejores modelos
- ✅ Métricas de rendimiento (R², F1, AUC)

---

## 🛠️ Solución de Problemas

### Puerto 8080 ocupado
```powershell
# Editar docker-compose.yml línea 73
# Cambiar "8080:8080" a "8081:8080"
```

### DAGs no aparecen en Airflow
```powershell
docker-compose restart airflow-scheduler
```

### Error de memoria
```powershell
# En Docker Desktop > Settings > Resources
# Aumentar RAM a 8+ GB
```

### Logs completos
```powershell
# Ver logs de todos los servicios
docker-compose logs --tail=100

# Logs de un contenedor específico
docker-compose logs -f kedro-app
```

---

## 📈 Métricas del Proyecto

| Categoría | Cantidad |
|-----------|----------|
| **Pipelines** | 5 |
| **Nodos** | 33+ |
| **Modelos ML** | 10 |
| **DAGs Airflow** | 3 |
| **Datasets** | 7 |
| **Documentos** | 6 |
| **Scripts PowerShell** | 2 |

---

## 🤝 Contribuir

¿Mejoras o sugerencias?

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

## 👥 Autores

**League ML Team**
- Machine Learning Engineering
- Data Pipeline Development
- Docker & Airflow Integration

---

## 🙏 Agradecimientos

- **Kedro Team** por el excelente framework
- **Apache Airflow** por la orquestación robusta
- **Docker** por la containerización
- **Riot Games** por los datos de League of Legends

---

## 📞 Soporte

¿Necesitas ayuda? Consulta:

1. **[QUICK_START.md](QUICK_START.md)** - Inicio rápido
2. **[DOCKER_AIRFLOW_GUIDE.md](DOCKER_AIRFLOW_GUIDE.md)** - Guía detallada
3. **[Issues](https://github.com/tu-repo/issues)** - Reportar problemas

---

<div align="center">

### 🎉 ¡Sistema Listo para Producción!

**Con Docker, Airflow y Kedro trabajando juntos**

[⬆ Volver arriba](#-league-of-legends-ml-project---docker--airflow-edition)

</div>


