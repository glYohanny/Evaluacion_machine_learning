# 🔄 Guía de Pipelines de Limpieza y Análisis

## 📋 Descripción

Esta guía explica cómo usar los pipelines de **limpieza** y **análisis exploratorio** para procesar los datos raw de League of Legends.

## 🎯 Pipelines Disponibles

### 1. **data_cleaning** (Limpieza de Datos)
Limpia y prepara los datos raw para análisis.

### 2. **data_exploration** (Análisis Exploratorio)
Genera estadísticas, análisis y reportes de insights.

### 3. **eda** (Pipeline Combinado)
Ejecuta limpieza + exploración en secuencia.

---

## 🚀 Comandos de Ejecución

### Ejecutar Pipeline de Limpieza

```bash
# Cambiar al directorio del proyecto
cd league-project

# Activar entorno virtual
.\venv\Scripts\activate  # Windows
# source venv/bin/activate  # macOS/Linux

# Ejecutar limpieza de datos
kedro run --pipeline data_cleaning

# O usar alias corto
kedro run --pipeline dc
```

### Ejecutar Pipeline de Exploración

```bash
# Ejecutar exploración de datos
kedro run --pipeline data_exploration

# O usar alias corto
kedro run --pipeline de
```

### Ejecutar Ambos Pipelines

```bash
# Ejecutar limpieza + exploración
kedro run --pipeline eda
```

### Ejecutar Todo el Proyecto

```bash
# Ejecutar pipeline completo (limpieza + exploración + procesamiento + modelos + evaluación)
kedro run
```

---

## 📊 Pipeline de Limpieza (data_cleaning)

### ¿Qué hace?

1. **Limpia LeagueofLegends.csv** (dataset principal)
   - Elimina duplicados
   - Imputa valores faltantes
   - Convierte tipos de datos
   - Elimina outliers extremos
   - Crea features básicas (KDA)

2. **Limpia matchinfo.csv**
   - Estandariza nombres de columnas
   - Convierte fechas a datetime
   - Extrae features temporales

3. **Limpia bans.csv**
   - Limpia nombres de campeones
   - Valida orden de bans
   - Elimina registros inválidos

4. **Limpia gold.csv**
   - Valida valores positivos
   - Calcula diferencias de oro

5. **Limpia kills.csv**
   - Valida tiempos
   - Limpia nombres de jugadores

6. **Limpia monsters.csv**
   - Estandariza tipos de objetivos
   - Valida tiempos

7. **Limpia structures.csv**
   - Estandariza tipos de estructuras
   - Valida lanes

8. **Genera Reporte de Calidad**
   - Métricas de calidad por dataset
   - Estadísticas de limpieza

### Outputs

Todos los datos limpios se guardan en `data/02_intermediate/`:

- `main_clean.csv` - Dataset principal limpio
- `matchinfo_clean.csv` - Información de partidos limpia
- `bans_clean.csv` - Bans limpios
- `gold_clean.csv` - Estadísticas de oro limpias
- `kills_clean.csv` - Kills limpios
- `monsters_clean.csv` - Objetivos limpios
- `structures_clean.csv` - Estructuras limpias

Reporte de calidad en `data/08_reporting/`:

- `data_quality_report_cleaning.csv` - Reporte de calidad

### Ejemplo de Ejecución

```bash
(venv) C:\...\league-project> kedro run --pipeline data_cleaning

[10/27/25 12:00:00] INFO     Kedro project league_project
[10/27/25 12:00:01] INFO     Loading data from 'raw_main_data' (CSVDataset)...
[10/27/25 12:00:02] INFO     Running node: clean_main_dataset_node
[10/27/25 12:00:02] INFO     Iniciando limpieza del dataset principal: 10000 filas
[10/27/25 12:00:03] INFO     Eliminados 150 duplicados completos
[10/27/25 12:00:03] INFO     Valores faltantes: 500 → 0
[10/27/25 12:00:04] INFO     Limpieza completada: 9850 filas finales
[10/27/25 12:00:04] INFO     Saving data to 'intermediate_main_data' (CSVDataset)...
...
[10/27/25 12:00:30] INFO     Pipeline execution completed successfully.
```

