# 🔧 Solución: Error en DAGs de Airflow

## ❌ Problema Identificado

**Error:** Los DAGs de Airflow fallaban con el mensaje:
```
Task ID: run_eda_pipeline
Status: failed
Duration: 00:00:00
```

## 🔍 Diagnóstico

### **Causa Raíz:**
Los DAGs estaban configurados con una ruta incorrecta al proyecto Kedro:

```python
# ❌ INCORRECTO:
bash_command='cd /opt/airflow/kedro_project && kedro run --pipeline eda'
```

**Problema:** La ruta `/opt/airflow/kedro_project` no existe en el contenedor Docker.

### **Ruta Correcta:**
Según el `docker-compose.yml`, el proyecto se monta en `/app`:

```yaml
volumes:
  - ./data:/app/data
  - ./conf:/app/conf
  - ./src:/app/src
```

## ✅ Solución Aplicada

### **Archivos Corregidos:**

#### 1. `airflow/dags/kedro_eda_only_dag.py`
```python
# ✅ CORRECTO:
eda_task = BashOperator(
    task_id='run_eda_pipeline',
    bash_command='cd /app && kedro run --pipeline eda',
    dag=dag,
)
```

#### 2. `airflow/dags/kedro_league_ml_dag.py`
```python
# ✅ CORRECTO:
data_cleaning_task = BashOperator(
    task_id='data_cleaning',
    bash_command='cd /app && kedro run --pipeline data_cleaning',
    dag=dag,
)

data_exploration_task = BashOperator(
    task_id='data_exploration',
    bash_command='cd /app && kedro run --pipeline data_exploration',
    dag=dag,
)

# ... (todos los demás tasks corregidos)
```

#### 3. `airflow/dags/kedro_training_only_dag.py`
```python
# ✅ CORRECTO:
def check_processed_data(**context):
    data_path = '/app/data/05_model_input/model_input_table.parquet'
    # ...

process_data_task = BashOperator(
    task_id='process_data',
    bash_command='cd /app && kedro run --pipeline data_processing',
    dag=dag,
)

train_models_task = BashOperator(
    task_id='train_models',
    bash_command='cd /app && kedro run --pipeline data_science',
    trigger_rule='none_failed_or_skipped',
    dag=dag,
)

evaluate_models_task = BashOperator(
    task_id='evaluate_models',
    bash_command='cd /app && kedro run --pipeline evaluation',
    dag=dag,
)
```

---

## 🚀 Pasos para Aplicar la Corrección

### **Opción 1: Reiniciar Airflow (Recomendado)**

```powershell
# 1. Detener los servicios
docker-compose down

# 2. Reiniciar los servicios
docker-compose up -d

# 3. Verificar que los DAGs están cargados
docker-compose logs airflow-scheduler | Select-String "DAG"

# 4. Acceder a Airflow UI
# http://localhost:8080
# Usuario: admin
# Password: admin
```

### **Opción 2: Reiniciar Solo el Scheduler**

```powershell
# Reiniciar solo el scheduler (más rápido)
docker-compose restart airflow-scheduler

# Verificar logs
docker-compose logs -f airflow-scheduler
```

### **Opción 3: Forzar Recarga de DAGs**

```powershell
# Entrar al contenedor del scheduler
docker-compose exec airflow-scheduler bash

# Dentro del contenedor:
airflow dags reserialize

# Salir
exit
```

---

## 🧪 Verificación

### **1. Verificar que los DAGs están activos**

```powershell
# Listar todos los DAGs
docker-compose exec airflow-scheduler airflow dags list
```

**Salida esperada:**
```
kedro_eda_pipeline
kedro_league_ml_pipeline
kedro_model_training_pipeline
```

### **2. Verificar configuración de un DAG**

```powershell
# Ver detalles de un DAG específico
docker-compose exec airflow-scheduler airflow dags show kedro_eda_pipeline
```

### **3. Ejecutar un DAG manualmente (Test)**

```powershell
# Trigger manual desde CLI
docker-compose exec airflow-scheduler airflow dags test kedro_eda_pipeline 2024-10-27
```

### **4. Verificar en la UI de Airflow**

1. Abre http://localhost:8080
2. Login: `admin` / `admin`
3. Ve a la lista de DAGs
4. Verifica que los 3 DAGs aparecen sin errores
5. Click en `kedro_eda_pipeline`
6. Click en "▶️ Trigger DAG"
7. Monitorea en "Graph View"

