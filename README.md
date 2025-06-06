🏀 HoopVision - NBA Player Performance Analytics

Análisis del rendimiento de jugadores de la NBA durante las últimas 5 temporadas temporadas

👨‍💻 Un equipo de analistas de datos aplicando ciencia de datos al rendimiento en la NBA

Equipo de trabajo:

Sebastián Barreto – Data Engineer

Diego Gorosito – Data Analyst

Román Matheus – Data Analyst

Efraín Chapal – Data Science

Andrea Narváez – Gestión de Proyectos

📚 Objetivo del análisis
"Visualizando el rendimiento individual para entender el juego."

El propósito de HoopVision es brindar un enfoque analítico centrado en el desempeño de jugadores de la NBA durante las últimas cinco temporadas, explorando cómo sus atributos físicos, evolución temporal y posición en el draft impactan en su rendimiento.

Este análisis busca reducir la brecha competitiva mediante la visualización clara de KPIs relevantes, favoreciendo la toma de decisiones estratégicas por parte de cuerpos técnicos y analistas deportivos.

🔍 Datos y Origen
Fuente: Base oficial de la NBA (formato .csv y .sqlite)

Versión: 231 (~4.66 GB de datos)

Origen: Kaggle y SQLite local

Contenido:

Estadísticas individuales (PTS, AST, REB, FG%, etc.)

Datos del draft (posición, ronda)

Datos físicos (altura, peso, wingspan)

Información por partido y temporada

Información de equipos (detalles y rendimiento)

🛠️ Tecnologías Usadas
Lenguajes: Python, SQL

Herramientas: Pandas, NumPy, SQLite, Power BI

Entornos: Jupyter Notebook, Power BI Desktop

Librerías: Matplotlib, Seaborn

Modelado: Modelo relacional y visual basado en Power BI

⚙️ Metodología de Trabajo
Extracción y Limpieza de Datos:

Unificación de nombres, fechas y formatos

Eliminación de nulos, duplicados e inconsistencias

Creación de claves y relaciones entre tablas

Análisis Exploratorio (EDA):

Evaluación de distribución de variables

Relación entre rendimiento y características físicas

Modelado Relacional:

Diseño eficiente del modelo de datos

Tabla de hechos: play_by_play

Dimensiones: jugadores, equipos, draft, partidos

Visualización en Power BI:

KPIs clave por jugador y por temporada

Gráficos de dispersión, tarjetas, rankings y evolución temporal

Segmentadores por año, nacionalidad y posición

📊 Principales Métricas Analizadas
Puntos por partido (PPG)

Participación ofensiva (%)

Evolución por temporada

Altura, Wingspan, Velocidad

Posición en el draft vs desempeño

🚀 Conclusiones Destacadas
La visualización del rendimiento individual puede ser un diferencial competitivo si se analiza correctamente.

El modelo permite identificar talentos en desarrollo, rendimientos sobresalientes inesperados y oportunidades de mejora táctica.

Equipos con menor inversión en analítica pueden cerrar la brecha al aplicar esta solución escalable con datos públicos bien tratados.
