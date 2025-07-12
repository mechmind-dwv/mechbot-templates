#!/bin/bash

# 🛠️ Script de Reparación MechBot Templates
# Arregla el notebook KPI y guarda los cambios automáticamente

echo "🚀 MechBot Templates - Reparación de Notebook KPI"
echo "================================================="

# Verificar ubicación
if [ ! -d "marketing/dashboards" ]; then
    echo "❌ Error: Directorio marketing/dashboards no encontrado"
    echo "💡 Asegúrate de estar en la raíz del repositorio mechbot-templates"
    exit 1
fi

# Paso 1: Hacer backup del archivo actual
echo "📋 Paso 1: Creando backup del archivo actual..."
if [ -f "marketing/dashboards/kpi_report.ipynb" ]; then
    cp "marketing/dashboards/kpi_report.ipynb" "marketing/dashboards/kpi_report.ipynb.backup"
    echo "✅ Backup creado: kpi_report.ipynb.backup"
fi

# Paso 2: Crear el notebook correcto
echo "📋 Paso 2: Creando notebook en formato correcto..."

cat > "marketing/dashboards/kpi_report.ipynb" << 'EOF'
{
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "# 📊 Dashboard KPI MechBot 2.0x\n",
        "\n",
        "Dashboard interactivo para monitorear los KPIs principales del proyecto MechBot."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 🚀 Configuración inicial\n",
        "import plotly.express as px\n",
        "import plotly.graph_objects as go\n",
        "from datetime import datetime, timedelta\n",
        "import pandas as pd\n",
        "import numpy as np\n",
        "\n",
        "print(\"🚀 Iniciando Dashboard KPI MechBot 2.0x\")\n",
        "print(\"=\" * 50)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📊 Generar datos de ejemplo para KPIs\n",
        "def generar_datos_kpi():\n",
        "    \"\"\"Genera datos de ejemplo para el dashboard\"\"\"\n",
        "    fechas = pd.date_range(start='2024-01-01', end='2024-12-31', freq='D')\n",
        "    \n",
        "    # Métricas de rendimiento\n",
        "    usuarios_activos = np.random.randint(100, 1000, len(fechas))\n",
        "    conversiones = np.random.randint(10, 100, len(fechas))\n",
        "    revenue = np.random.uniform(1000, 10000, len(fechas))\n",
        "    \n",
        "    return pd.DataFrame({\n",
        "        'fecha': fechas,\n",
        "        'usuarios_activos': usuarios_activos,\n",
        "        'conversiones': conversiones,\n",
        "        'revenue': revenue\n",
        "    })\n",
        "\n",
        "# Generar datos\n",
        "df = generar_datos_kpi()\n",
        "print(f\"📊 Datos generados: {len(df)} registros\")\n",
        "df.head()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📈 KPI 1: Usuarios Activos\n",
        "fig_usuarios = px.line(df, x='fecha', y='usuarios_activos', \n",
        "                       title='📈 Usuarios Activos Diarios',\n",
        "                       labels={'usuarios_activos': 'Usuarios', 'fecha': 'Fecha'})\n",
        "fig_usuarios.update_layout(height=400)\n",
        "fig_usuarios.show()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 🎯 KPI 2: Conversiones\n",
        "df_mensual = df.resample('M', on='fecha').sum().reset_index()\n",
        "fig_conversiones = px.bar(df_mensual, \n",
        "                          x='fecha', y='conversiones',\n",
        "                          title='🎯 Conversiones Mensuales',\n",
        "                          labels={'conversiones': 'Conversiones', 'fecha': 'Mes'})\n",
        "fig_conversiones.update_layout(height=400)\n",
        "fig_conversiones.show()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 💰 KPI 3: Revenue\n",
        "fig_revenue = px.area(df, x='fecha', y='revenue',\n",
        "                      title='💰 Revenue Acumulado',\n",
        "                      labels={'revenue': 'Revenue ($)', 'fecha': 'Fecha'})\n",
        "fig_revenue.update_layout(height=400)\n",
        "fig_revenue.show()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📋 Métricas resumen\n",
        "print(\"\\n📋 RESUMEN DE KPIs\")\n",
        "print(\"=\" * 30)\n",
        "print(f\"• Total Usuarios: {df['usuarios_activos'].sum():,}\")\n",
        "print(f\"• Total Conversiones: {df['conversiones'].sum():,}\")\n",
        "print(f\"• Revenue Total: ${df['revenue'].sum():,.2f}\")\n",
        "print(f\"• Promedio Diario Usuarios: {df['usuarios_activos'].mean():.0f}\")\n",
        "print(f\"• Tasa Conversión: {(df['conversiones'].sum() / df['usuarios_activos'].sum() * 100):.2f}%\")\n",
        "\n",
        "print(\"\\n✅ Dashboard completado exitosamente!\")"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
    },
    "language_info": {
      "codemirror_mode": {
        "name": "ipython",
        "version": 3
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3",
      "version": "3.8.0"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
EOF

echo "✅ Notebook corregido y guardado correctamente"

# Paso 3: Verificar que el archivo esté en formato correcto
echo "📋 Paso 3: Verificando formato del notebook..."
if python3 -c "import json; json.load(open('marketing/dashboards/kpi_report.ipynb'))" 2>/dev/null; then
    echo "✅ Formato JSON válido"
else
    echo "❌ Error en el formato JSON"
    exit 1
fi

# Paso 4: Actualizar requirements.txt si es necesario
echo "📋 Paso 4: Verificando dependencias..."
if [ ! -f "marketing/dashboards/requirements.txt" ]; then
    cat > "marketing/dashboards/requirements.txt" << 'EOF'
plotly>=5.0.0
pandas>=1.3.0
numpy>=1.21.0
jupyter>=1.0.0
nbformat>=5.0.0
EOF
    echo "✅ requirements.txt creado"
else
    echo "✅ requirements.txt ya existe"
fi

# Paso 5: Guardar cambios en Git
echo "📋 Paso 5: Guardando cambios en Git..."

# Agregar archivos
git add marketing/dashboards/kpi_report.ipynb
git add marketing/dashboards/requirements.txt

# Verificar si hay cambios
if git diff --cached --quiet; then
    echo "ℹ️  No hay cambios nuevos para guardar"
else
    # Hacer commit
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "🛠️ Fix: Corrige formato del notebook KPI - ${TIMESTAMP}"
    
    # Intentar push si hay remote
    if git remote get-url origin > /dev/null 2>&1; then
        echo "🌐 Subiendo cambios a GitHub..."
        if git push origin main; then
            echo "✅ Cambios guardados exitosamente en GitHub"
        else
            echo "⚠️  Error al subir, pero cambios guardados localmente"
        fi
    else
        echo "✅ Cambios guardados localmente"
    fi
fi

echo ""
echo "🎉 ¡PROCESO COMPLETADO!"
echo "====================="
echo "• Notebook corregido: marketing/dashboards/kpi_report.ipynb"
echo "• Formato: JSON válido para Jupyter"
echo "• Dependencias: requirements.txt actualizado"
echo "• Git: Cambios guardados"
echo ""
echo "🚀 Ahora puedes ejecutar:"
echo "jupyter notebook marketing/dashboards/kpi_report.ipynb"
echo ""
echo "📱 O desde el navegador:"
echo "http://localhost:8888/notebooks/kpi_report.ipynb"