---

## 📊 Estado Esperado Después de la Corrección

### **DAG: kedro_eda_pipeline**
```
Status: ✅ Success
Task ID: run_eda_pipeline
Duration: ~3 minutes
Output: Reportes en data/08_reporting/
```

### **DAG: kedro_league_ml_pipeline**
```
Status: ✅ Success
Tasks:
  ✅ data_cleaning (~1 min)
  ✅ data_exploration (~2 min)
  ✅ data_processing (~2 min)
  ✅ model_training (~8 min)
  ✅ model_evaluation (~2 min)
  ✅ generate_final_report (<1 min)
Total Duration: ~15 minutes
```

### **DAG: kedro_model_training_pipeline**
```
Status: ✅ Success
Tasks:
  ✅ check_data (<1 min)
  ✅ train_models (~8 min)
  ✅ evaluate_models (~2 min)
Total Duration: ~10 minutes
```

---

## 🔍 Troubleshooting Adicional

### **Problema 1: DAG sigue fallando**

**Verificar logs del scheduler:**
```powershell
docker-compose logs airflow-scheduler | Select-String "ERROR"
```

**Verificar logs de la tarea específica:**
```powershell
docker-compose logs airflow-worker | Select-String "kedro"
```

### **Problema 2: DAG no aparece en la UI**

**Verificar que el archivo está en la carpeta correcta:**
```powershell
dir airflow\dags
```

**Salida esperada:**
```
kedro_eda_only_dag.py
kedro_league_ml_dag.py
kedro_training_only_dag.py
```

**Verificar sintaxis del DAG:**
```powershell
docker-compose exec airflow-scheduler python /opt/airflow/dags/kedro_eda_only_dag.py
```

### **Problema 3: Kedro no encuentra los datos**

**Verificar volúmenes montados:**
```powershell
docker-compose exec kedro-app ls -la /app/data/01_raw/
```

**Salida esperada:**
```
champions_stats.csv
matches_stats.csv
players_stats.csv
...
```

### **Problema 4: Permisos de archivos**

```powershell
# Windows puede tener problemas de permisos
# Verifica que Docker Desktop tiene acceso a la carpeta

# En Docker Desktop:
Settings → Resources → File Sharing
# Asegúrate de que C:\Users\pedri\OneDrive\Desktop está compartido
```

---

## 📝 Prevención de Errores Futuros

### **Checklist al crear nuevos DAGs:**

- [ ] Usar ruta `/app` para el proyecto Kedro
- [ ] Verificar que el comando kedro funciona: `cd /app && kedro run`
- [ ] Probar el DAG con `airflow dags test`
- [ ] Verificar logs después de la primera ejecución
- [ ] Documentar cualquier configuración especial

### **Template de BashOperator correcto:**

```python
# ✅ Template recomendado:
task_name = BashOperator(
    task_id='descriptive_task_id',
    bash_command='cd /app && kedro run --pipeline PIPELINE_NAME',
    dag=dag,
)
```

---

## 🎓 Lecciones Aprendidas

### **1. Consistencia de Rutas**
- Docker monta el proyecto en `/app`
- Todos los comandos deben usar esta ruta
- Revisar `docker-compose.yml` para confirmar volúmenes

### **2. Testing de DAGs**
- Siempre probar DAGs con `airflow dags test` antes de deploy
- Verificar logs del scheduler regularmente
- Usar Airflow UI para monitoreo visual

### **3. Documentación**
- Documentar rutas y configuraciones específicas
- Mantener este documento actualizado con nuevos errores
- Compartir soluciones con el equipo

---

## 📚 Referencias

### **Documentación Relacionada:**
- `DOCKER_AIRFLOW_GUIDE.md` - Guía completa de Docker y Airflow
- `QUICK_START.md` - Inicio rápido
- `README_COMPLETO.md` - Guía técnica exhaustiva

### **Recursos Oficiales:**
- [Apache Airflow Docs](https://airflow.apache.org/docs/)
- [Kedro Docs](https://kedro.readthedocs.io/)
- [Docker Compose Docs](https://docs.docker.com/compose/)

---

**Última Actualización:** Octubre 27, 2025  
**Estado:** ✅ Resuelto  
**Reportado por:** Sistema de Monitoreo  
**Solucionado por:** Equipo de Desarrollo

