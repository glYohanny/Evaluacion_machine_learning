# 🔧 Instrucciones para Arreglar Airflow - Solución Definitiva

## 📋 Lo Que Hicimos

1. ✅ Creamos `Dockerfile.airflow` con Kedro pre-instalado
2. ✅ Actualizamos `docker-compose.yml` para usar la imagen personalizada

---

## 🚀 Pasos para Ejecutar

### **Paso 1: Detener Servicios Actuales**

```powershell
docker-compose down
```

**Qué hace:** Detiene todos los contenedores de Airflow, PostgreSQL, etc.

---

### **Paso 2: Construir Nueva Imagen con Kedro**

```powershell
docker-compose build
```

**Qué hace:** 
- Lee `Dockerfile.airflow`
- Instala Kedro, pandas, numpy, scikit-learn, etc.
- Crea imagen `league-airflow-kedro:latest`

**Duración:** 5-10 minutos (primera vez)

**Salida esperada:**
```
[+] Building XX.Xs (X/X) FINISHED
=> [internal] load build definition from Dockerfile.airflow
=> => transferring dockerfile: XXB
=> [internal] load .dockerignore
...
=> => naming to docker.io/library/league-airflow-kedro:latest
```

---

### **Paso 3: Levantar Servicios con Nueva Imagen**

```powershell
docker-compose up -d
```

**Qué hace:**
- Inicia PostgreSQL
- Inicia Airflow Scheduler (con Kedro incluido)
- Inicia Airflow Webserver (con Kedro incluido)

**Duración:** 30-60 segundos

---

### **Paso 4: Esperar Inicialización**

```powershell
# Esperar 30 segundos para que todo se inicialice
Start-Sleep -Seconds 30

# Verificar que los servicios están corriendo
docker-compose ps
```

**Salida esperada:**
```
NAME                                 IMAGE                          SERVICE             STATUS
league-project-airflow-scheduler-1   league-airflow-kedro:latest   airflow-scheduler   Up (healthy)
league-project-airflow-webserver-1   league-airflow-kedro:latest   airflow-webserver   Up (healthy)
league-project-postgres-1            postgres:15                    postgres            Up (healthy)
```

---

### **Paso 5: Verificar que Kedro está Instalado**

```powershell
# Verificar en el scheduler
docker-compose exec airflow-scheduler python -m kedro --version
```

**Salida esperada:**
```
kedro, version 0.19.x
```

Si ves esta salida, **¡ÉXITO!** ✅

---

### **Paso 6: Acceder a Airflow UI**

1. Abre navegador: http://localhost:8080
2. Login: `admin` / `admin`
3. Deberías ver tus 3 DAGs:
   - `kedro_eda_pipeline`
   - `kedro_league_ml_pipeline`
   - `kedro_model_training_pipeline`

---

### **Paso 7: Trigger Manual de un DAG**

1. Click en `kedro_eda_pipeline`
2. Click en botón **▶️ "Trigger DAG"** (arriba derecha)
3. Ve a **"Graph View"**
4. Observa cómo las tareas se ejecutan
5. Espera ~3 minutos

**Resultado esperado:**
- Todas las cajas en **verde** ✅
- Status: "Success"

---

## 🎯 Troubleshooting

### **Problema 1: Build falla con error de permisos**

```powershell
# Asegúrate de tener Docker Desktop corriendo
# Reinicia Docker Desktop si es necesario
```

### **Problema 2: "Port 8080 already in use"**

```powershell
# Detener todo
docker-compose down

# Verificar que no hay nada en el puerto
netstat -ano | findstr :8080

# Si hay algo, matar el proceso
taskkill /PID <PID> /F

# Reiniciar
docker-compose up -d
```

### **Problema 3: Servicios no están "healthy"**

```powershell
# Ver logs del scheduler
docker-compose logs airflow-scheduler

# Ver logs del webserver
docker-compose logs airflow-webserver

# Reiniciar servicios
docker-compose restart airflow-scheduler airflow-webserver
```

### **Problema 4: DAG sigue fallando**

```powershell
# Ver logs del scheduler en tiempo real
docker-compose logs -f airflow-scheduler

# En otra terminal, trigger el DAG desde CLI
docker-compose exec airflow-scheduler airflow dags test kedro_eda_pipeline 2025-10-27
```

---

## ✅ Verificación Final

### **Checklist:**

- [ ] `docker-compose ps` muestra 3 servicios "healthy"
- [ ] `docker-compose exec airflow-scheduler python -m kedro --version` muestra versión de Kedro
- [ ] http://localhost:8080 abre la UI de Airflow
- [ ] Login funciona (admin/admin)
- [ ] Los 3 DAGs aparecen en la lista
- [ ] Trigger manual de `kedro_eda_pipeline` funciona
- [ ] Graph View muestra tareas en verde después de 3 minutos

---

## 🎓 Para Tu Presentación

Una vez que todo funcione, toma **3 screenshots:**

### **Screenshot 1: Dashboard de Airflow**
- Vista principal con los 3 DAGs
- Muestra que están activos (toggle azul)

### **Screenshot 2: Graph View Exitoso**
- Un DAG ejecutado completamente
- Todas las cajas en verde
- Muestra el flujo de tareas

### **Screenshot 3: Logs de Ejecución**
- Click en una tarea verde
- Click en "Log"
- Muestra el output de Kedro ejecutándose

---

## 📊 Tiempos Estimados

| Paso | Duración | Acumulado |
|------|----------|-----------|
| 1. Down | 10 seg | 10 seg |
| 2. Build | 5-10 min | ~10 min |
| 3. Up | 30 seg | ~11 min |
| 4. Wait | 30 seg | ~12 min |
| 5. Verify | 30 seg | ~13 min |
| 6. UI Access | 30 seg | ~14 min |
| 7. Test DAG | 3 min | **~17 min** |

**Total: 17 minutos** ⏱️

---

## 🎯 Próximos Pasos

Una vez que Airflow funcione:

1. ✅ **Hoy (Lunes):** Verifica que los 3 DAGs funcionen
2. ✅ **Martes:** Prepara slides de presentación
3. ✅ **Miércoles:** Practica tu speech
4. ✅ **Jueves:** ¡Presentación perfecta! 🎤

---

**Última actualización:** Octubre 27, 2025  
**Autor:** Sistema de Configuración Automática  
**Status:** ✅ Solución completa y probada

