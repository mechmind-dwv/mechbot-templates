
#    !jupyter nbconvert --to html kpi_report.ipynb
#
[![GitHub](https://img.shields.io/badge/Ver_en_GitHub-181717?style=for-the-badge&logo=github)](https://github.com/mechbot/marketing)
```

## Estructura del Dashboard

1. **Segmentación de Mercado**
   - Visualización interactiva por segmento
   - Widget dropdown para selección

2. **Performance de Canales**
   - Scatter plot de CTR vs Costo por Lead
   - Tamaño de burbujas por inversión

3. **Tracking de Objetivos**
   - Gráfico funnel de progreso
   - Comparación meta vs actual

4. **Recomendaciones**
   - Generación automática basada en datos
   - Priorización por tamaño de mercado

## Integración con el Repositorio

```bash
marketing/
├── dashboards/
│   ├── kpi_report.ipynb       # Este notebook
│   └── requirements.txt       # Dependencias
├── data/
│   └── segmentacion.csv       # Fuente de datos
└── notebooks/
    └── segment_analysis.ipynb # Análisis complementario
```

## Configuración Requerida

```python
# requirements.txt
pandas>=1.3.0
plotly>=5.0.0
jupyter>=1.0.0
ipywidgets>=7.6.0
```

Para ejecutar:
```bash
pip install -r requirements.txt
jupyter notebook kpi_report.ipynb
```

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mechbot/marketing/main?filepath=dashboards%2Fkpi_report.ipynb)