---

## 📈 Pipeline de Exploración (data_exploration)

### ¿Qué hace?

1. **Estadísticas Descriptivas**
   - Media, mediana, desviación estándar
   - Asimetría, curtosis
   - Valores faltantes

2. **Análisis de Rendimiento de Equipos**
   - Win rate por equipo
   - Estadísticas promedio (kills, deaths, assists, gold)
   - KDA promedio

3. **Análisis de Bans de Campeones**
   - Campeones más baneados
   - Frecuencia y porcentaje de bans
   - Orden promedio de ban

4. **Análisis de Objetivos Neutrales**
   - Dragones, Baron, Herald capturados
   - Tiempo promedio de captura
   - Captura por equipo

5. **Análisis de Estructuras**
   - Torres e inhibidores destruidos
   - Tiempo promedio de destrucción
   - Destrucción por lane

6. **Análisis de Correlaciones**
   - Correlaciones entre variables numéricas
   - Clasificación por fuerza (fuerte, moderada, débil)

7. **Análisis de Duración de Partidos**
   - Estadísticas de duración
   - Categorización (corta, media, larga, muy larga)
   - Distribución de duraciones

8. **Reporte Completo de EDA**
   - Resumen de todos los análisis
   - Insights clave

### Outputs

Todos los análisis se guardan en `data/08_reporting/`:

- `descriptive_statistics.csv` - Estadísticas descriptivas
- `team_performance_analysis.csv` - Rendimiento de equipos
- `champion_bans_analysis.csv` - Análisis de bans
- `neutral_objectives_analysis.csv` - Análisis de objetivos
- `structures_analysis.csv` - Análisis de estructuras
- `correlations_analysis.csv` - Análisis de correlaciones
- `game_duration_analysis.csv` - Análisis de duración
- `eda_complete_report.json` - Reporte completo

### Ejemplo de Ejecución

```bash
(venv) C:\...\league-project> kedro run --pipeline data_exploration

[10/27/25 12:05:00] INFO     Kedro project league_project
[10/27/25 12:05:01] INFO     Loading data from 'intermediate_main_data' (CSVDataset)...
[10/27/25 12:05:02] INFO     Running node: generate_descriptive_stats_node
[10/27/25 12:05:02] INFO     Generando estadísticas descriptivas
[10/27/25 12:05:03] INFO     Estadísticas generadas para 25 columnas
[10/27/25 12:05:03] INFO     Saving data to 'descriptive_statistics' (CSVDataset)...
...
[10/27/25 12:05:30] INFO     Analizando rendimiento de equipos
[10/27/25 12:05:31] INFO     Análisis completado para 20 equipos
...
[10/27/25 12:06:00] INFO     Pipeline execution completed successfully.
```

---

## 📂 Estructura de Datos

### Antes de la Limpieza
```
data/01_raw/
├── LeagueofLegends.csv    ← Dataset principal (puede tener duplicados, NaN)
├── matchinfo.csv          ← Info de partidos (fechas sin formato)
├── bans.csv              ← Bans (nombres sin limpiar)
├── gold.csv              ← Estadísticas de oro
├── kills.csv             ← Información de kills
├── monsters.csv          ← Objetivos neutrales
└── structures.csv        ← Estructuras destruidas
```

### Después de la Limpieza
```
data/02_intermediate/
├── main_clean.csv        ← Dataset principal limpio
├── matchinfo_clean.csv   ← Info de partidos limpia
├── bans_clean.csv        ← Bans limpios
├── gold_clean.csv        ← Oro limpio
├── kills_clean.csv       ← Kills limpios
├── monsters_clean.csv    ← Objetivos limpios
└── structures_clean.csv  ← Estructuras limpias
```

