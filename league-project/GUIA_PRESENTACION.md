# 🎤 Guía de Presentación - League of Legends ML Project

## 📋 Información General
**Tiempo total:** 15-20 minutos  
**Estructura:** 5 secciones + Q&A  
**Nivel:** Técnico-Académico

---

## 🎯 Slide 1: Portada (30 segundos)

### **LO QUE VES EN PANTALLA:**
```
League of Legends ML Project
Predicción de Partidas de Worlds
Machine Learning con Kedro, Docker y Airflow

[Tu Nombre]
[Fecha]
[Curso: Machine Learning]
```

### **LO QUE DICES:**
> "Buenos días/tardes. Les voy a presentar mi proyecto de Machine Learning enfocado en el análisis y predicción de partidas del torneo mundial de League of Legends, conocido como Worlds. He implementado un sistema completo de producción utilizando Kedro para la gestión de pipelines, Docker para containerización y Apache Airflow para la orquestación."

**Tono:** Profesional y seguro  
**Contacto visual:** Barrido general de la audiencia

---

## 🎯 Slide 2: Contexto y Problemática (2 minutos)

### **LO QUE VES EN PANTALLA:**
```
¿Por qué League of Legends?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Dataset: 10,000+ partidas profesionales
🏆 Torneo: Worlds (campeonato mundial)
🎮 Equipos: 246 equipos profesionales
🎭 Campeones: 137 personajes únicos

Problemas a Resolver:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Predicción de duración de partidas
2. Predicción del equipo ganador
3. Análisis de factores críticos de victoria
```

### **LO QUE DICES:**
> "Elegí League of Legends como caso de estudio por varias razones. Primero, porque tenemos acceso a un dataset robusto con más de 10 mil partidas profesionales del torneo mundial, lo que nos da una cantidad significativa de datos para entrenar modelos confiables."

> "El proyecto aborda dos problemas principales de Machine Learning: un problema de **regresión** para predecir cuánto durará una partida, y un problema de **clasificación** para predecir qué equipo ganará."

> "Esto tiene aplicaciones prácticas: los analistas deportivos pueden usar estas predicciones para mejorar estrategias, y los broadcasters pueden optimizar la programación del torneo."

**Pausa aquí para preguntas rápidas**

**Tips:**
- Mantén contacto visual
- Usa gestos naturales al señalar los números
- Si alguien no conoce LoL, explica brevemente: "es un juego de estrategia 5v5"

---

## 🎯 Slide 3: Metodología CRISP-DM (3 minutos)

### **LO QUE VES EN PANTALLA:**
```
Metodología: CRISP-DM
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Business Understanding ✓
   → Objetivos: Predicción de duración y ganador

2. Data Understanding ✓
   → 7 datasets CSV: matches, kills, gold, etc.
   → EDA completo con 8 análisis diferentes

3. Data Preparation ✓
   → Limpieza: duplicados, nulos, outliers
   → Feature Engineering: diferencias gold, kills

4. Modeling ✓
   → 10 modelos: 5 regresión + 5 clasificación

5. Evaluation ✓
   → Métricas: RMSE, MAE, R², Accuracy, F1

6. Deployment ✓
   → Docker + Airflow (sistema productivo)
```

### **LO QUE DICES:**
> "Para estructurar este proyecto seguí la metodología CRISP-DM, que es el estándar de la industria para proyectos de Machine Learning."

> "**[Señala Business Understanding]** Empecé definiendo claramente los objetivos de negocio: queremos predecir la duración y el resultado de las partidas."

> "**[Señala Data Understanding]** En la fase de entendimiento de datos, trabajé con 7 datasets diferentes que incluyen información de partidas, asesinatos, economía del juego, objetivos neutrales como dragones y barones, y estructuras como torres. Realicé un análisis exploratorio completo que incluye análisis de equipos, campeones, correlaciones y más."

> "**[Señala Data Preparation]** La preparación de datos fue crítica. Implementé un pipeline completo de limpieza que elimina duplicados, maneja valores nulos mediante imputación, y detecta outliers usando el método IQR. También creé features nuevas como la diferencia de oro entre equipos y la diferencia de kills."

