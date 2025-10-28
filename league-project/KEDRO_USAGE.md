# Guía de Uso - Proyecto Kedro de League of Legends

## 🎯 Descripción del Proyecto

Este proyecto implementa un pipeline completo de Machine Learning siguiendo la metodología **CRISP-DM** para analizar partidas profesionales de League of Legends.

### Objetivos

1. **Regresión**: Predecir la duración de una partida (`gamelength`)
2. **Clasificación**: Predecir el resultado de una partida (`bResult` - victoria/derrota del equipo azul)

## 📁 Estructura de Pipelines

El proyecto está organizado en 3 pipelines modulares:

### 1. **data_processing** 
Feature engineering y preparación de datos
- Agregación de kills, dragones, barones, torres
- Extracción de diferencias de oro
- Selección de features
- División train/test
- Estandarización con StandardScaler

### 2. **data_science**
Entrenamiento de modelos
- **Regresión**: Linear, Ridge, Lasso, Random Forest, Gradient Boosting
- **Clasificación**: Logistic Regression, Random Forest, Gradient Boosting, SVM, Naive Bayes

### 3. **evaluation**
Evaluación y reportes
- Métricas de regresión: RMSE, MAE, R²
- Métricas de clasificación: Accuracy, Precision, Recall, F1, AUC-ROC
- Feature importance
- Reportes en JSON

## 🚀 Ejecución del Pipeline

### Ejecutar Pipeline Completo

```bash
kedro run
```

Esto ejecutará los 3 pipelines en secuencia: data_processing → data_science → evaluation

### Ejecutar Pipelines Individuales

```bash
# Solo procesamiento de datos
kedro run --pipeline=data_processing
kedro run --pipeline=dp  # Alias corto

# Solo entrenamiento de modelos
kedro run --pipeline=data_science
kedro run --pipeline=ds  # Alias corto

# Solo evaluación
kedro run --pipeline=evaluation
kedro run --pipeline=eval  # Alias corto
```

### Ejecutar desde un nodo específico

```bash
# Desde el nodo de escalado en adelante
kedro run --from-nodes=scale_features_node

# Hasta un nodo específico
kedro run --to-nodes=select_features_node

# Ejecutar solo un nodo
kedro run --node=train_regression_models_node
```

## 📊 Visualización del Pipeline

### Ver estructura del pipeline

```bash
kedro viz
```

Esto abrirá una interfaz web interactiva donde podrás:
- Ver el grafo completo de dependencias
- Inspeccionar cada nodo
- Ver los datasets intermedios
- Analizar el flujo de datos

## 📂 Outputs del Pipeline

Después de ejecutar el pipeline, encontrarás:

### Datos Procesados
- `data/02_intermediate/`: Features intermedios
- `data/03_primary/`: Datos listos para modelado
- `data/04_feature/`: Train/test split y datos escalados

### Modelos Entrenados
- `data/06_models/regression_models.pkl`
- `data/06_models/classification_models.pkl`
- `data/06_models/scaler.pkl`

### Reportes y Métricas
- `data/08_reporting/regression_metrics.parquet`
- `data/08_reporting/classification_metrics.parquet`
- `data/08_reporting/regression_report.json`
- `data/08_reporting/classification_report.json`
- `data/08_reporting/regression_feature_importance.parquet`
- `data/08_reporting/classification_feature_importance.parquet`

## 🔧 Configuración

### Modificar Parámetros

Edita `conf/base/parameters.yml` para cambiar:

- Hiperparámetros de modelos
- Features utilizados
- Tamaño del test set
- Random seed

Ejemplo:
```yaml
model_options:
  test_size: 0.3  # Cambiar a 70/30 split
  
  regression_models:
    rf_n_estimators: 200  # Más árboles en Random Forest
    rf_max_depth: 20      # Mayor profundidad
```

### Modificar Datasets

Edita `conf/base/catalog.yml` para:
- Cambiar ubicaciones de archivos
- Modificar formatos (CSV, Parquet, Pickle)
- Agregar nuevos datasets

## 📈 Ver Resultados

### Leer Reportes en Python

