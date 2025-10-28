# ✅ Checklist de Deployment - League of Legends ML

## 📋 Lista de Verificación Pre-Deployment

### 🔧 Configuración Inicial

- [ ] **Docker Desktop instalado**
  ```powershell
  docker --version  # Debería mostrar versión 20.10+
  ```

- [ ] **Docker Compose instalado**
  ```powershell
  docker-compose --version  # Debería mostrar versión 2.0+
  ```

- [ ] **WSL 2 habilitado** (Windows)
  - Docker Desktop > Settings > General > "Use WSL 2 based engine"

- [ ] **Recursos suficientes asignados**
  - RAM: Mínimo 8 GB
  - CPU: 4 cores
  - Disco: 20 GB libres

---

### 📂 Estructura de Archivos

- [ ] **Archivos de Docker presentes**
  ```
  ✓ Dockerfile
  ✓ docker-compose.yml
  ✓ .dockerignore
  ```

- [ ] **Scripts de PowerShell presentes**
  ```
  ✓ setup_airflow_windows.ps1
  ✓ run_kedro_pipeline.ps1
  ```

- [ ] **Directorios de Airflow creados**
  ```
  ✓ airflow/dags/
  ✓ airflow/logs/
  ✓ airflow/plugins/
  ✓ airflow/config/
  ```

