# 🚀 Instrucciones de Ejecución - Solución a Errores de Airflow

## ⚠️ Problema Detectado

Los DAGs de Airflow están fallando porque **no encuentran el comando `kedro`** dentro de los contenedores.

### **Error Identificado:**
```
bash: kedro: command not found
```

**Causa:** El contenedor de Airflow no tiene acceso al ejecutable de Kedro.

---

## ✅ Solución Implementada

He corregido los **3 archivos DAG** para usar la ruta correcta del proyecto:
- ✅ `airflow/dags/kedro_eda_only_dag.py`
- ✅ `airflow/dags/kedro_league_ml_dag.py`
- ✅ `airflow/dags/kedro_training_only_dag.py`

**Cambio aplicado:**
```python
# ❌ ANTES (INCORRECTO):
bash_command='cd /opt/airflow/kedro_project && kedro run --pipeline eda'

# ✅ AHORA (CORRECTO):
bash_command='cd /app && kedro run --pipeline eda'
```

---

## 🔧 Pasos para Aplicar la Corrección

### **Paso 1: Reiniciar Airflow**

```powershell
# Detener todos los servicios
docker-compose down

# Reiniciar los servicios
docker-compose up -d

# Esperar 30 segundos para que todo se inicialice
Start-Sleep -Seconds 30
```

### **Paso 2: Verificar que los DAGs están actualizados**

```powershell
# Ver logs del scheduler
docker-compose logs airflow-scheduler | Select-String "DAG"
```

Deberías ver mensajes indicando que los DAGs se están procesando.

### **Paso 3: Ejecutar el Pipeline EDA (Recomendado para probar)**

**Opción A: Desde Airflow UI**
1. Abre http://localhost:8080
2. Login: `admin` / `admin`
3. Busca `kedro_eda_pipeline`
4. Click en el toggle para activarlo (debe ponerse azul)
5. Click en "▶️ Trigger DAG"
6. Monitorea en "Graph View"

**Opción B: Desde PowerShell**
```powershell
# Trigger el DAG desde CLI
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline

# Ver logs en tiempo real
docker-compose logs -f airflow-worker
```

---

## 🔍 Verificación de Datos

Antes de ejecutar, asegúrate de que los **datos RAW existen**:

```powershell
# Verificar que existen los archivos CSV
dir ..\league-of-legends-worlds\data\01_raw\*.csv
```

**Archivos necesarios:**
- ✅ `champions_stats.csv`
- ✅ `matches_stats.csv`
- ✅ `players_stats.csv`

Si **NO existen**, necesitas copiarlos desde la carpeta original:

```powershell
# Copiar datos desde la carpeta original
Copy-Item -Path "..\league-of-legends-worlds\data\01_raw\*" -Destination ".\data\01_raw\" -Force
```

---

## 📊 Pipelines Disponibles

### 1️⃣ **Pipeline EDA** (Recomendado para empezar)
```powershell
# Duración: ~3 minutos
# Qué hace: Limpieza + Análisis exploratorio
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline
```

**Reportes generados:**
- `data/08_reporting/descriptive_statistics.csv`
- `data/08_reporting/team_performance_analysis.csv`
- `data/08_reporting/champion_bans_analysis.csv`

### 2️⃣ **Pipeline Completo** (Todo el ML)
```powershell
# Duración: ~15 minutos
# Qué hace: Limpieza → EDA → Features → Modelos → Evaluación
docker-compose exec airflow-scheduler airflow dags trigger kedro_league_ml_pipeline
```

**Reportes generados:**
- Todos los anteriores +
- `data/08_reporting/regression_metrics.csv`
- `data/08_reporting/classification_metrics.csv`
- 10 modelos en `data/06_models/`

### 3️⃣ **Solo Modelos** (Sin reprocesar datos)
```powershell
# Duración: ~8 minutos
# Qué hace: Feature engineering → Entrenar → Evaluar
docker-compose exec airflow-scheduler airflow dags trigger kedro_model_training_pipeline
```

---

## 🐛 Troubleshooting

### **Problema 1: "kedro: command not found"**

**Solución:** Los DAGs ya están corregidos. Solo necesitas reiniciar Airflow:
```powershell
docker-compose restart airflow-scheduler airflow-worker
```

### **Problema 2: "No such file or directory: data/01_raw/..."**

