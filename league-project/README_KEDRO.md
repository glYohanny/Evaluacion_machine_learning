# 🎮 League of Legends - Machine Learning Project con Kedro

Proyecto completo de Machine Learning aplicando la metodología **CRISP-DM** para analizar y predecir resultados de partidas profesionales de League of Legends.

## 🎯 Objetivos del Proyecto

### Problema 1: Regresión
**Predecir la duración de una partida** (`gamelength` en minutos)
- Útil para planificación de torneos
- Estimación de tiempo de juego
- Análisis de meta-game

### Problema 2: Clasificación
**Predecir el resultado de una partida** (`bResult`: Victoria/Derrota del equipo azul)
- Análisis de factores clave de victoria
- Identificación de objetivos críticos
- Estrategias de juego

## 📊 Metodología CRISP-DM Implementada

```
1. Comprensión del Negocio  ──→  Objetivos definidos (Regresión + Clasificación)
                                  ↓
2. Comprensión de Datos      ──→  Pipeline: data_processing
                                  ↓
3. Preparación de Datos      ──→  Feature Engineering, Limpieza
                                  ↓
4. Modelado                  ──→  Pipeline: data_science
                                  ↓
5. Evaluación                ──→  Pipeline: evaluation
                                  ↓
6. Despliegue                ──→  Código modular con Kedro
```

## 🏗️ Arquitectura del Proyecto

### Pipelines Kedro

```
📦 league-project
├── 🔄 data_processing       Feature Engineering
│   ├── Agregación de kills, dragons, barons, torres
│   ├── Extracción de gold difference
│   ├── Selección de features
│   ├── Split train/test (80/20)
│   └── Estandarización (StandardScaler)
│
├── 🤖 data_science          Entrenamiento de Modelos
│   ├── Regresión: 5 algoritmos
│   │   • Linear Regression
│   │   • Ridge Regression
│   │   • Lasso Regression
│   │   • Random Forest Regressor
│   │   • Gradient Boosting Regressor
│   │
│   └── Clasificación: 5 algoritmos
│       • Logistic Regression
│       • Random Forest Classifier
│       • Gradient Boosting Classifier
│       • SVM
│       • Naive Bayes
│
└── 📊 evaluation            Evaluación y Reportes
    ├── Métricas de regresión (RMSE, MAE, R²)
    ├── Métricas de clasificación (Accuracy, F1, AUC-ROC)
    ├── Feature importance
    └── Reportes en JSON
```

## 🚀 Quick Start

### 1. Instalación

```bash
# Activar entorno virtual
cd league-project
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate

# Instalar dependencias
pip install -r requirements.txt

# Instalar proyecto en modo editable
pip install -e .
```

### 2. Ejecutar Pipeline Completo

```bash
# Ejecutar todos los pipelines
kedro run

# Visualizar pipeline interactivo
kedro viz
```

### 3. Ver Resultados

```bash
# Ejecutar script de demostración
python notebooks/demo_kedro_results.py
```

## 📂 Estructura de Datos

```
data/
├── 01_raw/                    # Datos originales (CSV)
│   ├── matchinfo.csv          # Info de partidas
│   ├── kills.csv              # Kills por partida
│   ├── gold.csv               # Gold difference minuto a minuto
│   ├── monsters.csv           # Dragones y barones
│   ├── structures.csv         # Torres e inhibidores
│   └── bans.csv               # Campeones baneados
│
├── 02_intermediate/           # Features intermedios (Parquet)
├── 03_primary/                # Datos procesados
├── 04_feature/                # Train/Test split
├── 06_models/                 # Modelos entrenados (PKL)
└── 08_reporting/              # Métricas y reportes
    ├── regression_metrics.parquet
    ├── classification_metrics.parquet
    ├── regression_report.json
    └── classification_report.json
```

## 🎓 Features Utilizados

18 features engineered en total:

### Combate
- `blue_kills`, `red_kills`, `kill_diff`

### Objetivos Neutrales
- `blue_dragons`, `red_dragons`, `dragon_diff`
- `blue_barons`, `red_barons`, `baron_diff`

### Estructuras
- `blue_towers`, `red_towers`, `tower_diff`
- `blue_inhibs`, `red_inhibs`, `inhib_diff`

### Economía
- `gold_diff_10`, `gold_diff_15`, `gold_diff_20`

## 📈 Resultados Esperados

### Regresión (Duración del Juego)
- **RMSE**: ~3-5 minutos
- **R²**: 0.80-0.85
- **Mejor modelo**: Random Forest / Gradient Boosting

### Clasificación (Resultado del Juego)
- **Accuracy**: 95%+
- **F1-Score**: 0.95+
- **AUC-ROC**: 0.98+
- **Mejor modelo**: Random Forest / Gradient Boosting

> **Nota**: Alta precisión porque los features agregados contienen información del juego completo.

## 🔧 Comandos Útiles

### Ejecución Selectiva

```bash
# Solo procesamiento de datos
kedro run --pipeline=data_processing

# Solo entrenamiento de modelos
kedro run --pipeline=data_science

# Solo evaluación
kedro run --pipeline=evaluation

# Desde un nodo específico
kedro run --from-nodes=train_regression_models_node

# Hasta un nodo específico
kedro run --to-nodes=scale_features_node
```