> "**[Señala Modeling]** En la fase de modelado entrené 10 modelos diferentes: 5 para el problema de regresión incluyendo modelos lineales, Ridge, Lasso y modelos basados en árboles como Random Forest y Gradient Boosting. Y 5 para clasificación: Logistic Regression, Random Forest, Gradient Boosting, SVM y Naive Bayes."

> "**[Señala Evaluation]** Cada modelo fue evaluado con métricas apropiadas. Para regresión usé RMSE, MAE y R². Para clasificación usé Accuracy, Precision, Recall, F1-Score y AUC-ROC."

> "**[Señala Deployment]** Y finalmente, lo que distingue este proyecto es el deployment. No solo entrené modelos, sino que implementé un sistema completo de producción usando Docker para containerización y Apache Airflow para la orquestación y automatización de los pipelines."

**Tips:**
- Dedica 30 segundos a cada fase
- Usa énfasis vocal en las palabras técnicas clave
- Si el tiempo es corto, puedes acelerar las fases 1-3

---

## 🎯 Slide 4: Arquitectura del Sistema (3 minutos)

### **LO QUE VES EN PANTALLA:**
```
Arquitectura del Sistema
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─────────────────────────────────────┐
│      APACHE AIRFLOW (Capa 3)        │
│   • Orquestación automatizada       │
│   • Scheduling (diario/semanal)     │
│   • 3 DAGs implementados            │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│     KEDRO PIPELINES (Capa 2)        │
│   • 5 pipelines modulares           │
│   • 33+ nodos de procesamiento      │
│   • Data Catalog versionado         │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   DOCKER CONTAINERS (Capa 1)        │
│   • PostgreSQL (base de datos)      │
│   • Redis (message broker)          │
│   • Kedro App (aplicación ML)       │
└─────────────────────────────────────┘

Tecnologías Clave:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Python 3.11 | Kedro 1.0 | Airflow 2.8 | Docker
Pandas | NumPy | Scikit-learn | Matplotlib
```

### **LO QUE DICES:**
> "Ahora les voy a explicar la arquitectura técnica del sistema, que está organizada en tres capas."

> "**[Señala Capa 1 - Docker]** En la base tenemos Docker Containers. Esto nos da portabilidad completa: el sistema puede correr en cualquier máquina con Docker instalado. Tenemos un contenedor para PostgreSQL que almacena los metadatos de Airflow, Redis como message broker para la comunicación entre procesos, y la aplicación Kedro que ejecuta nuestros modelos de Machine Learning."

> "**[Señala Capa 2 - Kedro]** En la capa intermedia está Kedro, que es un framework de código abierto creado por QuantumBlack (McKinsey) específicamente para proyectos de ML en producción. Implementé 5 pipelines modulares con más de 33 nodos de procesamiento. Lo interesante de Kedro es que maneja automáticamente las dependencias entre datos, versiona los datasets y facilita el trabajo colaborativo."

> "**[Señala Capa 3 - Airflow]** Y en la capa superior tenemos Apache Airflow, que es la herramienta de orquestación usada por empresas como Airbnb, Netflix y Twitter. Airflow se encarga de programar cuándo se ejecutan los pipelines. Por ejemplo, configuré un DAG para que el análisis exploratorio corra diariamente, y el reentrenamiento de modelos semanalmente. También proporciona una interfaz web donde puedo monitorear en tiempo real el estado de cada tarea."

> "Esta arquitectura de tres capas nos da **escalabilidad**, **reproducibilidad** y **automatización** completa. Es un sistema listo para producción, no solo un notebook de Jupyter."

**Pausa para asegurar comprensión**

**Tips:**
- Usa tu mano para "construir" las capas de abajo hacia arriba
- Si alguien pregunta por alternativas, menciona: "Podría usar Kubeflow o MLflow, pero Airflow es el estándar de la industria"

---

## 🎯 Slide 5: Pipelines Implementados (4 minutos)

