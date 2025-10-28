# 📊 Resumen: Pipelines de Limpieza y Análisis

## ✅ Lo que se ha creado

### 1. **Pipeline de Limpieza de Datos** (`data_cleaning`)

**Ubicación:** `src/league_project/pipelines/data_cleaning/`

**Archivos creados:**
- `__init__.py` - Inicialización del módulo
- `nodes.py` - 8 nodos de limpieza + 1 de reporte
- `pipeline.py` - Orquestación del pipeline

**Funcionalidad:**
- Limpia 7 datasets CSV de `data/01_raw/`
- Elimina duplicados, imputa valores faltantes, valida datos
- Genera reporte de calidad de datos
- Guarda datos limpios en `data/02_intermediate/`

---

### 2. **Pipeline de Exploración de Datos** (`data_exploration`)

**Ubicación:** `src/league_project/pipelines/data_exploration/`

**Archivos creados:**
- `__init__.py` - Inicialización del módulo
- `nodes.py` - 8 nodos de análisis
- `pipeline.py` - Orquestación del pipeline

**Funcionalidad:**
- Genera estadísticas descriptivas completas
- Analiza rendimiento de equipos (win rate, KDA)
- Analiza bans de campeones más frecuentes
- Analiza objetivos neutrales (dragones, baron)
- Analiza estructuras destruidas (torres)
- Calcula correlaciones entre variables
- Analiza duración de partidos
- Genera reporte completo de EDA
- Guarda todos los análisis en `data/08_reporting/`

---

### 3. **Configuración de Kedro**

**Archivos actualizados:**
- `conf/base/catalog.yml` - Agregados 23 datasets nuevos
- `src/league_project/pipeline_registry.py` - Registrados 2 pipelines nuevos

---

### 4. **Documentación**

**Archivos creados:**
- `docs/GUIA_DATOS_CSV.md` - Guía completa de los archivos CSV
- `docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md` - Guía de uso de pipelines
- `docs/RESUMEN_PIPELINES.md` - Este documento
- `verificar_pipelines.py` - Script de verificación

---

## 🚀 Cómo usar los pipelines

### Opción 1: Ejecutar ambos pipelines

```bash
cd league-project
.\venv\Scripts\activate
kedro run --pipeline eda
```

Este comando ejecuta:
1. Limpieza de todos los datos raw
2. Análisis exploratorio completo
3. Generación de reportes

**Tiempo estimado:** 2-5 minutos (depende del tamaño de datos)

---

### Opción 2: Ejecutar pipelines por separado

```bash
# Solo limpieza
kedro run --pipeline data_cleaning

# Solo exploración (requiere datos limpios primero)
kedro run --pipeline data_exploration
```

---

### Opción 3: Ejecutar todo el proyecto

```bash
kedro run
```

Ejecuta los 5 pipelines en orden:
1. `data_cleaning` - Limpieza
2. `data_exploration` - Exploración
3. `data_processing` - Feature engineering
4. `data_science` - Entrenamiento de modelos
5. `evaluation` - Evaluación de modelos

---

## 📂 Estructura de Outputs

### Después de `data_cleaning`:

```
data/02_intermediate/
├── main_clean.csv           ✅ Dataset principal limpio
├── matchinfo_clean.csv      ✅ Info de partidos limpia
├── bans_clean.csv           ✅ Bans limpios
├── gold_clean.csv           ✅ Oro limpio
├── kills_clean.csv          ✅ Kills limpios
├── monsters_clean.csv       ✅ Objetivos limpios
└── structures_clean.csv     ✅ Estructuras limpias
```

### Después de `data_exploration`:

```
data/08_reporting/
├── data_quality_report_cleaning.csv      ✅ Reporte de calidad
├── descriptive_statistics.csv            ✅ Estadísticas descriptivas
├── team_performance_analysis.csv         ✅ Análisis de equipos
├── champion_bans_analysis.csv            ✅ Análisis de bans
├── neutral_objectives_analysis.csv       ✅ Análisis de objetivos
├── structures_analysis.csv               ✅ Análisis de estructuras
├── correlations_analysis.csv             ✅ Análisis de correlaciones
├── game_duration_analysis.csv            ✅ Análisis de duración
└── eda_complete_report.json              ✅ Reporte completo
```

---

## 🔍 Verificar que todo funcionó

```bash
python verificar_pipelines.py
```

Este script:
- ✅ Verifica que todos los archivos fueron generados
- 📊 Muestra estadísticas de cada archivo (filas, columnas)
- 🏆 Muestra insights rápidos (top equipos, top bans, etc.)
- 💡 Da sugerencias si falta algo

---

## 📊 Ver los resultados