- [ ] **DAGs presentes en airflow/dags/**
  ```
  ✓ kedro_league_ml_dag.py
  ✓ kedro_eda_only_dag.py
  ✓ kedro_training_only_dag.py
  ```

- [ ] **Datos raw presentes en data/01_raw/**
  ```
  ✓ LeagueofLegends.csv
  ✓ matchinfo.csv
  ✓ bans.csv
  ✓ gold.csv
  ✓ kills.csv
  ✓ monsters.csv
  ✓ structures.csv
  ```

---

### 🚀 Proceso de Setup

- [ ] **1. Ejecutar script de setup**
  ```powershell
  .\setup_airflow_windows.ps1
  ```
  **Resultado esperado**: 
  - ✅ Imagen de Kedro construida
  - ✅ Airflow inicializado
  - ✅ Usuario admin creado

- [ ] **2. Verificar imagen de Docker**
  ```powershell
  docker images | Select-String "league-kedro"
  ```
  **Resultado esperado**: Ver `league-kedro-ml:latest`

- [ ] **3. Iniciar servicios**
  ```powershell
  docker-compose up -d
  ```

- [ ] **4. Verificar contenedores corriendo**
  ```powershell
  docker-compose ps
  ```
  **Resultado esperado**: 5 servicios "Up"
  - ✅ postgres
  - ✅ airflow-webserver
  - ✅ airflow-scheduler
  - ✅ airflow-init (completed)
  - ✅ kedro-app (exited 0)

---

### 🌐 Verificación de Airflow

- [ ] **5. Acceder a Airflow UI**
  - URL: http://localhost:8080
  - **Resultado esperado**: Login page visible

- [ ] **6. Login exitoso**
  - Usuario: `admin`
  - Password: `admin`
  - **Resultado esperado**: Dashboard de Airflow

- [ ] **7. DAGs visibles**
  - Ver 3 DAGs en la lista principal
  - **Resultado esperado**:
    - ✅ kedro_league_ml_pipeline
    - ✅ kedro_eda_pipeline
    - ✅ kedro_model_training_pipeline

- [ ] **8. DAGs sin errores**
  - Ningún icono rojo de error en los DAGs
  - **Resultado esperado**: Todos los DAGs en estado válido

---

### 🧪 Pruebas Funcionales

- [ ] **9. Ejecutar pipeline de prueba**
  ```powershell
  .\run_kedro_pipeline.ps1 -Pipeline data_cleaning
  ```
  **Resultado esperado**: 
  - ✅ Exit code 0
  - ✅ Archivos en `data/02_intermediate/`

- [ ] **10. Verificar datos limpios generados**
  ```powershell
  ls data\02_intermediate\*.csv
  ```
  **Resultado esperado**: 7 archivos CSV

- [ ] **11. Ejecutar pipeline EDA**
  ```powershell
  .\run_kedro_pipeline.ps1 -Pipeline eda
  ```
  **Resultado esperado**:
  - ✅ Exit code 0
  - ✅ Archivos en `data/08_reporting/`

- [ ] **12. Verificar reportes generados**
  ```powershell
  ls data\08_reporting\
  ```
  **Resultado esperado**: Al menos 8 archivos

- [ ] **13. Trigger DAG desde Airflow UI**
  - Activar `kedro_eda_pipeline`
  - Click en "Trigger DAG"
  - **Resultado esperado**: DAG ejecuta exitosamente (verde)

---

### 📊 Verificación de Logs

- [ ] **14. Logs de Airflow accesibles**
  ```powershell
  docker-compose logs airflow-webserver | Select-Object -First 20
  ```
  **Resultado esperado**: Sin errores críticos

- [ ] **15. Logs de Kedro accesibles**
  ```powershell
  docker-compose logs kedro-app | Select-Object -First 20
  ```
  **Resultado esperado**: Ejecuciones exitosas

- [ ] **16. Logs de PostgreSQL sanos**
  ```powershell
  docker-compose logs postgres | Select-Object -Last 10
  ```
  **Resultado esperado**: Database system ready

---

### 🎯 Verificación de Pipelines Completos

- [ ] **17. Pipeline data_processing funcional**
  ```powershell
  docker-compose run --rm kedro-app kedro run --pipeline data_processing
  ```
  **Resultado esperado**: Features en `data/05_model_input/`

- [ ] **18. Pipeline data_science funcional**
  ```powershell
  docker-compose run --rm kedro-app kedro run --pipeline data_science
  ```
  **Resultado esperado**: 10 modelos entrenados

- [ ] **19. Pipeline evaluation funcional**
  ```powershell
  docker-compose run --rm kedro-app kedro run --pipeline evaluation
  ```
  **Resultado esperado**: Métricas en `data/08_reporting/`

- [ ] **20. Pipeline completo ejecutable**
  ```powershell
  .\run_kedro_pipeline.ps1
  ```
  **Resultado esperado**: Todos los pipelines ejecutan sin errores

---

### 📈 Verificación de Resultados

- [ ] **21. Modelos guardados**
  ```powershell
  ls data\06_models\*.pkl
  ```
  **Resultado esperado**: Archivos .pkl presentes

- [ ] **22. Métricas de regresión generadas**
  ```powershell
  cat data\08_reporting\regression_metrics.csv
  ```
  **Resultado esperado**: CSV con métricas de 5 modelos

- [ ] **23. Métricas de clasificación generadas**
  ```powershell
  cat data\08_reporting\classification_metrics.csv
  ```
  **Resultado esperado**: CSV con métricas de 5 modelos

- [ ] **24. Reportes JSON completos**
  ```powershell
  cat data\08_reporting\eda_complete_report.json
  ```
  **Resultado esperado**: JSON válido con insights

---

### 🔐 Seguridad y Configuración

- [ ] **25. Variables de entorno configuradas**
  - Verificar archivo `.env` existe
  - **Resultado esperado**: Todas las variables definidas

- [ ] **26. Puertos no en conflicto**
  ```powershell
  netstat -ano | findstr ":8080"
  netstat -ano | findstr ":5432"
  ```
  **Resultado esperado**: Solo contenedores Docker usando estos puertos

- [ ] **27. Permisos de archivos correctos**
  - Verificar que puedes leer/escribir en `data/`, `logs/`, `airflow/`
  - **Resultado esperado**: Sin errores de permisos

---

### 📚 Documentación

- [ ] **28. Documentación completa presente**
  ```
  ✓ QUICK_START.md
  ✓ DOCKER_AIRFLOW_GUIDE.md
  ✓ DEPLOYMENT_SUMMARY.md
  ✓ README_DOCKER_AIRFLOW.md
  ✓ CHECKLIST_DEPLOYMENT.md (este archivo)
  ```

- [ ] **29. Scripts tienen permisos de ejecución**
  ```powershell
  Get-ExecutionPolicy
  ```
  **Resultado esperado**: RemoteSigned o Unrestricted

---

### 🧹 Limpieza y Mantenimiento

- [ ] **30. Comando de limpieza funciona**
  ```powershell
  docker-compose down
  ```
  **Resultado esperado**: Todos los contenedores detenidos

- [ ] **31. Reinicio completo funciona**
  ```powershell
  docker-compose down
  docker-compose up -d
  ```
  **Resultado esperado**: Sistema levanta correctamente

---

## 🎉 Criterios de Éxito

### ✅ Sistema Listo si:

1. ✅ Todos los contenedores están "Up"
2. ✅ Airflow UI accesible en http://localhost:8080
3. ✅ 3 DAGs visibles sin errores
4. ✅ Pipeline EDA ejecuta exitosamente
5. ✅ Datos limpios generados en `data/02_intermediate/`
6. ✅ Reportes generados en `data/08_reporting/`
7. ✅ Logs accesibles sin errores críticos
8. ✅ Documentación completa disponible

---

## ❌ Troubleshooting

### Si algún check falla:

1. **Revisar logs**:
   ```powershell
   docker-compose logs [nombre-servicio]
   ```

2. **Reiniciar servicio problemático**:
   ```powershell
   docker-compose restart [nombre-servicio]
   ```

3. **Limpieza completa y reinicio**:
   ```powershell
   docker-compose down -v
   .\setup_airflow_windows.ps1
   docker-compose up -d
   ```

4. **Consultar documentación**:
   - Ver `DOCKER_AIRFLOW_GUIDE.md` sección "Solución de Problemas"

---

## 📞 Soporte

Si después de revisar este checklist sigues teniendo problemas:

1. Verificar que Docker Desktop está corriendo
2. Reiniciar Docker Desktop
3. Verificar que WSL 2 está habilitado
4. Revisar recursos asignados a Docker (RAM, CPU)
5. Consultar logs detallados

---

## 🏆 Certificación de Deployment

Una vez completados todos los checks:

```
✅ SISTEMA CERTIFICADO PARA PRODUCCIÓN

Fecha: _______________
Verificado por: _______________
Ambiente: Windows + Docker + Airflow + Kedro
Status: PRODUCTION READY 🚀
```

---

**Versión del Checklist**: 1.0.0  
**Última actualización**: Octubre 2025