### Información del Proyecto

```bash
# Listar pipelines
kedro registry list

# Ver estructura de un pipeline
kedro registry describe data_processing

# Ver catálogo de datos
kedro catalog list

# Inspeccionar un dataset
kedro catalog describe regression_models
```

### Visualización

```bash
# Abrir Kedro Viz (interfaz web)
kedro viz

# Abrir Jupyter Lab
kedro jupyter lab
```

## 📊 Acceso a Resultados

### Desde Python

```python
import json
import pandas as pd
import pickle

# Leer reporte de regresión
with open('data/08_reporting/regression_report.json') as f:
    report = json.load(f)
    
print(f"Mejor modelo: {report['best_model']}")
print(f"R² Score: {report['best_r2']:.4f}")

# Leer métricas
metrics = pd.read_parquet('data/08_reporting/regression_metrics.parquet')

# Cargar modelos entrenados
with open('data/06_models/regression_models.pkl', 'rb') as f:
    models = pickle.load(f)

# Hacer predicción
best_model = models[report['best_model']]
prediction = best_model.predict(X_test_sample)
```

### Script de Demostración

```bash
python notebooks/demo_kedro_results.py
```

Este script muestra:
- ✅ Mejores modelos y sus métricas
- ✅ Top features más importantes
- ✅ Ejemplo de predicción
- ✅ Estadísticas del dataset

## 🎨 Visualizaciones

El proyecto incluye:
- 📊 Kedro Viz: Grafo interactivo de pipelines
- 📈 Jupyter Notebook: `analisis_lol_crisp_dm.ipynb` con visualizaciones detalladas
- 📉 Reportes: Métricas en formato tabla

## ✅ Buenas Prácticas Implementadas

### Código Limpio
- ✅ Funciones modulares y reutilizables
- ✅ Type hints en Python
- ✅ Logging estructurado
- ✅ Documentación completa

### Data Science
- ✅ Feature engineering justificado
- ✅ Tratamiento de missing values (imputación con mediana)
- ✅ Detección de outliers (método IQR)
- ✅ Estandarización correcta (fit en train, transform en test)
- ✅ Múltiples modelos comparados
- ✅ Métricas apropiadas para cada problema

### Kedro Best Practices
- ✅ Pipelines modulares
- ✅ Catálogo de datos bien organizado
- ✅ Parámetros centralizados
- ✅ Separación de capas de datos
- ✅ Reproducibilidad con random_state

## 📝 Configuración

### Modificar Hiperparámetros

Edita `conf/base/parameters.yml`:

```yaml
model_options:
  test_size: 0.2
  random_state: 42
  
  regression_models:
    rf_n_estimators: 100
    rf_max_depth: 15
    gb_learning_rate: 0.1
  
  classification_models:
    rf_n_estimators: 100
    svm_kernel: rbf
```

### Modificar Features

En `conf/base/parameters.yml`, edita la lista `feature_columns`:

```yaml
model_options:
  feature_columns:
    - blue_kills
    - kill_diff
    - tower_diff
    # ... agregar o quitar features
```

## 🔬 Testing

```bash
# Ejecutar tests
pytest

# Con cobertura
pytest --cov=league_project

# Tests específicos
pytest tests/pipelines/test_data_processing.py
```

## 📚 Documentación Adicional

- **KEDRO_USAGE.md**: Guía detallada de uso de Kedro
- **notebooks/analisis_lol_crisp_dm.ipynb**: Análisis exploratorio completo
- **notebooks/demo_kedro_results.py**: Script de demostración

## 🚀 Next Steps

### Mejoras Potenciales

1. **Optimización de Hiperparámetros**
   - Implementar GridSearchCV
   - Validación cruzada k-fold

2. **Modelos Avanzados**
   - XGBoost
   - LightGBM
   - Redes neuronales

3. **Feature Engineering Avanzado**
   - Información temporal (early/late game)
   - Composición de campeones
   - Sinergias entre campeones

4. **Predicción Temprana**
   - Entrenar con datos solo hasta minuto 15
   - Evaluar capacidad predictiva early game

5. **Despliegue**
   - API REST con FastAPI
   - Dockerización
   - CI/CD con GitHub Actions

## 🤝 Contribuir

1. Fork el proyecto
2. Crear feature branch (`git checkout -b feature/nueva-feature`)
3. Commit cambios (`git commit -m 'Add nueva-feature'`)
4. Push a branch (`git push origin feature/nueva-feature`)
5. Abrir Pull Request

## 📄 Licencia

Este proyecto es educacional y usa datos públicos de partidas profesionales de League of Legends.

## 👥 Autores

- **Análisis y Modelado**: Proyecto de Machine Learning
- **Framework**: Kedro
- **Metodología**: CRISP-DM

---

## 🎮 ¡Disfruta analizando los datos de League of Legends!

Para más información, consulta la documentación en `KEDRO_USAGE.md` o abre Kedro Viz con `kedro viz`.