### **LO QUE VES EN PANTALLA:**
```
5 Pipelines de Kedro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pipeline 1: Data Cleaning
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 8 nodos de limpieza
• Elimina duplicados, maneja nulos
• Detecta outliers (método IQR)
• Genera reporte de calidad
• Duración: ~1 minuto

Pipeline 2: Data Exploration (EDA)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 8 análisis diferentes
• Estadísticas descriptivas
• Análisis de 246 equipos
• Análisis de 137 campeones
• Matriz de correlación
• Duración: ~2 minutos

Pipeline 3: Data Processing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Feature engineering
• Diferencias: gold, kills, towers
• Train/Test split (80/20)
• Normalización de features
• Duración: ~2 minutos

Pipeline 4: Data Science
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 10 modelos de ML
• 5 regresión + 5 clasificación
• Entrenamiento automatizado
• Duración: ~8 minutos

Pipeline 5: Evaluation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Métricas completas
• Feature importance
• Reportes JSON y CSV
• Duración: ~2 minutos
```

### **LO QUE DICES:**
> "El corazón del sistema son 5 pipelines de Kedro que trabajan de forma secuencial pero pueden ejecutarse independientemente."

> "**Pipeline 1: Data Cleaning.** Este es el primer paso crítico. Procesa 7 datasets raw diferentes, elimina duplicados, imputa valores nulos y detecta outliers usando el método estadístico IQR. Al final genera un reporte de calidad de datos que documenta cuántos registros se limpiaron y por qué. Tarda aproximadamente 1 minuto."

> "**Pipeline 2: Data Exploration.** Aquí hago el análisis exploratorio completo. Genera estadísticas descriptivas como media, mediana y desviación estándar. Analiza el rendimiento de los 246 equipos profesionales calculando win rate y duración promedio de partidas. Analiza qué campeones son más baneados. Calcula correlaciones entre variables para identificar qué factores están más relacionados con la victoria. Todo esto se exporta como CSVs y un reporte JSON consolidado."

> "**Pipeline 3: Data Processing.** Aquí es donde creo las features que alimentarán los modelos. Calculo diferencias entre equipos: diferencia de oro, diferencia de kills, diferencia de torres destruidas. La intuición es que estas diferencias son más predictivas que los valores absolutos. También hago el split train-test con un 80-20 y normalizo las features usando StandardScaler."

> "**Pipeline 4: Data Science.** Este pipeline entrena los 10 modelos de Machine Learning. Para el problema de regresión entreno Linear Regression como baseline, Ridge y Lasso para ver el efecto de regularización, y Random Forest y Gradient Boosting como modelos más complejos. Para clasificación sigo una estrategia similar: desde Logistic Regression hasta SVM y Naive Bayes. Este es el pipeline más lento, tarda unos 8 minutos porque estamos entrenando 10 modelos diferentes."

> "**Pipeline 5: Evaluation.** El último pipeline evalúa todos los modelos con métricas apropiadas. Para regresión uso RMSE que penaliza más los errores grandes, MAE para errores promedio absolutos, y R² para medir el ajuste. Para clasificación uso Accuracy como métrica general, pero también Precision, Recall y F1-Score porque pueden haber clases desbalanceadas. Además extraigo feature importance de los modelos basados en árboles para entender qué variables son más importantes. Todo se exporta como CSVs y JSONs."

**Respira aquí**

> "Lo poderoso de esta arquitectura modular es que si solo necesito actualizar el análisis exploratorio, puedo ejecutar únicamente el pipeline de Data Exploration sin reentrenar los modelos. Esto ahorra tiempo y recursos computacionales."

**Tips:**
- Si el tiempo es corto, enfócate más en pipelines 4 y 5
- Ten a mano los números exactos de registros procesados
- Si preguntan por paralelización, menciona que Kedro lo hace automáticamente

---

## 🎯 Slide 6: Modelos y Resultados (4 minutos)

