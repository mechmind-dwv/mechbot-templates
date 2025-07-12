#!/bin/bash

# 🔧 Script para instalar dependencias y guardar cambios
# MechBot Templates - Solución completa

echo "🚀 MechBot Templates - Instalación de dependencias y guardado"
echo "============================================================"

# Verificar que estamos en el entorno virtual
echo "📋 Paso 1: Verificando entorno virtual..."
if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "✅ Entorno virtual activo: $VIRTUAL_ENV"
else
    echo "❌ No hay entorno virtual activo"
    echo "💡 Ejecuta: source venv/bin/activate"
    exit 1
fi

# Verificar ubicación del proyecto
if [ ! -d "marketing/dashboards" ]; then
    echo "❌ No estás en el directorio correcto"
    echo "💡 Navega al directorio mechbot-templates"
    exit 1
fi

# Paso 2: Actualizar requirements.txt con todas las dependencias necesarias
echo "📋 Paso 2: Actualizando requirements.txt..."

cat > "marketing/dashboards/requirements.txt" << 'EOF'
# Dashboard KPI Dependencies
plotly>=5.15.0
pandas>=1.5.0
numpy>=1.24.0
jupyter>=1.0.0
nbformat>=5.4.0
ipython>=8.0.0
ipykernel>=6.15.0

# Utilidades adicionales
python-dateutil>=2.8.0
pytz>=2022.1
EOF

echo "✅ requirements.txt actualizado"

# Paso 3: Instalar todas las dependencias
echo "📋 Paso 3: Instalando dependencias..."

pip install -r marketing/dashboards/requirements.txt

if [ $? -eq 0 ]; then
    echo "✅ Dependencias instaladas correctamente"
else
    echo "❌ Error al instalar dependencias"
    exit 1
fi

# Paso 4: Verificar que las librerías se importan correctamente
echo "📋 Paso 4: Verificando instalación..."

python3 -c "
import plotly.express as px
import pandas as pd
import numpy as np
import jupyter
print('✅ Todas las librerías importadas correctamente')
print(f'• Plotly: {px.__version__}')
print(f'• Pandas: {pd.__version__}')
print(f'• Numpy: {np.__version__}')
"

if [ $? -eq 0 ]; then
    echo "✅ Verificación exitosa"
else
    echo "❌ Error en la verificación"
    exit 1
fi

# Paso 5: Crear un notebook funcional con manejo de errores
echo "📋 Paso 5: Creando notebook con manejo de errores..."

