# ⚡ Instrucciones Rápidas - Git

## 🎯 ¿Qué hacer AHORA mismo?

---

## 📋 Opción 1: Subir Todo por Primera Vez (RECOMENDADO)

### **Pasos:**

```powershell
# 1. Abrir PowerShell en la carpeta del proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig

# 2. Ejecutar script de subida
.\SUBIR_A_GIT.ps1

# 3. Hacer commit
git commit -m "Proyecto ML completo - League of Legends Worlds"

# 4. Subir a GitHub
git push origin main
```

**Tiempo:** 2-3 minutos  
**Resultado:** Todo el código esencial en GitHub ✅

---

## 🧹 Opción 2: Ya Subiste Archivos Innecesarios (Limpiar)

### **Pasos:**

```powershell
# 1. Abrir PowerShell en la carpeta del proyecto
cd C:\Users\pedri\OneDrive\Desktop\Proyecto_machine_learnig

# 2. Limpiar archivos innecesarios
.\LIMPIAR_GIT.ps1

# 3. Hacer commit de la limpieza
git commit -m "Limpieza: Removidos archivos innecesarios"

# 4. Subir cambios
git push origin main
```

**Tiempo:** 1-2 minutos  
**Resultado:** Repositorio limpio y optimizado ✅

---

## 📊 ¿Cómo saber si está bien?

### **Verificar tamaño:**
```powershell
cd league-project
git count-objects -vH
```

**✅ Bueno:** 5-15 MB  
**⚠️ Malo:** 50+ MB  
**❌ Muy malo:** 500+ MB

---

### **Verificar cantidad de archivos:**
```powershell
git ls-files | Measure-Object
```

**✅ Bueno:** 80-120 archivos  
**⚠️ Malo:** 200+ archivos  
**❌ Muy malo:** 500+ archivos

---

## 🎯 Archivos que DEBEN estar (resumen corto)

✅ **Código:** `src/`, `tests/`  
✅ **Config:** `conf/`, `pyproject.toml`, `requirements.txt`  
✅ **Datos raw:** `data/01_raw/*.csv`  
✅ **Docker:** `Dockerfile`, `docker-compose.yml`  
✅ **Airflow:** `airflow/dags/*.py`  
✅ **Docs:** `README.md`, guías principales  

---

## ❌ Archivos que NO deben estar (resumen corto)

❌ `venv/` - Entorno virtual (500+ MB)  
❌ `__pycache__/` - Caché de Python  
❌ `logs/`, `*.log` - Logs temporales  
❌ `data/02_*` hasta `data/08_*` - Datos generados  
❌ Documentos redundantes (15+ archivos .md)  

---

## 🚀 Comandos Útiles

```powershell
# Ver estado
git status

# Ver qué se subirá
git status --short

# Ver archivos en Git
git ls-files

# Ver tamaño
git count-objects -vH

# Ver cambios
git diff
```

---

## 📞 ¿Necesitas ayuda?

1. **Ver documentación completa:**
   - `GUIA_GIT.md` - Guía completa de Git
   - `RESUMEN_ARCHIVOS.md` - Explicación detallada de cada archivo

2. **Scripts disponibles:**
   - `SUBIR_A_GIT.ps1` - Subir archivos cruciales
   - `LIMPIAR_GIT.ps1` - Limpiar archivos innecesarios

3. **Verificar estado:**
   ```powershell
   git status
   ```

---

## ✅ Checklist Rápido

Antes de hacer `git push`:

- [ ] Ejecuté `.\SUBIR_A_GIT.ps1`
- [ ] El tamaño es < 15 MB
- [ ] NO veo `venv/` en `git status`
- [ ] NO veo archivos `.log` en `git status`
- [ ] Hice commit: `git commit -m "mensaje"`
- [ ] Listo para push: `git push origin main`

---

## 🎉 ¡Listo!

Una vez que hagas push, cualquiera puede clonar tu proyecto y ejecutarlo:

```powershell
git clone https://github.com/glYohanny/Evaluacion_machine_learning.git
cd Evaluacion_machine_learning/league-project
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
kedro run
```

**¡Y funciona!** 🚀

---

**Autor:** Pedro Torres  
**Fecha:** Octubre 29, 2025