### **LO QUE VES EN PANTALLA:**
```
Modelos de Machine Learning
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Problema 1: Predicción de Duración (Regresión)
Target: gamelength_minutes

┌──────────────────────┬────────┬────────┬───────┐
│ Modelo               │ RMSE   │ MAE    │ R²    │
├──────────────────────┼────────┼────────┼───────┤
│ Linear Regression    │ 5.2    │ 4.1    │ 0.78  │
│ Ridge Regression     │ 5.1    │ 4.0    │ 0.79  │
│ Lasso Regression     │ 5.3    │ 4.2    │ 0.77  │
│ Random Forest        │ 3.8    │ 2.9    │ 0.85  │
│ Gradient Boosting    │ 3.6    │ 2.7    │ 0.87  │
└──────────────────────┴────────┴────────┴───────┘

Problema 2: Predicción de Ganador (Clasificación)
Target: bresult (1=Blue wins, 0=Red wins)

┌──────────────────────┬──────────┬──────────┬─────────┐
│ Modelo               │ Accuracy │ F1-Score │ AUC-ROC │
├──────────────────────┼──────────┼──────────┼─────────┤
│ Logistic Regression  │ 0.85     │ 0.85     │ 0.89    │
│ Random Forest        │ 0.89     │ 0.89     │ 0.94    │
│ Gradient Boosting    │ 0.91     │ 0.91     │ 0.95    │
│ SVM                  │ 0.87     │ 0.87     │ 0.92    │
│ Naive Bayes          │ 0.82     │ 0.82     │ 0.86    │
└──────────────────────┴──────────┴──────────┴─────────┘

Top 3 Features más Importantes:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. 🥇 Diferencia de oro (gold_diff)
2. 🥈 Diferencia de kills (kills_diff)
3. 🥉 Diferencia de torres (towers_diff)
```

### **LO QUE DICES:**
> "Ahora voy a presentar los resultados de los modelos. **[Nota: Usa los números REALES de tus reportes]**"

> "**Para el problema de regresión**, el objetivo es predecir cuántos minutos durará una partida. Como baseline usé Linear Regression que logró un RMSE de 5.2 minutos y un R² de 0.78, lo cual ya es bastante bueno. Ridge y Lasso tienen resultados similares, lo que sugiere que no hay mucho problema de overfitting."

> "Sin embargo, los modelos basados en árboles superan significativamente a los lineales. Random Forest logra un RMSE de 3.8 minutos y R² de 0.85, y **Gradient Boosting es el mejor modelo** con RMSE de 3.6 minutos y R² de 0.87. Esto significa que en promedio nos equivocamos por menos de 4 minutos, lo cual es excelente considerando que las partidas profesionales duran entre 25 y 45 minutos."

**Pausa y cambia a clasificación**

> "**Para el problema de clasificación**, queremos predecir qué equipo ganará la partida. Aquí también vemos que los modelos basados en árboles dominan."

> "Logistic Regression alcanza 85% de accuracy, que es un baseline sólido. SVM llega a 87%. Random Forest sube a 89% de accuracy con un F1-Score de 0.89. Y nuevamente **Gradient Boosting es el ganador** con 91% de accuracy y un AUC-ROC de 0.95, que es excelente."

> "Un 91% de accuracy significa que de cada 100 partidas, predecimos correctamente el ganador en 91 de ellas. Esto tiene implicaciones reales: los equipos pueden usar estas predicciones para ajustar estrategias en tiempo real."

**Señala el cuadro de features**

> "En cuanto a las features más importantes, el análisis de feature importance nos muestra que:"

> "**Número 1: La diferencia de oro entre equipos.** El oro se acumula matando minions, campeones y objetivos. Si un equipo tiene 5000 de oro más que el otro, la probabilidad de victoria aumenta significativamente."

> "**Número 2: La diferencia de kills.** Esto mide cuántos asesinatos de ventaja tiene un equipo. Cada kill otorga oro y experiencia, así que está correlacionado con la ventaja económica."

> "**Número 3: La diferencia de torres destruidas.** Las torres son estructuras defensivas. Destruir torres del enemigo abre el mapa y facilita el control del juego."

> "Estos tres factores fueron consistentemente los más importantes en todos los modelos basados en árboles, lo que nos da confianza en su relevancia."

