# ✅ Solución Final - Error de Airflow + Kedro

## 🔍 Diagnóstico Completo

### **Error en los Logs:**
```bash
[2025-10-27, 20:36:02 UTC] {subprocess.py:93} INFO - /usr/bin/bash: line 1: cd: /app: No such file or directory
[2025-10-27, 20:36:02 UTC] {subprocess.py:97} INFO - Command exited with return code 1
```

### **Causa Raíz Identificada:**

El problema tenía **DOS capas**:

1. **❌ Primer intento:** Ruta incorrecta `/opt/airflow/kedro_project` no existía
2. **❌ Segundo intento:** Cambié a `/app` pero esa ruta tampoco existe en los contenedores de Airflow

### **¿Por Qué Ocurría?**

En `docker-compose.yml`:
- **Airflow** monta el proyecto en `/opt/airflow/kedro_project` (línea 24)
- **Kedro-app** monta el proyecto en `/app` (línea 128)

**Son contenedores diferentes con rutas diferentes!**

### **Segundo Problema:**
El comando `kedro` no está en el PATH de Airflow. Necesitamos usar `python -m kedro`.

---

## ✅ Solución Aplicada

### **Cambios en los 3 DAGs:**

#### 1. `kedro_eda_only_dag.py`
```python
# ✅ CORRECTO:
bash_command='cd /opt/airflow/kedro_project && python -m kedro run --pipeline eda'
```

#### 2. `kedro_league_ml_dag.py`
```python
# ✅ CORRECTO:
bash_command='cd /opt/airflow/kedro_project && python -m kedro run --pipeline data_cleaning'
```

#### 3. `kedro_training_only_dag.py`
```python
# ✅ CORRECTO:
data_path = '/opt/airflow/kedro_project/data/05_model_input/model_input_table.parquet'
bash_command='cd /opt/airflow/kedro_project && python -m kedro run --pipeline data_processing'
```

### **Clave de la Solución:**
1. ✅ Usar `/opt/airflow/kedro_project` (ruta del volumen montado en Airflow)
2. ✅ Usar `python -m kedro` en lugar de solo `kedro`

---

## 🚀 Pasos para Aplicar la Corrección

### **Paso 1: Reiniciar Airflow Completamente**

```powershell
# Detener todos los contenedores
docker-compose down

# Esperar 5 segundos
Start-Sleep -Seconds 5

# Levantar los servicios
docker-compose up -d

# Esperar a que todo se inicialice (30 segundos)
Start-Sleep -Seconds 30
```

### **Paso 2: Verificar que los DAGs se Cargaron**

```powershell
# Ver logs del scheduler para confirmar que cargó los DAGs
docker-compose logs airflow-scheduler | Select-String "kedro"
```

Deberías ver algo como:
```
[...] INFO - Loaded 3 DAGs
[...] INFO - kedro_eda_pipeline
[...] INFO - kedro_league_ml_pipeline
[...] INFO - kedro_model_training_pipeline
```

### **Paso 3: Instalar Kedro en Airflow (IMPORTANTE)**

Este es el paso crítico que faltaba:

```powershell
# Entrar al contenedor del scheduler
docker-compose exec airflow-scheduler bash

# Dentro del contenedor, instalar kedro
pip install kedro pandas numpy scikit-learn matplotlib seaborn

# Verificar instalación
python -m kedro --version

# Salir
exit
```

### **Paso 4: Repetir para el Worker**

```powershell
# Entrar al contenedor del worker
docker-compose exec airflow-worker bash

# Instalar kedro
pip install kedro pandas numpy scikit-learn matplotlib seaborn

# Salir
exit
```

### **Paso 5: Reiniciar Scheduler y Worker**

```powershell
docker-compose restart airflow-scheduler airflow-worker
```

### **Paso 6: Probar el Pipeline**

**Opción A: Desde Airflow UI**
1. Abre http://localhost:8080
2. Login: `admin` / `admin`
3. Click en `kedro_eda_pipeline`
4. Click en "▶️ Trigger DAG"
5. Monitorea en "Graph View"

**Opción B: Desde CLI**
```powershell
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline
```

### **Paso 7: Monitorear Ejecución**

```powershell
# Ver logs en tiempo real
docker-compose logs -f airflow-scheduler
```

---

## 🔧 Solución Alternativa (Más Robusta)

Si la instalación manual de kedro falla, actualiza el `docker-compose.yml` para que Airflow use la imagen personalizada de Kedro:

### **Opción A: Modificar docker-compose.yml**

```yaml
x-airflow-common: &airflow-common
  # Cambiar esta línea:
  # image: apache/airflow:2.8.0-python3.11
  
  # Por esta:
  image: league-kedro-ml:latest
  
  # O construir desde requirements:
  build:
    context: .
    dockerfile: Dockerfile.airflow
```

### **Crear Dockerfile.airflow:**

```dockerfile
FROM apache/airflow:2.8.0-python3.11

USER root
RUN apt-get update && apt-get install -y build-essential

USER airflow
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER airflow
```

