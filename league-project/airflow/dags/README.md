# 📁 Airflow DAGs

Este directorio contiene los DAGs (Directed Acyclic Graphs) para orquestar los pipelines de Kedro.

## 📊 DAGs Disponibles

### 1. `kedro_league_ml_dag.py` - Pipeline Completo de ML

**Descripción**: Ejecuta todo el flujo de ML desde limpieza hasta evaluación.

**Schedule**: Semanal (`@weekly`)

**Tareas**:
1. `data_cleaning` - Limpieza de datos raw
2. `data_exploration` - Análisis exploratorio (EDA)
3. `data_processing` - Feature engineering
4. `model_training` - Entrenamiento de modelos
5. `model_evaluation` - Evaluación de modelos
6. `generate_final_report` - Reporte consolidado

**Tiempo estimado**: ~15 minutos

**Cuándo usar**: Para reentrenar modelos con nuevos datos semanalmente.

---

### 2. `kedro_eda_only_dag.py` - Pipeline de EDA

**Descripción**: Solo ejecuta limpieza y exploración de datos.

**Schedule**: Diario (`@daily`)

**Tareas**:
1. `run_eda_pipeline` - Ejecuta limpieza + exploración

**Tiempo estimado**: ~3 minutos

**Cuándo usar**: Para monitoreo diario de calidad de datos.

---

### 3. `kedro_training_only_dag.py` - Pipeline de Entrenamiento

**Descripción**: Entrenamiento y evaluación de modelos (con verificación de datos).

**Schedule**: Manual (`None`)

**Tareas**:
1. `check_data` - Verifica si existen datos procesados
2. `process_data` - Procesa datos si es necesario (condicional)
3. `train_models` - Entrena todos los modelos
4. `evaluate_models` - Evalúa y compara modelos

**Tiempo estimado**: ~8 minutos

**Cuándo usar**: Para experimentación de modelos con datos ya procesados.

---

## 🎯 Cómo Usar los DAGs

### Desde Airflow UI

1. Ir a http://localhost:8080
2. Hacer login (admin/admin)
3. Activar el DAG deseado (toggle switch)
4. Click en el nombre del DAG
5. Click en "Trigger DAG" (botón ▶️)
6. Monitorear en Graph View o Grid View

### Desde CLI

```bash
# Listar todos los DAGs
docker-compose exec airflow-scheduler airflow dags list

# Trigger manual de un DAG
docker-compose exec airflow-scheduler airflow dags trigger kedro_eda_pipeline

# Ver estado de un DAG
docker-compose exec airflow-scheduler airflow dags state kedro_eda_pipeline
```

---

## 🔧 Personalizar DAGs

### Cambiar Schedule

Edita la línea `schedule_interval` en el DAG:

```python
dag = DAG(
    'mi_dag',
    schedule_interval='@daily',  # Cambiar aquí
    ...
)
```

Opciones comunes:
- `@once` - Una sola vez
- `@hourly` - Cada hora
- `@daily` - Diario
- `@weekly` - Semanal
- `@monthly` - Mensual
- `'0 0 * * *'` - Cron expression (medianoche diario)
- `None` - Solo manual

### Agregar Notificaciones por Email

```python
default_args = {
    'email': ['tu-email@example.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    ...
}
```

### Agregar Nuevas Tareas

```python
nueva_tarea = BashOperator(
    task_id='mi_nueva_tarea',
    bash_command='cd /opt/airflow/kedro_project && kedro run --node mi_nodo',
    dag=dag,
)

# Definir dependencias
tarea_anterior >> nueva_tarea >> tarea_siguiente
```

---

## 📊 Estructura de un DAG

```python
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'tu-equipo',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'mi_dag_name',
    default_args=default_args,
    description='Descripción del DAG',
    schedule_interval='@daily',
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['tag1', 'tag2'],
)

tarea1 = BashOperator(
    task_id='tarea1',
    bash_command='echo "Hola"',
    dag=dag,
)

tarea2 = BashOperator(
    task_id='tarea2',
    bash_command='echo "Mundo"',
    dag=dag,
)

# Dependencias
tarea1 >> tarea2
```

---

## 🐛 Debugging

### Ver Logs de una Tarea

1. En Airflow UI, click en la tarea
2. Click en "Log"

O desde CLI:
```bash
docker-compose exec airflow-scheduler airflow tasks logs \
  kedro_eda_pipeline run_eda_pipeline 2024-01-01
```

### Probar una Tarea Manualmente

```bash
docker-compose exec airflow-scheduler airflow tasks test \
  kedro_eda_pipeline run_eda_pipeline 2024-01-01
```

---

## 📚 Recursos

- [Airflow DAG Documentation](https://airflow.apache.org/docs/apache-airflow/stable/concepts/dags.html)
- [Operators Reference](https://airflow.apache.org/docs/apache-airflow/stable/operators-and-hooks-ref.html)
- [Schedule Intervals](https://airflow.apache.org/docs/apache-airflow/stable/dag-run.html)

---

## ✅ Checklist de Nuevo DAG

Antes de agregar un nuevo DAG, asegúrate de:

- [ ] Nombre de DAG único y descriptivo
- [ ] Schedule interval apropiado
- [ ] Default args configurados (retries, email, etc.)
- [ ] Tags descriptivos
- [ ] Dependencias entre tareas definidas correctamente
- [ ] Comandos Bash apuntan a rutas correctas
- [ ] DAG testeado manualmente antes de activar schedule
- [ ] Documentación actualizada

---

¡Happy Orchestrating! 🚀