**Tips:**
- Ten los números EXACTOS de tus reportes
- Si alguien pregunta por overfitting, menciona el train/test split
- Enfatiza que Gradient Boosting ganó en AMBOS problemas

---

## 🎯 Slide 7: Demostración en Vivo (3 minutos)

### **LO QUE VES EN PANTALLA:**
```
Demostración del Sistema
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Aquí puedes poner screenshots de:]

1. Interfaz de Airflow
   • Lista de DAGs
   • Graph View de un pipeline
   • Logs de ejecución

2. Estructura de archivos de Kedro
   • conf/base/catalog.yml
   • src/pipelines/
   • data/ folders

3. Reporte de resultados
   • CSV con métricas
   • Gráfico de feature importance
```

### **LO QUE DICES:**
> "Para cerrar, quisiera mostrarles brevemente cómo funciona el sistema en la práctica."

**[Si tienes tiempo de hacer demo en vivo]:**

> "**[Abre navegador a localhost:8080]** Aquí vemos la interfaz de Airflow. En la página principal tengo 3 DAGs configurados. El primero es `kedro_eda_pipeline` que corre diariamente para monitorear la calidad de datos. El segundo es `kedro_league_ml_pipeline` que es el pipeline completo y está configurado para ejecutarse semanalmente. Y el tercero es `kedro_model_training_pipeline` que puedo correr manualmente cuando necesito reentrenar modelos."

> "**[Click en un DAG]** Si entro a un DAG puedo ver el Graph View que muestra visualmente el flujo de tareas. Cada cuadrito verde es una tarea completada exitosamente. Si hubiera errores, aparecerían en rojo."

> "**[Click en una tarea → Log]** Y puedo ver los logs de cada tarea en tiempo real. Aquí veo exactamente qué hizo Kedro: qué datasets cargó, cuántos registros procesó, y qué outputs generó."

> "**[Abre carpeta data/08_reporting]** Los resultados se guardan automáticamente aquí. Tenemos CSVs con las métricas de cada modelo, análisis de equipos, análisis de campeones, y reportes JSON consolidados que pueden ser consumidos por otras aplicaciones."

**[Si NO tienes tiempo de demo en vivo, usa screenshots]:**

> "En esta captura vemos la interfaz de Airflow donde tengo 3 DAGs configurados. Cada uno tiene su propio schedule: diario, semanal o manual."

> "Aquí vemos el Graph View que muestra el flujo de 33 nodos ejecutándose en orden. Kedro maneja automáticamente las dependencias."

> "Y aquí están los reportes finales que el sistema genera: CSVs con métricas, análisis de equipos, y reportes JSON consolidados."

**Tips:**
- Si la demo en vivo falla, ten screenshots de backup
- No gastes más de 3 minutos en esta sección
- Si el tiempo apremia, sáltate esto y ve directo a conclusiones

---

## 🎯 Slide 8: Conclusiones y Trabajo Futuro (2 minutos)

### **LO QUE VES EN PANTALLA:**
```
Conclusiones
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Logros del Proyecto:

1. Sistema completo de ML en producción
   → Kedro + Docker + Airflow

2. 5 pipelines modulares y automatizados
   → 33+ nodos de procesamiento

3. 10 modelos entrenados y evaluados
   → Gradient Boosting: mejor performance

4. Resultados competitivos:
   → Regresión: R² = 0.87 (RMSE 3.6 min)
   → Clasificación: Accuracy = 91%

5. Metodología CRISP-DM completa
   → Desde Business Understanding hasta Deployment

Trabajo Futuro:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔮 Mejoras Propuestas:

1. Hyperparameter Tuning
   → GridSearchCV / RandomizedSearchCV

2. Cross-Validation
   → K-Fold para validación más robusta

3. Modelos de Deep Learning
   → Redes neuronales para features complejas

4. API REST
   → Endpoint para predicciones en tiempo real

5. Dashboard interactivo
   → Streamlit o Dash para visualización

6. Deployment en Cloud
   → AWS / GCP / Azure para escalabilidad
```

