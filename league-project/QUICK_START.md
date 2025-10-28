# 🚀 Quick Start - League of Legends ML Project

## ⚡ Inicio Rápido en 5 Minutos

### 1️⃣ Pre-requisitos

```powershell
# Verificar Docker
docker --version
docker-compose --version
```

Si no tienes Docker, descárgalo: https://www.docker.com/products/docker-desktop

### 2️⃣ Setup Automático

```powershell
# Ejecutar script de configuración
.\setup_airflow_windows.ps1
```

### 3️⃣ Iniciar Servicios

```powershell
# Levantar todos los contenedores
docker-compose up -d

# Verificar que todo está corriendo
docker-compose ps
```

### 4️⃣ Acceder a Airflow

1. Abrir navegador: **http://localhost:8080**
2. Login:
   - Usuario: `admin`
   - Password: `admin`

### 5️⃣ Ejecutar tu Primer Pipeline

**Opción A: Desde Airflow UI**
- Activar el DAG `kedro_eda_pipeline`
- Click en ▶️ "Trigger DAG"

**Opción B: Desde PowerShell**
```powershell
.\run_kedro_pipeline.ps1 -Pipeline eda
```

---

## 📊 Pipelines Disponibles

| Pipeline | Descripción | Tiempo Estimado |
|----------|-------------|-----------------|
| `eda` | Limpieza + Exploración | ~2 min |
| `data_cleaning` | Solo limpieza | ~1 min |
| `data_exploration` | Solo exploración | ~30 seg |
| `data_processing` | Feature Engineering | ~2 min |
| `data_science` | Entrenar modelos | ~5 min |
| `evaluation` | Evaluar modelos | ~1 min |
| `default` | **Pipeline completo** | ~10 min |

---

## 🎯 Comandos Esenciales

```powershell
# Ver logs en tiempo real
docker-compose logs -f

# Ejecutar pipeline específico
.\run_kedro_pipeline.ps1 -Pipeline data_science

# Detener todos los servicios
docker-compose down

# Reiniciar un servicio
docker-compose restart airflow-scheduler

# Ver ayuda de scripts
.\run_kedro_pipeline.ps1 -Help
```

---

## 🔧 Troubleshooting Rápido

### ❌ Puerto 8080 ocupado
```powershell
# Editar docker-compose.yml
# Cambiar "8080:8080" a "8081:8080"
```

### ❌ DAGs no aparecen
```powershell
docker-compose restart airflow-scheduler
```

### ❌ Error de permisos
```powershell
# Reiniciar Docker Desktop
# Asegurar que tiene acceso a tu unidad C:\
```

---

## 📚 Documentación Completa

Para guía detallada, ver: **`DOCKER_AIRFLOW_GUIDE.md`**

---

## 🎓 Arquitectura Simplificada

```
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   Airflow    │─────►│    Kedro     │─────►│     Data     │
│  (Orquesta)  │      │  (Procesa)   │      │  (Resultados)│
└──────────────┘      └──────────────┘      └──────────────┘
```

---

¡Listo para analizar datos de League of Legends! 🎮🤖