cat > "marketing/dashboards/kpi_report.ipynb" << 'EOF'
{
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "# 📊 Dashboard KPI MechBot 2.0x\n",
        "\n",
        "Dashboard interactivo para monitorear los KPIs principales del proyecto MechBot.\n",
        "\n",
        "## 🔧 Verificación de dependencias\n",
        "\n",
        "Antes de ejecutar el dashboard, verificamos que todas las librerías estén instaladas."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 🔍 Verificar dependencias\n",
        "import sys\n",
        "import subprocess\n",
        "\n",
        "def install_if_missing(package):\n",
        "    try:\n",
        "        __import__(package)\n",
        "        print(f\"✅ {package} ya está instalado\")\n",
        "    except ImportError:\n",
        "        print(f\"⚠️  {package} no encontrado, instalando...\")\n",
        "        subprocess.check_call([sys.executable, \"-m\", \"pip\", \"install\", package])\n",
        "        print(f\"✅ {package} instalado correctamente\")\n",
        "\n",
        "# Lista de paquetes necesarios\n",
        "packages = ['plotly', 'pandas', 'numpy']\n",
        "\n",
        "for package in packages:\n",
        "    install_if_missing(package)\n",
        "\n",
        "print(\"\\n🚀 Todas las dependencias están listas!\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 🚀 Importar librerías\n",
        "try:\n",
        "    import plotly.express as px\n",
        "    import plotly.graph_objects as go\n",
        "    from datetime import datetime, timedelta\n",
        "    import pandas as pd\n",
        "    import numpy as np\n",
        "    \n",
        "    print(\"🚀 Iniciando Dashboard KPI MechBot 2.0x\")\n",
        "    print(\"=\" * 50)\n",
        "    print(\"✅ Todas las librerías importadas correctamente\")\n",
        "    \n",
        "except ImportError as e:\n",
        "    print(f\"❌ Error al importar librerías: {e}\")\n",
        "    print(\"💡 Ejecuta: pip install plotly pandas numpy\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📊 Función para generar datos de ejemplo\n",
        "def generar_datos_kpi():\n",
        "    \"\"\"Genera datos de ejemplo para el dashboard\"\"\"\n",
        "    try:\n",
        "        fechas = pd.date_range(start='2024-01-01', end='2024-12-31', freq='D')\n",
        "        \n",
        "        # Métricas de rendimiento con semilla para reproducibilidad\n",
        "        np.random.seed(42)\n",
        "        usuarios_activos = np.random.randint(100, 1000, len(fechas))\n",
        "        conversiones = np.random.randint(10, 100, len(fechas))\n",
        "        revenue = np.random.uniform(1000, 10000, len(fechas))\n",
        "        \n",
        "        return pd.DataFrame({\n",
        "            'fecha': fechas,\n",
        "            'usuarios_activos': usuarios_activos,\n",
        "            'conversiones': conversiones,\n",
        "            'revenue': revenue\n",
        "        })\n",
        "    except Exception as e:\n",
        "        print(f\"❌ Error al generar datos: {e}\")\n",
        "        return None\n",
        "\n",
        "# Generar datos\n",
        "df = generar_datos_kpi()\n",
        "\n",
        "if df is not None:\n",
        "    print(f\"📊 Datos generados: {len(df)} registros\")\n",
        "    print(\"\\n📋 Primeras 5 filas:\")\n",
        "    display(df.head())\n",
        "else:\n",
        "    print(\"❌ No se pudieron generar los datos\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📈 KPI 1: Usuarios Activos\n",
        "if df is not None:\n",
        "    try:\n",
        "        fig_usuarios = px.line(df, x='fecha', y='usuarios_activos', \n",
        "                               title='📈 Usuarios Activos Diarios',\n",
        "                               labels={'usuarios_activos': 'Usuarios', 'fecha': 'Fecha'})\n",
        "        fig_usuarios.update_layout(height=400)\n",
        "        fig_usuarios.show()\n",
        "        print(\"✅ Gráfico de usuarios activos generado\")\n",
        "    except Exception as e:\n",
        "        print(f\"❌ Error al crear gráfico de usuarios: {e}\")\n",
        "else:\n",
        "    print(\"⚠️  No hay datos para mostrar\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 🎯 KPI 2: Conversiones\n",
        "if df is not None:\n",
        "    try:\n",
        "        df_mensual = df.resample('M', on='fecha').sum().reset_index()\n",
        "        fig_conversiones = px.bar(df_mensual, \n",
        "                                  x='fecha', y='conversiones',\n",
        "                                  title='🎯 Conversiones Mensuales',\n",
        "                                  labels={'conversiones': 'Conversiones', 'fecha': 'Mes'})\n",
        "        fig_conversiones.update_layout(height=400)\n",
        "        fig_conversiones.show()\n",
        "        print(\"✅ Gráfico de conversiones generado\")\n",
        "    except Exception as e:\n",
        "        print(f\"❌ Error al crear gráfico de conversiones: {e}\")\n",
        "else:\n",
        "    print(\"⚠️  No hay datos para mostrar\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 💰 KPI 3: Revenue\n",
        "if df is not None:\n",
        "    try:\n",
        "        fig_revenue = px.area(df, x='fecha', y='revenue',\n",
        "                              title='💰 Revenue Acumulado',\n",
        "                              labels={'revenue': 'Revenue ($)', 'fecha': 'Fecha'})\n",
        "        fig_revenue.update_layout(height=400)\n",
        "        fig_revenue.show()\n",
        "        print(\"✅ Gráfico de revenue generado\")\n",
        "    except Exception as e:\n",
        "        print(f\"❌ Error al crear gráfico de revenue: {e}\")\n",
        "else:\n",
        "    print(\"⚠️  No hay datos para mostrar\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# 📋 Métricas resumen\n",
        "if df is not None:\n",
        "    try:\n",
        "        print(\"\\n📋 RESUMEN DE KPIs\")\n",
        "        print(\"=\" * 30)\n",
        "        print(f\"• Total Usuarios: {df['usuarios_activos'].sum():,}\")\n",
        "        print(f\"• Total Conversiones: {df['conversiones'].sum():,}\")\n",
        "        print(f\"• Revenue Total: ${df['revenue'].sum():,.2f}\")\n",
        "        print(f\"• Promedio Diario Usuarios: {df['usuarios_activos'].mean():.0f}\")\n",
        "        print(f\"• Tasa Conversión: {(df['conversiones'].sum() / df['usuarios_activos'].sum() * 100):.2f}%\")\n",
        "        \n",
        "        print(\"\\n✅ Dashboard completado exitosamente!\")\n",
        "        \n",
        "    except Exception as e:\n",
        "        print(f\"❌ Error al calcular métricas: {e}\")\n",
        "else:\n",
        "    print(\"⚠️  No hay datos para calcular métricas\")"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python 3 (ipykernel)",
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
      "version": "3.10.0"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
EOF

echo "✅ Notebook actualizado con manejo de errores"

# Paso 6: Guardar todos los cambios en Git
echo "📋 Paso 6: Guardando cambios en Git..."

# Verificar estado
echo "📊 Estado actual del repositorio:"
git status --porcelain

# Agregar archivos
git add marketing/dashboards/kpi_report.ipynb
git add marketing/dashboards/requirements.txt

# Verificar si hay cambios
if git diff --cached --quiet; then
    echo "ℹ️  No hay cambios nuevos para guardar"
else
    # Commit con mensaje descriptivo
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "🔧 Fix: Instala dependencias y corrige notebook KPI

- Actualiza requirements.txt con todas las dependencias necesarias
- Agrega manejo de errores en el notebook
- Instala plotly, pandas, numpy automáticamente
- Mejora la robustez del dashboard KPI

Timestamp: ${TIMESTAMP}"
    
    echo "✅ Cambios guardados localmente"
    
    # Intentar push
    if git remote get-url origin > /dev/null 2>&1; then
        echo "🌐 Subiendo cambios a GitHub..."
        if git push origin main; then
            echo "✅ Cambios subidos exitosamente a GitHub"
        else
            echo "⚠️  Error al subir a GitHub"
            echo "💡 Puedes subirlos manualmente después con:"
            echo "   git push origin main"
        fi
    else
        echo "ℹ️  No hay remote configurado"
    fi
fi

# Paso 7: Verificar que Jupyter pueda leer el notebook
echo "📋 Paso 7: Verificando que Jupyter pueda leer el notebook..."

if python3 -c "
import nbformat
try:
    with open('marketing/dashboards/kpi_report.ipynb', 'r') as f:
        nb = nbformat.read(f, as_version=4)
    print('✅ Notebook válido para Jupyter')
except Exception as e:
    print(f'❌ Error: {e}')
    exit(1)
"; then
    echo "✅ Verificación exitosa"
else
    echo "❌ Error en la verificación del notebook"
    exit 1
fi

# Resumen final
echo ""
echo "🎉 ¡PROCESO COMPLETADO EXITOSAMENTE!"
echo "===================================="
echo "• ✅ Dependencias instaladas: plotly, pandas, numpy"
echo "• ✅ Notebook corregido con manejo de errores"
echo "• ✅ requirements.txt actualizado"
echo "• ✅ Cambios guardados en Git"
echo "• ✅ Formato JSON válido"
echo ""
echo "🚀 AHORA PUEDES EJECUTAR:"
echo "jupyter notebook marketing/dashboards/kpi_report.ipynb"
echo ""
echo "📱 O acceder desde el navegador:"
echo "http://localhost:8888/notebooks/kpi_report.ipynb"
echo ""
echo "💡 El notebook ahora instalará automáticamente las dependencias"
echo "   que falten cuando ejecutes la primera celda."