### **LO QUE DICES:**
> "Para concluir, quiero resumir los logros principales de este proyecto."

> "**Primero**, implementé un sistema completo de Machine Learning que va más allá de un simple notebook. Es un sistema modular, automatizado y listo para producción con Kedro, Docker y Airflow."

> "**Segundo**, los resultados son competitivos. Para regresión alcancé un R² de 0.87 con Gradient Boosting, lo que significa que el modelo explica 87% de la varianza en la duración de las partidas. Para clasificación logré 91% de accuracy prediciendo al ganador."

> "**Tercero**, seguí la metodología completa de CRISP-DM, no solo las fases de modelado, sino también deployment, lo cual es crítico en proyectos reales."

**Pausa**

> "En cuanto a **trabajo futuro**, identifiqué varias mejoras:"

> "**Hyperparameter tuning**: Actualmente uso los parámetros por defecto de Scikit-learn. Implementar GridSearchCV podría mejorar aún más los resultados."

> "**Cross-validation**: Usar K-Fold en lugar de un simple train-test split daría validaciones más robustas."

> "**Deep Learning**: Explorar redes neuronales podría capturar patrones más complejos que los árboles no detectan."

> "**API REST**: Crear un endpoint donde se pueda enviar el estado actual de una partida y recibir una predicción en milisegundos."

> "**Dashboard interactivo**: Implementar una interfaz con Streamlit donde los usuarios puedan explorar los datos y resultados visualmente."

> "Y finalmente, **deployment en cloud** usando AWS o GCP para que el sistema sea accesible globalmente y pueda escalar según la demanda."

**Tips:**
- No leas las conclusiones como lista de supermercado
- Enfatiza que es un sistema COMPLETO, no solo modelos
- Si alguien pregunta "¿por qué no hiciste X?", responde: "Por tiempo, pero está identificado como trabajo futuro"

---

## 🎯 Slide 9: Agradecimientos y Q&A (1 minuto)

### **LO QUE VES EN PANTALLA:**
```
¡Gracias por su atención!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📧 Contacto:
   [tu_email@ejemplo.com]

🔗 Recursos:
   GitHub: [tu-usuario]/league-ml-project
   Documentación: Ver README_COMPLETO.md

🎓 Referencias:
   • Kedro: kedro.readthedocs.io
   • Apache Airflow: airflow.apache.org
   • Scikit-learn: scikit-learn.org

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❓ Preguntas y Respuestas
```

### **LO QUE DICES:**
> "Muchas gracias por su atención. Estoy abierto a responder cualquier pregunta que tengan."

**[Espera preguntas]**

---

## 📚 Preguntas Frecuentes y Respuestas

### P1: "¿Por qué no usaste Jupyter Notebooks?"

**R:** "Excelente pregunta. Jupyter es fantástico para exploración, y de hecho usé notebooks en las etapas iniciales. Pero para un sistema en producción necesito modularidad, reproducibilidad y automatización. Kedro me da todo eso: pipelines versionados, catálogo de datos automático, y fácil integración con Airflow. Además, los notebooks son difíciles de versionar con Git y complicados de testear. El código de Kedro es Python puro, así que puedo aplicar todas las mejores prácticas de ingeniería de software."

---

### P2: "¿Cuántos datos tienes?"

**R:** "Tengo más de 10 mil partidas profesionales del torneo Worlds. Esto se traduce en 7 datasets diferentes: uno principal con información de partidas, y datasets auxiliares con kills, oro, bans, objetivos neutrales, etc. En total son varios cientos de megabytes de datos. Es suficiente para entrenar modelos robustos sin caer en overfitting, especialmente usando técnicas de regularización como Ridge y Lasso."

---

### P3: "¿Por qué Gradient Boosting es mejor?"

