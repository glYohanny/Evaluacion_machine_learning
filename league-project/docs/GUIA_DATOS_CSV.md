# 📊 Guía de Archivos CSV - League of Legends Project

## 📋 Tabla de Contenidos

- [Descripción de Archivos CSV](#descripción-de-archivos-csv)
- [Cómo Cargar los Datos](#cómo-cargar-los-datos)
- [Estructura de Cada Dataset](#estructura-de-cada-dataset)
- [Ejemplos de Uso](#ejemplos-de-uso)
- [Relaciones entre Datasets](#relaciones-entre-datasets)

---

## 📁 Descripción de Archivos CSV

### Ubicación
Todos los archivos CSV están en: `data/01_raw/`

### Lista de Archivos

| Archivo | Descripción | Uso Principal |
|---------|-------------|---------------|
| `LeagueofLegends.csv` | Dataset principal con información completa de partidos | Análisis general de partidos |
| `matchinfo.csv` | Información básica de cada partida | IDs y metadatos de partidos |
| `bans.csv` | Campeones baneados por partida | Análisis de meta y estrategia |
| `gold.csv` | Estadísticas de oro por equipo/tiempo | Análisis económico y ventajas |
| `kills.csv` | Información detallada de kills | Análisis de combates y kills |
| `monsters.csv` | Objetivos neutrales (dragones, baron, etc.) | Control de objetivos |
| `structures.csv` | Torres y estructuras destruidas | Progresión del juego |
| `_columns.csv` | Descripción de columnas | Referencia de metadatos |

---

## 🔧 Cómo Cargar los Datos

### Método 1: Carga Simple con Pandas

```python
import pandas as pd

# Cargar archivo principal
df_main = pd.read_csv('data/01_raw/LeagueofLegends.csv')

# Cargar información de partidos
df_matchinfo = pd.read_csv('data/01_raw/matchinfo.csv')

# Cargar bans
df_bans = pd.read_csv('data/01_raw/bans.csv')

# Cargar estadísticas de oro
df_gold = pd.read_csv('data/01_raw/gold.csv')

# Cargar información de kills
df_kills = pd.read_csv('data/01_raw/kills.csv')

# Cargar objetivos neutrales
df_monsters = pd.read_csv('data/01_raw/monsters.csv')

# Cargar estructuras
df_structures = pd.read_csv('data/01_raw/structures.csv')

# Cargar descripción de columnas
df_columns = pd.read_csv('data/01_raw/_columns.csv')
```

### Método 2: Carga con Manejo de Encoding

```python
def cargar_csv_seguro(ruta_archivo):
    """
    Carga CSV con manejo automático de encoding
    """
    encodings = ['utf-8', 'latin-1', 'cp1252', 'iso-8859-1']
    
    for encoding in encodings:
        try:
            df = pd.read_csv(ruta_archivo, encoding=encoding)
            print(f"✅ {ruta_archivo} cargado con encoding: {encoding}")
            return df
        except UnicodeDecodeError:
            continue
    
    print(f"❌ No se pudo cargar {ruta_archivo}")
    return None

# Usar la función
df_main = cargar_csv_seguro('data/01_raw/LeagueofLegends.csv')
```

### Método 3: Cargar Todos los CSV de una Vez

```python
import os
import pandas as pd

def cargar_todos_los_csv():
    """
    Carga todos los archivos CSV del proyecto
    """
    ruta_datos = 'data/01_raw/'
    datasets = {}
    
    archivos_csv = [
        'LeagueofLegends.csv',
        'matchinfo.csv',
        'bans.csv',
        'gold.csv',
        'kills.csv',
        'monsters.csv',
        'structures.csv',
        '_columns.csv'
    ]
    
    for archivo in archivos_csv:
        nombre = archivo.replace('.csv', '')
        ruta_completa = os.path.join(ruta_datos, archivo)
        
        try:
            datasets[nombre] = pd.read_csv(ruta_completa)
            print(f"✅ {archivo}: {len(datasets[nombre])} filas, {len(datasets[nombre].columns)} columnas")
        except Exception as e:
            print(f"❌ Error cargando {archivo}: {str(e)}")
    
    return datasets

# Usar la función
datos = cargar_todos_los_csv()

# Acceder a cada dataset
df_main = datos['LeagueofLegends']
df_matchinfo = datos['matchinfo']
df_bans = datos['bans']
```

---

## 📊 Estructura de Cada Dataset

### 1. LeagueofLegends.csv (Dataset Principal)

**Propósito:** Contiene información completa de partidos de League of Legends

**Columnas Principales:**
```python
# Ver columnas
print(df_main.columns.tolist())

# Información básica
print(df_main.info())

# Primeras filas
print(df_main.head())
```

**Columnas Típicas:**
- `gameid` - ID único de la partida
- `team` - Equipo (Blue/Red)
- `result` - Resultado (Win/Lose)
- `gamelength` - Duración del juego
- `kills` - Número de kills
- `deaths` - Número de muertes
- `assists` - Número de asistencias
- `gold` - Oro total
- `dragons` - Dragones obtenidos
- `barons` - Barones obtenidos

### 2. matchinfo.csv

**Propósito:** Información de metadatos de cada partida

```python
# Explorar estructura
print(df_matchinfo.head())
print(df_matchinfo.describe())

# Columnas comunes
# - gameid
# - league (Liga del torneo)
# - year (Año)
# - split (Temporada)
# - date (Fecha del partido)
# - game (Número de juego en la serie)
```

### 3. bans.csv

**Propósito:** Campeones baneados en cada partida

```python
# Ver bans
print(df_bans.head(10))

# Análisis de bans más comunes
bans_populares = df_bans['champion'].value_counts().head(20)
print("\n🚫 Top 20 Campeones Más Baneados:")
print(bans_populares)

# Columnas típicas:
# - gameid
# - team
# - champion (Campeón baneado)
# - ban (Orden del ban: 1-5)
```

### 4. gold.csv

**Propósito:** Estadísticas de oro por equipo a lo largo del tiempo

```python
# Ver evolución de oro
print(df_gold.head())

# Análisis de ventaja de oro
if 'goldblue' in df_gold.columns and 'goldred' in df_gold.columns:
    df_gold['gold_diff'] = df_gold['goldblue'] - df_gold['goldred']
    print("Diferencia promedio de oro:", df_gold['gold_diff'].mean())

# Columnas típicas:
# - gameid
# - time (Tiempo en el juego)
# - goldblue (Oro equipo azul)
# - goldred (Oro equipo rojo)
```

### 5. kills.csv

**Propósito:** Información detallada de cada kill en el juego

```python
# Ver información de kills
print(df_kills.head())

# Estadísticas de kills
print(f"Total de kills registrados: {len(df_kills)}")
print(f"Promedio de kills por partida: {len(df_kills) / df_kills['gameid'].nunique():.2f}")

# Columnas típicas:
# - gameid
# - time (Tiempo del kill)
# - killer (Quien hizo el kill)
# - victim (Quien murió)
# - assists (Asistentes en el kill)
```

### 6. monsters.csv

**Propósito:** Objetivos neutrales capturados (dragones, baron, herald)

```python
# Ver objetivos capturados
print(df_monsters.head())

# Análisis de dragones por tipo
if 'type' in df_monsters.columns:
    dragon_counts = df_monsters['type'].value_counts()
    print("\n🐉 Distribución de Objetivos:")
    print(dragon_counts)

# Columnas típicas:
# - gameid
# - time (Tiempo de captura)
# - type (Tipo: dragon, baron, herald)
# - team (Equipo que capturó)
```

### 7. structures.csv

**Propósito:** Torres e inhibidores destruidos

```python
# Ver estructuras destruidas
print(df_structures.head())

# Análisis de estructuras
if 'type' in df_structures.columns:
    structure_counts = df_structures['type'].value_counts()
    print("\n🏰 Estructuras Destruidas:")
    print(structure_counts)

# Columnas típicas:
# - gameid
# - time (Tiempo de destrucción)
# - type (Tipo: tower, inhibitor)
# - lane (Línea: top, mid, bot)
# - team (Equipo que destruyó)
```

### 8. _columns.csv

**Propósito:** Descripción y documentación de columnas

```python
# Ver descripción de columnas
print(df_columns)

# Usar como referencia
def obtener_descripcion_columna(columna):
    if columna in df_columns['column'].values:
        desc = df_columns[df_columns['column'] == columna]['description'].values[0]
        return desc
    return "Descripción no disponible"
```

---

## 💡 Ejemplos de Uso

### Ejemplo 1: Análisis Básico de Partidos

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Cargar datos principales
df = pd.read_csv('data/01_raw/LeagueofLegends.csv')

# Información general
print(f"📊 Total de registros: {len(df)}")
print(f"📊 Total de partidos únicos: {df['gameid'].nunique()}")
print(f"📊 Total de equipos: {df['team'].nunique()}")

# Estadísticas de resultado
if 'result' in df.columns:
    resultados = df['result'].value_counts()
    print("\n🎯 Distribución de Resultados:")
    print(resultados)
    
    # Visualizar
    plt.figure(figsize=(8, 6))
    resultados.plot(kind='bar', color=['green', 'red'])
    plt.title('Distribución de Victorias y Derrotas')
    plt.xlabel('Resultado')
    plt.ylabel('Cantidad')
    plt.xticks(rotation=0)
    plt.tight_layout()
    plt.savefig('resultados_distribucion.png')
    print("✅ Gráfico guardado: resultados_distribucion.png")
```

### Ejemplo 2: Análisis de Campeones Más Baneados

```python
# Cargar datos de bans
df_bans = pd.read_csv('data/01_raw/bans.csv')

# Top 20 campeones más baneados
top_bans = df_bans['champion'].value_counts().head(20)

print("🚫 TOP 20 CAMPEONES MÁS BANEADOS:")
for i, (champion, count) in enumerate(top_bans.items(), 1):
    print(f"{i:2d}. {champion}: {count} bans")

# Visualizar
plt.figure(figsize=(12, 8))
top_bans.plot(kind='barh', color='red', alpha=0.7)
plt.title('Top 20 Campeones Más Baneados', fontsize=16, fontweight='bold')
plt.xlabel('Número de Bans')
plt.ylabel('Campeón')
plt.gca().invert_yaxis()
plt.tight_layout()
plt.savefig('top_bans.png')
print("✅ Gráfico guardado: top_bans.png")
```

### Ejemplo 3: Análisis de Duración de Partidos

```python
# Cargar datos
df_matchinfo = pd.read_csv('data/01_raw/matchinfo.csv')
df_main = pd.read_csv('data/01_raw/LeagueofLegends.csv')

# Si la duración está en el dataset principal
if 'gamelength' in df_main.columns:
    # Convertir a minutos si está en segundos
    df_main['duration_minutes'] = df_main['gamelength'] / 60
    
    # Estadísticas
    print("⏱️ ESTADÍSTICAS DE DURACIÓN:")
    print(f"Duración promedio: {df_main['duration_minutes'].mean():.2f} minutos")
    print(f"Duración mínima: {df_main['duration_minutes'].min():.2f} minutos")
    print(f"Duración máxima: {df_main['duration_minutes'].max():.2f} minutos")
    print(f"Mediana: {df_main['duration_minutes'].median():.2f} minutos")
    
    # Visualizar distribución
    plt.figure(figsize=(12, 6))
    plt.hist(df_main['duration_minutes'], bins=50, color='skyblue', edgecolor='black', alpha=0.7)
    plt.title('Distribución de Duración de Partidos', fontsize=16, fontweight='bold')
    plt.xlabel('Duración (minutos)')
    plt.ylabel('Frecuencia')
    plt.axvline(df_main['duration_minutes'].mean(), color='red', linestyle='--', 
                label=f'Promedio: {df_main["duration_minutes"].mean():.1f} min')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('duracion_partidos.png')
    print("✅ Gráfico guardado: duracion_partidos.png")
```

### Ejemplo 4: Análisis de Objetivos (Dragones y Baron)

```python
# Cargar datos de monsters
df_monsters = pd.read_csv('data/01_raw/monsters.csv')

# Análisis por tipo de objetivo
if 'type' in df_monsters.columns:
    objetivos = df_monsters['type'].value_counts()
    
    print("🐉 OBJETIVOS CAPTURADOS:")
    for objetivo, cantidad in objetivos.items():
        print(f"  {objetivo}: {cantidad}")
    
    # Visualizar
    plt.figure(figsize=(10, 6))
    objetivos.plot(kind='bar', color=['#FF4500', '#FFD700', '#9370DB'], alpha=0.7)
    plt.title('Distribución de Objetivos Neutrales', fontsize=16, fontweight='bold')
    plt.xlabel('Tipo de Objetivo')
    plt.ylabel('Cantidad')
    plt.xticks(rotation=45)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('objetivos_neutrales.png')
    print("✅ Gráfico guardado: objetivos_neutrales.png")
```

### Ejemplo 5: Unir Múltiples Datasets

```python
# Cargar todos los datasets necesarios
df_main = pd.read_csv('data/01_raw/LeagueofLegends.csv')
df_matchinfo = pd.read_csv('data/01_raw/matchinfo.csv')
df_bans = pd.read_csv('data/01_raw/bans.csv')

# Unir matchinfo con datos principales
if 'gameid' in df_main.columns and 'gameid' in df_matchinfo.columns:
    df_completo = df_main.merge(df_matchinfo, on='gameid', how='left')
    print(f"✅ Datasets unidos: {len(df_completo)} registros")
    print(f"📊 Columnas totales: {len(df_completo.columns)}")

# Contar bans por partida
if 'gameid' in df_bans.columns:
    bans_por_partida = df_bans.groupby('gameid').size().reset_index(name='total_bans')
    df_completo = df_completo.merge(bans_por_partida, on='gameid', how='left')
    print("✅ Información de bans agregada")

print("\nPrimeras filas del dataset completo:")
print(df_completo.head())
```

---

## 🔗 Relaciones entre Datasets

### Diagrama de Relaciones

```
LeagueofLegends.csv (Principal)
    ↓ gameid
matchinfo.csv (Información de partidos)
    ↓ gameid
bans.csv (Bans por partida)
    ↓ gameid
gold.csv (Estadísticas de oro)
    ↓ gameid
kills.csv (Información de kills)
    ↓ gameid
monsters.csv (Objetivos neutrales)
    ↓ gameid
structures.csv (Torres destruidas)
```

### Clave Primaria
Todos los datasets se relacionan mediante `gameid` (ID único de la partida)

### Ejemplo de Unión Completa

```python
def crear_dataset_completo():
    """
    Une todos los datasets en uno solo
    """
    # Cargar datasets
    df_main = pd.read_csv('data/01_raw/LeagueofLegends.csv')
    df_matchinfo = pd.read_csv('data/01_raw/matchinfo.csv')
    df_bans = pd.read_csv('data/01_raw/bans.csv')
    df_monsters = pd.read_csv('data/01_raw/monsters.csv')
    df_structures = pd.read_csv('data/01_raw/structures.csv')
    
    # Unir con matchinfo
    df_completo = df_main.merge(df_matchinfo, on='gameid', how='left')
    
    # Agregar conteo de bans por partida
    bans_count = df_bans.groupby('gameid').size().reset_index(name='total_bans')
    df_completo = df_completo.merge(bans_count, on='gameid', how='left')
    
    # Agregar conteo de objetivos por partida y equipo
    monsters_count = df_monsters.groupby(['gameid', 'team']).size().reset_index(name='total_objectives')
    df_completo = df_completo.merge(monsters_count, on=['gameid', 'team'], how='left')
    
    # Agregar conteo de estructuras por partida y equipo
    structures_count = df_structures.groupby(['gameid', 'team']).size().reset_index(name='total_structures')
    df_completo = df_completo.merge(structures_count, on=['gameid', 'team'], how='left')
    
    print(f"✅ Dataset completo creado: {len(df_completo)} filas, {len(df_completo.columns)} columnas")
    
    return df_completo

# Usar la función
df_completo = crear_dataset_completo()

# Guardar dataset completo
df_completo.to_csv('data/02_intermediate/dataset_completo.csv', index=False)
print("✅ Dataset completo guardado en: data/02_intermediate/dataset_completo.csv")
```

---

## 🚀 Script Completo para Empezar

```python
"""
Script completo para cargar y explorar todos los CSV
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Configuración
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

def explorar_csv():
    """
    Explora todos los archivos CSV del proyecto
    """
    archivos = {
        'Principal': 'data/01_raw/LeagueofLegends.csv',
        'Match Info': 'data/01_raw/matchinfo.csv',
        'Bans': 'data/01_raw/bans.csv',
        'Gold': 'data/01_raw/gold.csv',
        'Kills': 'data/01_raw/kills.csv',
        'Monsters': 'data/01_raw/monsters.csv',
        'Structures': 'data/01_raw/structures.csv'
    }
    
    print("="*60)
    print("📊 EXPLORACIÓN DE ARCHIVOS CSV")
    print("="*60)
    
    for nombre, ruta in archivos.items():
        try:
            df = pd.read_csv(ruta)
            print(f"\n✅ {nombre}:")
            print(f"   - Archivo: {ruta}")
            print(f"   - Filas: {len(df):,}")
            print(f"   - Columnas: {len(df.columns)}")
            print(f"   - Memoria: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
            print(f"   - Columnas: {', '.join(df.columns.tolist()[:5])}...")
            
        except Exception as e:
            print(f"\n❌ Error cargando {nombre}: {str(e)}")
    
    print("\n" + "="*60)
    print("🎮 ¡Archivos CSV listos para análisis!")
    print("="*60)

# Ejecutar exploración
if __name__ == "__main__":
    explorar_csv()
```

---

## 💾 Guardar y Exportar Datos

```python
# Guardar dataset procesado
df_procesado.to_csv('data/02_intermediate/datos_procesados.csv', index=False)

# Guardar en formato Parquet (más eficiente)
df_procesado.to_parquet('data/02_intermediate/datos_procesados.parquet')

# Guardar en Excel
df_procesado.to_excel('data/02_intermediate/datos_procesados.xlsx', index=False)

# Guardar estadísticas
estadisticas = df_procesado.describe()
estadisticas.to_csv('data/08_reporting/estadisticas_descriptivas.csv')
```

---

**🎮 ¡Listo para analizar!** Con esta guía puedes trabajar con todos los archivos CSV del proyecto de League of Legends.