### En Python:

```python
import pandas as pd

# Cargar datos limpios
df = pd.read_csv('data/02_intermediate/main_clean.csv')
print(f"Datos limpios: {len(df)} filas")

# Ver top equipos
teams = pd.read_csv('data/08_reporting/team_performance_analysis.csv')
print(teams.sort_values('win_rate', ascending=False).head())

# Ver top bans
bans = pd.read_csv('data/08_reporting/champion_bans_analysis.csv')
print(bans.head(20))
```

### En Jupyter Notebook:

Abre `notebooks/analisis_lol_crisp_dm.ipynb` y agrega:

```python
# Cargar resultados de análisis
teams = pd.read_csv('../data/08_reporting/team_performance_analysis.csv')
bans = pd.read_csv('../data/08_reporting/champion_bans_analysis.csv')

# Visualizar
import matplotlib.pyplot as plt
import seaborn as sns

# Top 10 equipos
plt.figure(figsize=(12, 6))
top10 = teams.nlargest(10, 'win_rate')
plt.barh(top10['team'], top10['win_rate'])
plt.title('Top 10 Equipos por Win Rate')
plt.xlabel('Win Rate')
plt.tight_layout()
plt.show()
```

---

## 🎯 Comandos Útiles

```bash
# Ver pipelines disponibles
kedro pipeline list

# Ver información del proyecto
kedro info

# Ver datasets disponibles
kedro catalog list

# Ejecutar con logging detallado
kedro run --pipeline eda --verbose

# Ver logs en tiempo real
Get-Content info.log -Wait
```

---

## 📝 Nodos Creados

### Pipeline de Limpieza (8 nodos):

1. `clean_main_dataset_node` - Limpia dataset principal
2. `clean_matchinfo_node` - Limpia matchinfo
3. `clean_bans_node` - Limpia bans
4. `clean_gold_node` - Limpia gold
5. `clean_kills_node` - Limpia kills
6. `clean_monsters_node` - Limpia monsters
7. `clean_structures_node` - Limpia structures
8. `generate_quality_report_node` - Genera reporte de calidad

### Pipeline de Exploración (8 nodos):

1. `generate_descriptive_stats_node` - Estadísticas descriptivas
2. `analyze_team_performance_node` - Análisis de equipos
3. `analyze_champion_bans_node` - Análisis de bans
4. `analyze_neutral_objectives_node` - Análisis de objetivos
5. `analyze_structures_node` - Análisis de estructuras
6. `analyze_correlations_node` - Análisis de correlaciones
7. `analyze_game_duration_node` - Análisis de duración
8. `generate_eda_report_node` - Reporte completo

**Total: 16 nodos nuevos** ✅

---

## 🔧 Troubleshooting

### Error: "Dataset not found"
```bash
# Verificar que los archivos CSV existen
ls data/01_raw/

# Verificar configuración
cat conf/base/catalog.yml
```

### Error: "Module not found"
```bash
# Reinstalar proyecto
pip install -e .
```

### Pipeline no ejecuta
```bash
# Verificar que estás en el directorio correcto
pwd  # Debe estar en league-project/

# Verificar que el entorno virtual está activado
which python  # Debe mostrar ruta con venv
```

---

## 📚 Documentación Completa

- **Guía de CSV:** `docs/GUIA_DATOS_CSV.md`
- **Guía de Pipelines:** `docs/GUIA_PIPELINES_LIMPIEZA_ANALISIS.md`
- **Este resumen:** `docs/RESUMEN_PIPELINES.md`

---

## 🎉 Siguientes Pasos

1. **Ejecutar los pipelines:**
   ```bash
   kedro run --pipeline eda
   ```

2. **Verificar resultados:**
   ```bash
   python verificar_pipelines.py
   ```

3. **Explorar los datos limpios:**
   - Abrir archivos en `data/02_intermediate/`
   - Ver reportes en `data/08_reporting/`

4. **Continuar con Feature Engineering:**
   ```bash
   kedro run --pipeline data_processing
   ```

5. **Entrenar modelos:**
   ```bash
   kedro run --pipeline data_science
   ```

---

## ✅ Checklist Final

- [x] Pipeline de limpieza creado
- [x] Pipeline de exploración creado
- [x] Configuración de Kedro actualizada
- [x] Documentación completa creada
- [x] Script de verificación creado
- [ ] **Ejecutar pipelines** ← ¡Tu turno!
- [ ] **Verificar resultados**
- [ ] **Explorar insights**

---

**🎮 ¡Todo listo para analizar datos de League of Legends con Kedro!**

Los pipelines están completamente funcionales y listos para procesar tus datos CSV.