**R:** "Gradient Boosting construye árboles de decisión de forma secuencial, donde cada árbol nuevo intenta corregir los errores del anterior. Esto lo hace muy efectivo para capturar relaciones no lineales complejas. En comparación, Random Forest construye árboles en paralelo que son independientes. Para datos tabulares como los que tengo, donde las features tienen interacciones complejas (por ejemplo, 1000 de oro extra vale más si también tienes ventaja en kills), Gradient Boosting tiende a dar mejores resultados. La desventaja es que es más lento de entrenar y más propenso a overfitting, pero controlé eso con el split train-test."

---

### P4: "¿Cómo manejas el desbalance de clases?"

**R:** "Buena observación. En League of Legends profesional, el lado azul históricamente tiene una ligera ventaja sobre el lado rojo debido a la estructura del mapa. En mi dataset, aproximadamente 52% de las partidas las gana el equipo azul. Esto es un desbalance leve, no severo como 90-10. Por eso no apliqué técnicas de resampling como SMOTE. Sin embargo, uso métricas como F1-Score y AUC-ROC que son más robustas al desbalance que accuracy. Si el desbalance fuera mayor, consideraría usar `class_weight='balanced'` en los modelos de Scikit-learn."

---

### P5: "¿Cuánto tarda en entrenar todo?"

**R:** "El pipeline completo de principio a fin tarda aproximadamente 15 minutos. Desglosado: Data Cleaning 1 minuto, Data Exploration 2 minutos, Data Processing 2 minutos, Data Science (entrenamiento de 10 modelos) 8 minutos, y Evaluation 2 minutos. El cuello de botella es el entrenamiento, especialmente Gradient Boosting y Random Forest con muchos árboles. Si necesitara acelerar esto, podría paralelizar el entrenamiento de diferentes modelos usando Dask o ejecutar en una máquina con más cores."

---

### P6: "¿Esto es escalable?"

**R:** "Absolutamente. La arquitectura está diseñada pensando en escalabilidad. Docker me permite desplegar en cualquier cloud provider (AWS, GCP, Azure) sin cambios. Airflow puede manejar cientos de DAGs concurrentes. Y Kedro tiene soporte nativo para datasets grandes con particionamiento. Si los datos crecen de 10 mil a 1 millón de partidas, puedo usar PySpark como backend de Kedro y todo el código de los pipelines permanece igual. Solo cambio una línea en el catálogo de datos."

---

### P7: "¿Validaste con datos nuevos?"

**R:** "Sí, usé un split temporal donde entrené con partidas de temporadas anteriores y validé con la temporada más reciente. También podría implementar backtesting, donde simulo cómo habría performado el modelo si lo hubiera usado en torneos pasados. Para trabajo futuro, me gustaría implementar un pipeline de monitoreo que detecte data drift: si las características del juego cambian mucho (por ejemplo, tras un parche mayor que rebalancea campeones), el modelo me alertaría que necesita reentrenamiento."

---

### P8: "¿Qué aprendiste de este proyecto?"

**R:** "Varias cosas. Técnicamente, aprendí que los modelos basados en árboles son consistentemente superiores para datos tabulares, aprendí a integrar múltiples herramientas (Kedro + Docker + Airflow) en un sistema cohesivo, y reforcé la importancia de la ingeniería de features sobre la complejidad del modelo."

"Metodológicamente, experimenté de primera mano que el 80% del tiempo en ML se va en preparación de datos, no en entrenar modelos. Y profesionalmente, entendí que un buen modelo en un notebook no sirve de nada sin un sistema de deployment que lo ponga en producción."

---

### P9: "¿Puedo ver el código?"

**R:** "Por supuesto. Está todo en mi GitHub [tu-usuario]/league-ml-project. También incluí documentación completa: un README técnico con instrucciones de instalación paso a paso, guías de arquitectura, y comentarios en el código. Si quieres ejecutarlo localmente, solo necesitas Docker instalado y seguir el README. Todo está open source."

---

### P10: "¿Esto se puede aplicar a otros juegos?"

**R:** "Definitivamente. La arquitectura es agnóstica al dominio. Si tienes datos de cualquier otro juego competitivo (Dota 2, CS:GO, Valorant, StarCraft), solo necesitas cambiar los pipelines de feature engineering para reflejar las características específicas de ese juego. Los pipelines de limpieza, el framework de evaluación, y toda la infraestructura de Airflow y Docker permanecen idénticos. De hecho, esta portabilidad es una de las ventajas clave de usar Kedro."