### Después de la Exploración
```
data/08_reporting/
├── descriptive_statistics.csv
├── team_performance_analysis.csv
├── champion_bans_analysis.csv
├── neutral_objectives_analysis.csv
├── structures_analysis.csv
├── correlations_analysis.csv
├── game_duration_analysis.csv
├── eda_complete_report.json
└── data_quality_report_cleaning.csv
```

---

## 🔍 Ver Resultados de los Análisis

### En Python

```python
import pandas as pd

# Cargar estadísticas descriptivas
stats = pd.read_csv('data/08_reporting/descriptive_statistics.csv')
print(stats.head())

# Cargar análisis de equipos
teams = pd.read_csv('data/08_reporting/team_performance_analysis.csv')
print(teams.sort_values('win_rate', ascending=False).head(10))

# Cargar análisis de bans
bans = pd.read_csv('data/08_reporting/champion_bans_analysis.csv')
print(bans.head(20))

# Cargar reporte completo
import json
with open('data/08_reporting/eda_complete_report.json', 'r') as f:
    report = json.load(f)
print(report)
```

### En Notebook

```python
# notebooks/analizar_resultados.py
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Configuración
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

# Cargar datos limpios
df_main = pd.read_csv('data/02_intermediate/main_clean.csv')
print(f"Datos limpios: {len(df_main)} filas")

# Cargar análisis
teams = pd.read_csv('data/08_reporting/team_performance_analysis.csv')
bans = pd.read_csv('data/08_reporting/champion_bans_analysis.csv')

# Visualizar top 10 equipos
plt.figure(figsize=(12, 6))
top_teams = teams.nlargest(10, 'win_rate')
plt.barh(top_teams['team'], top_teams['win_rate'])
plt.title('Top 10 Equipos por Win Rate')
plt.xlabel('Win Rate')
plt.tight_layout()
plt.savefig('top_teams.png')
plt.show()

# Visualizar top 20 bans
plt.figure(figsize=(12, 8))
top_bans = bans.head(20)
plt.barh(range(len(top_bans)), top_bans['ban_count'])
plt.yticks(range(len(top_bans)), top_bans['champion'])
plt.title('Top 20 Campeones Más Baneados')
plt.xlabel('Número de Bans')
plt.gca().invert_yaxis()
plt.tight_layout()
plt.savefig('top_bans.png')
plt.show()
```

---

## 🛠️ Comandos Avanzados

### Ejecutar Solo un Nodo Específico

```bash
# Ejecutar solo la limpieza del dataset principal
kedro run --node clean_main_dataset_node

# Ejecutar solo el análisis de equipos
kedro run --node analyze_team_performance_node
```

### Ejecutar con Tags

```bash
# Ejecutar solo nodos de limpieza
kedro run --tag cleaning

# Ejecutar solo nodos de EDA
kedro run --tag eda

# Ejecutar solo nodos de reporting
kedro run --tag reporting
```

### Ejecutar desde un Nodo Específico

```bash
# Ejecutar desde el análisis de bans en adelante
kedro run --from-nodes analyze_champion_bans_node

# Ejecutar hasta el análisis de correlaciones
kedro run --to-nodes analyze_correlations_node
```

### Ejecutar con Logging Detallado

```bash
# Ejecutar con logging verbose
kedro run --pipeline data_cleaning --verbose

# Ver logs en tiempo real
Get-Content info.log -Wait  # Windows PowerShell
# tail -f info.log  # macOS/Linux
```

---

## 📊 Verificar que Todo Funciona

### Script de Verificación

