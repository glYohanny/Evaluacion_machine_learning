# 🚀 Guía Completa: Kedro + Docker + Airflow en Windows

## 📋 Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Arquitectura del Sistema](#arquitectura-del-sistema)
3. [Instalación Inicial](#instalación-inicial)
4. [Configuración de Docker](#configuración-de-docker)
5. [Configuración de Airflow](#configuración-de-airflow)
6. [Ejecutar Pipelines](#ejecutar-pipelines)
7. [Monitoreo y Logs](#monitoreo-y-logs)
8. [Solución de Problemas](#solución-de-problemas)
9. [Comandos Útiles](#comandos-útiles)

---

## 🔧 Requisitos Previos

### Software Necesario

1. **Docker Desktop para Windows**
   - Descargar desde: https://www.docker.com/products/docker-desktop
   - Versión recomendada: 4.25+
   - Asegúrate de habilitar WSL 2 (Windows Subsystem for Linux)

2. **PowerShell 7+** (recomendado)
   - Descargar desde: https://github.com/PowerShell/PowerShell/releases

3. **Git** (opcional, para control de versiones)

### Recursos del Sistema

- **RAM**: Mínimo 8 GB (recomendado 16 GB)
- **CPU**: 4 cores o más
- **Disco**: Al menos 20 GB libres
- **Windows**: 10/11 Pro o Enterprise (para Docker Desktop)

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────┐
│                    WINDOWS HOST                         │
│                                                         │
│  ┌────────────────────────────────────────────────┐   │
│  │           DOCKER CONTAINERS                     │   │
│  │                                                 │   │
│  │  ┌──────────────┐  ┌──────────────┐           │   │
│  │  │   Airflow    │  │  PostgreSQL  │           │   │
│  │  │  Webserver   │◄─┤   Database   │           │   │
│  │  │  :8080       │  │   :5432      │           │   │
│  │  └──────────────┘  └──────────────┘           │   │
│  │         ▲                                       │   │
│  │         │                                       │   │
│  │  ┌──────────────┐  ┌──────────────┐           │   │
│  │  │   Airflow    │  │    Kedro     │           │   │
│  │  │  Scheduler   │─►│  Application │           │   │
│  │  └──────────────┘  └──────────────┘           │   │
│  │                                                 │   │
│  └────────────────────────────────────────────────┘   │
│                         │                              │
│                         ▼                              │
│                  ┌─────────────┐                       │
│                  │    Data/    │                       │
│                  │    Logs/    │                       │
│                  │   Config    │                       │
│                  └─────────────┘                       │
└─────────────────────────────────────────────────────────┘
```

### Componentes

1. **Kedro Application**: Tu pipeline de ML
2. **Airflow Webserver**: UI web para gestionar DAGs
3. **Airflow Scheduler**: Orquesta y ejecuta tareas
4. **PostgreSQL**: Base de datos de metadatos de Airflow

---

## 📦 Instalación Inicial

### Paso 1: Preparar el Proyecto

```powershell
# Navegar al directorio del proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig\league-project

# Verificar que tienes los archivos necesarios
ls Dockerfile, docker-compose.yml, setup_airflow_windows.ps1
```

### Paso 2: Ejecutar Setup Automático

```powershell
# Dar permisos de ejecución al script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Ejecutar script de configuración
.\setup_airflow_windows.ps1
```

El script hará:
- ✅ Verificar instalación de Docker
- ✅ Crear directorios necesarios
- ✅ Construir imagen de Kedro
- ✅ Inicializar base de datos de Airflow
- ✅ Crear usuario admin

---

## 🐳 Configuración de Docker

### Construir la Imagen de Kedro

```powershell
# Construir manualmente (si no usaste el script)
docker build -t league-kedro-ml:latest .

# Verificar la imagen
docker images | Select-String "league-kedro"
```

### Configurar Variables de Entorno

El archivo `.env` contiene:

```env
AIRFLOW_UID=50000
AIRFLOW_PROJ_DIR=.
_AIRFLOW_WWW_USER_USERNAME=admin
_AIRFLOW_WWW_USER_PASSWORD=admin
POSTGRES_USER=airflow
POSTGRES_PASSWORD=airflow
POSTGRES_DB=airflow
KEDRO_ENV=local
```

---

## ✈️ Configuración de Airflow

### Iniciar Servicios

```powershell
# Iniciar todos los contenedores en segundo plano
docker-compose up -d

# Ver el estado de los contenedores
docker-compose ps
```

### Acceder a Airflow Web UI

1. Abrir navegador: **http://localhost:8080**
2. Usuario: `admin`
3. Contraseña: `admin`

### Verificar DAGs Disponibles

En la UI de Airflow verás:

- **`kedro_league_ml_pipeline`**: Pipeline completo de ML
- **`kedro_eda_pipeline`**: Solo EDA (Limpieza + Exploración)
- **`kedro_model_training_pipeline`**: Solo entrenamiento de modelos

---

## 🎯 Ejecutar Pipelines

### Opción 1: Desde Airflow UI

1. Ir a http://localhost:8080
2. Activar el DAG que desees (toggle a la izquierda)
3. Click en el nombre del DAG
4. Click en "Trigger DAG" (botón ▶️)
5. Monitorear el progreso en el Graph View

### Opción 2: Desde PowerShell con Script

```powershell
# Ejecutar pipeline completo
.\run_kedro_pipeline.ps1

# Ejecutar pipeline específico
.\run_kedro_pipeline.ps1 -Pipeline eda
.\run_kedro_pipeline.ps1 -Pipeline data_science

# Ver ayuda
.\run_kedro_pipeline.ps1 -Help
```

### Opción 3: Comandos Docker Directos

```powershell
# Pipeline completo
docker-compose run --rm kedro-app kedro run

# Pipeline específico
docker-compose run --rm kedro-app kedro run --pipeline eda
docker-compose run --rm kedro-app kedro run --pipeline data_cleaning
docker-compose run --rm kedro-app kedro run --pipeline data_science

# Ver ayuda de Kedro
docker-compose run --rm kedro-app kedro --help
```

---

## 📊 Monitoreo y Logs

### Ver Logs de Todos los Servicios

```powershell
# Logs en tiempo real
docker-compose logs -f

# Logs de un servicio específico
docker-compose logs -f airflow-webserver
docker-compose logs -f airflow-scheduler
docker-compose logs -f kedro-app
```

### Ver Estado de Contenedores

```powershell
# Lista de contenedores corriendo
docker-compose ps

# Estadísticas de recursos
docker stats
```

### Acceder a un Contenedor

```powershell
# Shell interactivo en Airflow
docker-compose exec airflow-webserver bash

# Shell interactivo en Kedro
docker-compose run --rm kedro-app bash
```

### Logs de Airflow

Los logs de Airflow se guardan en:
- **Host**: `./airflow/logs/`
- **Container**: `/opt/airflow/logs/`

---

## 🔍 Solución de Problemas

### Problema: Puerto 8080 ya en uso

```powershell
# Verificar qué proceso usa el puerto
netstat -ano | findstr :8080

# Cambiar el puerto en docker-compose.yml
# Buscar: "8080:8080" y cambiar a "8081:8080"
```

### Problema: Contenedor no inicia

```powershell
# Ver logs detallados
docker-compose logs airflow-webserver

# Reiniciar todos los servicios
docker-compose down
docker-compose up -d
```

### Problema: Airflow no ve los DAGs

```powershell
# Verificar que los DAGs están en el lugar correcto
ls airflow\dags\*.py

# Reiniciar el scheduler
docker-compose restart airflow-scheduler
```

### Problema: Error de permisos en Windows

```powershell
# Asegurar que Docker Desktop tiene acceso a tu unidad
# Settings > Resources > File Sharing > Agregar C:\

# Dar permisos a carpeta
icacls ".\airflow" /grant Everyone:F /T
```

### Problema: Base de datos corrupta

```powershell
# Eliminar volumen y reiniciar
docker-compose down -v
docker-compose up airflow-init
docker-compose up -d
```

---

## 🛠️ Comandos Útiles

### Gestión de Docker Compose

```powershell
# Iniciar servicios
docker-compose up -d

# Detener servicios
docker-compose stop

# Detener y eliminar contenedores
docker-compose down

# Detener y eliminar volúmenes (¡cuidado!)
docker-compose down -v

# Reconstruir imágenes
docker-compose build

# Ver logs
docker-compose logs -f [servicio]

# Reiniciar un servicio
docker-compose restart [servicio]

# Escalar un servicio
docker-compose up -d --scale kedro-app=3
```

### Comandos de Kedro

```powershell
# Ejecutar pipeline completo
docker-compose run --rm kedro-app kedro run

# Ejecutar nodo específico
docker-compose run --rm kedro-app kedro run --node clean_main_dataset_node

# Ejecutar desde un nodo
docker-compose run --rm kedro-app kedro run --from-nodes train_regression_models_node

# Ejecutar hasta un nodo
docker-compose run --rm kedro-app kedro run --to-nodes evaluate_regression_node

# Ver estructura del pipeline
docker-compose run --rm kedro-app kedro pipeline list

# Ver catálogo de datos
docker-compose run --rm kedro-app kedro catalog list
```

### Limpieza de Docker

```powershell
# Eliminar contenedores detenidos
docker container prune -f

# Eliminar imágenes no usadas
docker image prune -a -f

# Eliminar volúmenes no usados
docker volume prune -f

# Limpieza completa
docker system prune -a --volumes -f
```

---

## 📈 Flujo de Trabajo Recomendado

### 1. Desarrollo Local

```powershell
# Activar entorno virtual
..\venv\Scripts\Activate.ps1

# Probar pipeline localmente
kedro run --pipeline eda

# Desactivar entorno
deactivate
```

### 2. Prueba en Docker

```powershell
# Reconstruir imagen con cambios
docker-compose build kedro-app

# Ejecutar en Docker
docker-compose run --rm kedro-app kedro run --pipeline eda
```

### 3. Orquestación con Airflow

```powershell
# Asegurar que Airflow está corriendo
docker-compose up -d

# Activar y ejecutar DAG desde UI
# http://localhost:8080
```

---

## 🎓 Recursos Adicionales

- **Kedro Docs**: https://docs.kedro.org
- **Airflow Docs**: https://airflow.apache.org/docs/
- **Docker Compose**: https://docs.docker.com/compose/

---

## 📝 Checklist de Deployment

- [ ] Docker Desktop instalado y corriendo
- [ ] WSL 2 configurado (Windows)
- [ ] Script `setup_airflow_windows.ps1` ejecutado
- [ ] Imagen de Kedro construida
- [ ] Airflow inicializado
- [ ] Servicios corriendo (`docker-compose ps`)
- [ ] Airflow UI accesible (http://localhost:8080)
- [ ] DAGs visibles en Airflow
- [ ] Pipeline de prueba ejecutado exitosamente
- [ ] Logs accesibles y sin errores críticos

---

## 🎉 ¡Listo para Producción!

Tu pipeline de Machine Learning de League of Legends está ahora:
- ✅ Dockerizado
- ✅ Orquestado con Airflow
- ✅ Listo para ejecución automatizada
- ✅ Monitoreable y escalable

¡Feliz análisis de datos! 🚀