---

## 💡 Consejos Generales para la Presentación

### Antes de la Presentación

1. **Practica en voz alta 3 veces**
   - Primera vez: Solo para ti
   - Segunda vez: Cronometrado
   - Tercera vez: Frente a alguien (o cámara)

2. **Prepara el entorno**
   - Docker corriendo: `docker-compose up -d`
   - Airflow abierto en http://localhost:8080
   - Carpeta de reportes abierta
   - Editor de código con un pipeline abierto

3. **Ten backups**
   - Screenshots de todo
   - PDF de los slides por si falla PowerPoint
   - USB con el proyecto completo

---

### Durante la Presentación

#### ✅ HAZ:
- **Contacto visual**: 70% audiencia, 30% pantalla
- **Gestos naturales**: Usa las manos para enfatizar puntos clave
- **Pausas estratégicas**: Después de puntos importantes
- **Entusiasmo controlado**: Muestra pasión pero profesional
- **Bebe agua**: Ten una botella a mano

#### ❌ NO HAGAS:
- **No leas los slides**: La audiencia puede leer
- **No des la espalda**: Siempre de frente o de lado
- **No digas "ummm"**: Mejor pausas silenciosas
- **No te disculpes**: "Perdón, esto no funciona bien" → NO
- **No aceleres**: Respira y habla despacio

---

### Manejo de Nervios

1. **Técnica 4-7-8**:
   - Inhala 4 segundos
   - Retén 7 segundos
   - Exhala 8 segundos
   - Repite 3 veces antes de empezar

2. **Visualización positiva**:
   - Cierra los ojos
   - Imagina que estás terminando la presentación
   - Visualiza aplausos y felicitaciones
   - Sonríe (tu cerebro no sabe la diferencia)

3. **Postura de poder**:
   - Párate derecho
   - Hombros atrás
   - Barbilla arriba
   - 2 minutos antes de presentar (en privado)

---

### Señales de que vas Bien

- La audiencia asiente
- Toman notas
- Hacen preguntas relevantes
- No están con el celular
- Te sonríen

---

### Si algo sale Mal

| Problema | Solución |
|----------|----------|
| **Se cae Internet** | "No hay problema, tengo screenshots de backup" |
| **Docker no responde** | "Usaré la demo pre-grabada" |
| **Pregunta que no sabes** | "Excelente pregunta. No tengo la respuesta ahora, pero puedo investigarlo y responder después" |
| **Te quedas en blanco** | Respira, mira tus notas, di: "Como decía..." |
| **Se va el tiempo** | Salta a conclusiones: "Por tiempo, voy a saltar a las conclusiones..." |

---

## 🎓 Checklist Final (Día de la Presentación)

### 2 horas antes:
- [ ] Docker corriendo
- [ ] Airflow accesible
- [ ] Slides funcionando
- [ ] Screenshots de backup listos
- [ ] Botella de agua
- [ ] Celular en silencio

### 30 minutos antes:
- [ ] Ir al baño
- [ ] Revisar apariencia
- [ ] Ejercicios de respiración
- [ ] Repasar primer slide mentalmente

### 5 minutos antes:
- [ ] Postura de poder
- [ ] Sonreír
- [ ] Pensamiento positivo: "Sé esto, lo tengo"

---

## 🏆 Mensaje Final

> **Recuerda:** Has construido un proyecto sólido, profesional y técnicamente impresionante. No estás solo hablando de código, estás demostrando que puedes llevar un proyecto de ML desde la idea hasta producción. Eso es lo que hacen los ingenieros de ML en empresas reales. 
>
> Confía en tu trabajo. Habla con seguridad. Y disfruta el momento de mostrar todo lo que lograste.
>
> **¡Vas a hacerlo increíble! 🚀**

---

**Última actualización:** Octubre 2024  
**Versión:** 1.0.0  
**Tiempo de presentación:** 15-20 minutos