**Solución:** Los datos no están en la ubicación correcta. Cópialos:
```powershell
Copy-Item -Path "..\league-of-legends-worlds\data\01_raw\*" -Destination ".\data\01_raw\" -Force
```

### **Problema 3: DAG sigue fallando después de reiniciar**

**Ver logs detallados:**
```powershell
# Logs del worker (ejecuta las tareas)
docker-compose logs airflow-worker | Select-String "ERROR"

# Logs del scheduler
docker-compose logs airflow-scheduler | Select-String "ERROR"

# Logs del kedro-app
docker-compose logs kedro-app
```

### **Problema 4: "Permission denied"**

**Solución:** Verifica permisos de carpetas:
```powershell
# Dar permisos a las carpetas de datos
icacls ".\data" /grant Everyone:F /T
```

---

## 🎯 Ejecución Alternativa (Sin Docker)

Si Docker sigue dando problemas, puedes ejecutar Kedro **directamente**:

```powershell
# 1. Navegar al proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig

# 2. Activar virtual environment
.\venv\Scripts\Activate.ps1

# 3. Navegar a la carpeta del proyecto
cd league-project

# 4. Ejecutar pipeline EDA
kedro run --pipeline eda

# 5. Ver reportes generados
dir data\08_reporting\*.csv
```

**Ventajas:**
- ✅ Más rápido (sin Docker)
- ✅ Más fácil de debuggear
- ✅ Acceso directo a los datos

**Desventajas:**
- ❌ Sin automatización de Airflow
- ❌ Sin scheduling
- ❌ Sin interfaz gráfica

---

## 📈 Verificar Resultados

### **1. Verificar que los reportes se generaron:**

```powershell
# Listar reportes generados
dir data\08_reporting\*.csv
dir data\08_reporting\*.json
```

**Deberías ver:**
```
descriptive_statistics.csv
team_performance_analysis.csv
champion_bans_analysis.csv
correlations_analysis.csv
game_duration_analysis.csv
eda_complete_report.json
```

### **2. Ver contenido de un reporte:**

```powershell
# Ver estadísticas descriptivas
Get-Content data\08_reporting\descriptive_statistics.csv | Select-Object -First 10

# Ver análisis de equipos
Get-Content data\08_reporting\team_performance_analysis.csv | Select-Object -First 10
```

### **3. Verificar modelos entrenados (si ejecutaste pipeline completo):**

```powershell
# Listar modelos guardados
dir data\06_models\*.pkl
```

**Deberías ver 10 modelos:**
- `linear_regression.pkl`
- `ridge_regression.pkl`
- `lasso_regression.pkl`
- `random_forest_regressor.pkl`
- `gradient_boosting_regressor.pkl`
- `logistic_regression.pkl`
- `random_forest_classifier.pkl`
- `gradient_boosting_classifier.pkl`
- `svm.pkl`
- `naive_bayes.pkl`

---

## 📞 Resumen de Comandos Útiles

```powershell
# REINICIAR TODO
docker-compose down && docker-compose up -d

# VER LOGS EN TIEMPO REAL
docker-compose logs -f airflow-worker

# EJECUTAR PIPELINE EDA
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline

# EJECUTAR PIPELINE COMPLETO
docker-compose exec airflow-scheduler airflow dags trigger kedro_league_ml_pipeline

# VER ESTADO DE LOS DAGS
docker-compose exec airflow-scheduler airflow dags list

# VER REPORTES GENERADOS
dir data\08_reporting\

# DETENER TODO
docker-compose down
```

---

## 🎓 Próximos Pasos

Una vez que el pipeline EDA funcione:

1. ✅ **Revisar los reportes** en `data/08_reporting/`
2. ✅ **Ejecutar el pipeline completo** para entrenar modelos
3. ✅ **Analizar las métricas** de los 10 modelos
4. ✅ **Preparar la presentación** con los resultados

---

## 📄 Documentos Relacionados

- `SOLUCION_ERROR_AIRFLOW.md` - Explicación técnica del error
- `EVALUACION_PARCIAL_CUMPLIMIENTO.md` - Verificación de requisitos
- `README_COMPLETO.md` - Documentación técnica completa
- `GUIA_PRESENTACION.md` - Script para tu presentación

---

**Última actualización:** Octubre 27, 2025  
**Estado de corrección:** ✅ Aplicada  
**Acción requerida:** Reiniciar Airflow con `docker-compose down && docker-compose up -d`