```python
import json
import pandas as pd

# Leer reporte de regresión
with open('data/08_reporting/regression_report.json', 'r') as f:
    reg_report = json.load(f)

print(f"Mejor modelo: {reg_report['best_model']}")
print(f"R² Score: {reg_report['best_r2']:.4f}")

# Leer métricas
metrics = pd.read_parquet('data/08_reporting/regression_metrics.parquet')
print(metrics)
```

### Ver Logs

Los logs se guardan en `logs/` y también se muestran en consola durante la ejecución.

## 🧪 Testing

```bash
# Ejecutar tests
pytest

# Con cobertura
pytest --cov=league_project
```

## 📝 Comandos Útiles de Kedro

```bash
# Listar todos los pipelines
kedro registry list

# Listar todos los nodos de un pipeline
kedro registry describe data_processing

# Ver catálogo de datos
kedro catalog list

# Ver detalles de un dataset
kedro catalog describe regression_models

# Crear documentación
kedro build-docs

# Empaquetar proyecto
kedro package
```

## 🔄 Workflow Típico

1. **Desarrollo Inicial**
   ```bash
   kedro run  # Ejecutar pipeline completo
   kedro viz  # Visualizar resultados
   ```

2. **Ajuste de Hiperparámetros**
   - Editar `conf/base/parameters.yml`
   - Ejecutar solo entrenamiento:
     ```bash
     kedro run --pipeline=data_science
     ```

3. **Añadir Nuevas Features**
   - Modificar `src/league_project/pipelines/data_processing/nodes.py`
   - Actualizar lista de features en `parameters.yml`
   - Ejecutar desde data_processing:
     ```bash
     kedro run --from-nodes=aggregate_kills_node
     ```

4. **Experimentación**
   - Los datos intermedios se cachean automáticamente
   - Solo se re-ejecutan los nodos necesarios
   - Usa `--from-nodes` y `--to-nodes` para controlar la ejecución

## 📚 Estructura de Código

```
src/league_project/pipelines/
├── data_processing/
│   ├── __init__.py
│   ├── nodes.py       # Funciones de procesamiento
│   └── pipeline.py    # Definición del pipeline
├── data_science/
│   ├── __init__.py
│   ├── nodes.py       # Entrenamiento de modelos
│   └── pipeline.py    # Definición del pipeline
└── evaluation/
    ├── __init__.py
    ├── nodes.py       # Evaluación y métricas
    └── pipeline.py    # Definición del pipeline
```

## 🎓 Cumplimiento de CRISP-DM

✅ **1. Comprensión del Negocio**: Documentado en el README y comentarios del código

✅ **2. Comprensión de los Datos**: Pipeline `data_processing` - análisis inicial

✅ **3. Preparación de los Datos**: Pipeline `data_processing` - feature engineering

✅ **4. Modelado**: Pipeline `data_science` - múltiples algoritmos

✅ **5. Evaluación**: Pipeline `evaluation` - métricas y comparaciones

✅ **6. Despliegue**: Código modular listo para producción con Kedro

## 🛠️ Troubleshooting

### Error: "Dataset not found"
```bash
# Verificar que los CSV existen en data/01_raw/
ls data/01_raw/

# Verificar catálogo
kedro catalog list
```

### Error: "Module not found"
```bash
# Reinstalar dependencias
pip install -r requirements.txt

# O instalar el proyecto en modo editable
pip install -e .
```

### Pipeline muy lento
```bash
# Ejecutar solo con un subset de datos
# Modificar temporalmente los nodos para usar .head(1000)
```

## 📞 Ayuda Adicional

- Documentación oficial de Kedro: https://docs.kedro.org
- Ver los notebooks en `notebooks/` para análisis exploratorio
- Revisar logs en `logs/` para debugging

---

## 🎯 Next Steps

1. **Optimización de Hiperparámetros**: Agregar GridSearchCV
2. **Validación Cruzada**: Implementar k-fold CV
3. **Modelos Avanzados**: XGBoost, LightGBM
4. **API REST**: Desplegar modelos con FastAPI
5. **Monitoreo**: Agregar MLflow para tracking

¡Disfruta explorando los datos de League of Legends! 🎮⚔️