Luego reconstruir:
```powershell
docker-compose build
docker-compose up -d
```

---

## ✅ Verificación de la Solución

### **1. Verificar que kedro está instalado:**

```powershell
docker-compose exec airflow-scheduler python -m kedro --version
```

**Salida esperada:**
```
kedro, version X.X.X
```

### **2. Verificar que el proyecto existe:**

```powershell
docker-compose exec airflow-scheduler ls /opt/airflow/kedro_project/
```

**Salida esperada:**
```
conf  data  logs  src  pyproject.toml  requirements.txt
```

### **3. Verificar que los datos existen:**

```powershell
docker-compose exec airflow-scheduler ls /opt/airflow/kedro_project/data/01_raw/
```

**Salida esperada:**
```
champions_stats.csv  matches_stats.csv  players_stats.csv
```

### **4. Probar kedro manualmente:**

```powershell
docker-compose exec airflow-scheduler bash -c "cd /opt/airflow/kedro_project && python -m kedro catalog list"
```

Deberías ver la lista de datasets del catálogo.

---

## 📊 Ejecución Esperada

### **Pipeline EDA Exitoso:**

```
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Kedro is starting...
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Loading catalog...
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Running pipeline: eda
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Running node: clean_main_dataset_node
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Running node: generate_descriptive_stats_node
[2025-10-27, XX:XX:XX UTC] {subprocess.py:93} INFO - Pipeline execution completed successfully
[2025-10-27, XX:XX:XX UTC] {subprocess.py:97} INFO - Command exited with return code 0
```

### **Archivos Generados:**

```
data/08_reporting/
├── descriptive_statistics.csv
├── team_performance_analysis.csv
├── champion_bans_analysis.csv
├── correlations_analysis.csv
├── game_duration_analysis.csv
└── eda_complete_report.json
```

---

## 🐛 Troubleshooting

### **Problema: "ModuleNotFoundError: No module named 'kedro'"**

**Solución:**
```powershell
# Instalar kedro en scheduler y worker
docker-compose exec airflow-scheduler pip install kedro pandas numpy scikit-learn
docker-compose exec airflow-worker pip install kedro pandas numpy scikit-learn
docker-compose restart airflow-scheduler airflow-worker
```

### **Problema: "No such file or directory: data/01_raw/..."**

**Solución:**
```powershell
# Copiar datos desde la carpeta original
Copy-Item -Path "..\league-of-legends-worlds\data\01_raw\*" -Destination ".\data\01_raw\" -Recurse -Force
```

### **Problema: "Permission denied"**

**Solución:**
```powershell
# Dar permisos a las carpetas
icacls ".\data" /grant Everyone:F /T
icacls ".\airflow" /grant Everyone:F /T
```

### **Problema: DAG sigue fallando**

**Solución:**
```powershell
# Ver logs detallados
docker-compose logs airflow-scheduler | Select-String "ERROR"
docker-compose logs airflow-worker | Select-String "ERROR"

# Verificar configuración
docker-compose exec airflow-scheduler airflow dags show kedro_eda_pipeline
```

---

## 🎯 Resumen de Comandos

```powershell
# 1. REINICIAR TODO
docker-compose down
docker-compose up -d

# 2. INSTALAR KEDRO (CRÍTICO)
docker-compose exec airflow-scheduler pip install kedro pandas numpy scikit-learn matplotlib seaborn
docker-compose exec airflow-worker pip install kedro pandas numpy scikit-learn matplotlib seaborn

# 3. REINICIAR SERVICIOS
docker-compose restart airflow-scheduler airflow-worker

# 4. VERIFICAR INSTALACIÓN
docker-compose exec airflow-scheduler python -m kedro --version

# 5. TRIGGER DAG
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline

# 6. MONITOREAR
docker-compose logs -f airflow-scheduler
```

---

## 📝 Lecciones Aprendidas

1. **Volúmenes en Docker:** Cada contenedor tiene su propio filesystem. Los volúmenes deben estar correctamente mapeados.

2. **Dependencias:** Airflow no incluye Kedro por defecto. Hay que instalarlo explícitamente.

3. **PATH vs python -m:** Usar `python -m kedro` es más robusto que confiar en que `kedro` esté en el PATH.

4. **Testing:** Siempre verificar que las rutas existen y las dependencias están instaladas antes de ejecutar pipelines.

---

## 🎓 Próximos Pasos

Una vez que funcione:

1. ✅ **Ejecutar pipeline EDA** (~3 min)
2. ✅ **Revisar reportes** en `data/08_reporting/`
3. ✅ **Ejecutar pipeline completo** (~15 min)
4. ✅ **Analizar métricas** de los 10 modelos
5. ✅ **Preparar presentación** con resultados reales

---

**Última actualización:** Octubre 27, 2025  
**Estado:** ✅ Solución completa aplicada  
**Acción requerida:** Instalar kedro en contenedores de Airflow + Reiniciar servicios