```python
# verificar_pipelines.py
import os
import pandas as pd

def verificar_archivos():
    """Verifica que todos los archivos fueron generados."""
    
    archivos_esperados = [
        # Datos limpios
        'data/02_intermediate/main_clean.csv',
        'data/02_intermediate/matchinfo_clean.csv',
        'data/02_intermediate/bans_clean.csv',
        'data/02_intermediate/gold_clean.csv',
        'data/02_intermediate/kills_clean.csv',
        'data/02_intermediate/monsters_clean.csv',
        'data/02_intermediate/structures_clean.csv',
        
        # Reportes
        'data/08_reporting/data_quality_report_cleaning.csv',
        'data/08_reporting/descriptive_statistics.csv',
        'data/08_reporting/team_performance_analysis.csv',
        'data/08_reporting/champion_bans_analysis.csv',
        'data/08_reporting/neutral_objectives_analysis.csv',
        'data/08_reporting/structures_analysis.csv',
        'data/08_reporting/correlations_analysis.csv',
        'data/08_reporting/game_duration_analysis.csv',
        'data/08_reporting/eda_complete_report.json',
    ]
    
    print("="*60)
    print("VERIFICACIÓN DE ARCHIVOS GENERADOS")
    print("="*60)
    
    todos_existen = True
    
    for archivo in archivos_esperados:
        existe = os.path.exists(archivo)
        estado = "✅" if existe else "❌"
        print(f"{estado} {archivo}")
        
        if existe and archivo.endswith('.csv'):
            try:
                df = pd.read_csv(archivo)
                print(f"   📊 {len(df)} filas, {len(df.columns)} columnas")
            except Exception as e:
                print(f"   ⚠️  Error al leer: {str(e)}")
        
        todos_existen = todos_existen and existe
    
    print("="*60)
    if todos_existen:
        print("✅ TODOS LOS ARCHIVOS FUERON GENERADOS CORRECTAMENTE")
    else:
        print("❌ FALTAN ALGUNOS ARCHIVOS")
    print("="*60)
    
    return todos_existen

if __name__ == "__main__":
    verificar_archivos()
```

Ejecutar:
```bash
python verificar_pipelines.py
```

---

## 🐛 Solución de Problemas

### Error: "Dataset not found"

```
DatasetError: Failed while loading data from data set raw_main_data
```

**Solución:**
- Verificar que el archivo existe: `data/01_raw/LeagueofLegends.csv`
- Verificar configuración en `conf/base/catalog.yml`

### Error: "No module named 'league_project.pipelines.data_cleaning'"

**Solución:**
```bash
# Reinstalar el proyecto
pip install -e .
```

### Error: "UnicodeDecodeError"

**Solución:**
- Los nodos de limpieza ya manejan múltiples encodings automáticamente
- Si persiste, verificar el encoding del archivo CSV

### Pipeline muy lento

**Solución:**
```bash
# Ejecutar pipelines en paralelo (si son independientes)
kedro run --pipeline data_cleaning --parallel

# Reducir tamaño de datos para prueba
# Editar el nodo para usar .head(1000) temporalmente
```

---

## 📝 Próximos Pasos

Después de ejecutar la limpieza y exploración:

1. **Revisar los reportes generados**
   - Ver `data/08_reporting/`
   - Identificar insights clave

2. **Ejecutar Feature Engineering**
   ```bash
   kedro run --pipeline data_processing
   ```

3. **Entrenar Modelos**
   ```bash
   kedro run --pipeline data_science
   ```

4. **Evaluar Resultados**
   ```bash
   kedro run --pipeline evaluation
   ```

---

## 🎯 Resumen de Comandos

```bash
# Limpieza de datos
kedro run --pipeline data_cleaning

# Exploración de datos
kedro run --pipeline data_exploration

# Limpieza + Exploración
kedro run --pipeline eda

# Todo el proyecto
kedro run

# Ver logs
Get-Content info.log -Wait

# Listar pipelines disponibles
kedro pipeline list

# Ver información del proyecto
kedro info
```

---

**🎮 ¡Listos para analizar datos de League of Legends!** Los pipelines están configurados y listos para ejecutarse.

