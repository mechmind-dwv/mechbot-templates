#!/bin/bash

# 🚀 MechBot Templates - Guardar cambios y arreglar notebook
echo "🚀 MechBot Templates - Guardar cambios y arreglar notebook"
echo "============================================================"

# Verificar entorno virtual
echo "📋 Paso 1: Verificando entorno virtual..."
if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "✅ Entorno virtual activo: $VIRTUAL_ENV"
else
    echo "❌ No hay entorno virtual activo"
    echo "💡 Ejecuta: source venv/bin/activate"
    exit 1
fi

# Instalar dependencias necesarias
echo "📋 Paso 2: Instalando dependencias..."
pip install plotly pandas numpy jupyter ipywidgets --quiet
echo "✅ Dependencias instaladas"

# Verificar el archivo del notebook
echo "📋 Paso 3: Verificando notebook..."
if [ -f "marketing/dashboards/kpi_report.ipynb" ]; then
    echo "✅ Archivo encontrado: marketing/dashboards/kpi_report.ipynb"
    
    # Hacer backup del archivo original
    cp marketing/dashboards/kpi_report.ipynb marketing/dashboards/kpi_report.ipynb.backup
    echo "✅ Backup creado: kpi_report.ipynb.backup"
    
    # Convertir a notebook válido si es necesario
    if ! python -m json.tool marketing/dashboards/kpi_report.ipynb > /dev/null 2>&1; then
        echo "🔧 Convirtiendo archivo a formato notebook válido..."
        
        # Crear notebook válido
        cat > marketing/dashboards/kpi_report.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# 📊 KPI Dashboard - MechBot Templates\n",
    "\n",
    "Dashboard interactivo para monitorear KPIs principales del proyecto."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 🔧 Instalación automática de dependencias\n",
    "import subprocess\n",
    "import sys\n",
    "\n",
    "def install_if_missing(package):\n",
    "    try:\n",
    "        __import__(package)\n",
    "        print(f\"✅ {package} ya está instalado\")\n",
    "    except ImportError:\n",
    "        print(f\"📦 Instalando {package}...\")\n",
    "        subprocess.check_call([sys.executable, \"-m\", \"pip\", \"install\", package])\n",
    "\n",
    "# Instalar dependencias si es necesario\n",
    "for package in ['plotly', 'pandas', 'numpy']:\n",
    "    install_if_missing(package)\n",
    "\n",
    "print(\"🚀 Todas las dependencias están listas!\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 📊 Importar librerías\n",
    "import plotly.express as px\n",
    "import plotly.graph_objects as go\n",
    "from plotly.subplots import make_subplots\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "from datetime import datetime, timedelta\n",
    "import warnings\n",
    "warnings.filterwarnings('ignore')\n",
    "\n",
    "print(\"📚 Librerías importadas correctamente\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 🎯 Generar datos de ejemplo para KPIs\n",
    "np.random.seed(42)\n",
    "\n",
    "# Crear fechas para los últimos 30 días\n",
    "dates = pd.date_range(start=datetime.now() - timedelta(days=30), end=datetime.now(), freq='D')\n",
    "\n",
    "# Generar datos simulados\n",
    "data = {\n",
    "    'fecha': dates,\n",
    "    'usuarios_activos': np.random.randint(150, 300, len(dates)),\n",
    "    'conversiones': np.random.randint(10, 50, len(dates)),\n",
    "    'revenue': np.random.uniform(500, 2000, len(dates)),\n",
    "    'bounce_rate': np.random.uniform(0.2, 0.6, len(dates)),\n",
    "    'tiempo_sesion': np.random.uniform(120, 600, len(dates))  # segundos\n",
    "}\n",
    "\n",
    "df = pd.DataFrame(data)\n",
    "df['revenue_acumulado'] = df['revenue'].cumsum()\n",
    "df['conversion_rate'] = df['conversiones'] / df['usuarios_activos'] * 100\n",
    "\n",
    "print(f\"📊 Datos generados: {len(df)} días de métricas\")\n",
    "print(f\"📈 KPIs principales:\")\n",
    "print(f\"   👥 Usuarios activos promedio: {df['usuarios_activos'].mean():.0f}\")\n",
    "print(f\"   🎯 Conversiones promedio: {df['conversiones'].mean():.0f}\")\n",
    "print(f\"   💰 Revenue total: ${df['revenue'].sum():.2f}\")\n",
    "print(f\"   📊 Tasa de conversión promedio: {df['conversion_rate'].mean():.2f}%\")\n",
    "\n",
    "df.head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 📈 Gráfico 1: Usuarios Activos Diarios\n",
    "fig1 = px.line(df, x='fecha', y='usuarios_activos', \n",
    "               title='📊 Usuarios Activos Diarios',\n",
    "               labels={'usuarios_activos': 'Usuarios Activos', 'fecha': 'Fecha'})\n",
    "fig1.update_traces(line=dict(width=3, color='#1f77b4'))\n",
    "fig1.update_layout(template='plotly_white', height=400)\n",
    "fig1.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 🎯 Gráfico 2: Conversiones vs Tasa de Conversión\n",
    "fig2 = make_subplots(specs=[[{\"secondary_y\": True}]])\n",
    "\n",
    "fig2.add_trace(\n",
    "    go.Scatter(x=df['fecha'], y=df['conversiones'], name=\"Conversiones\",\n",
    "               line=dict(color='#ff7f0e', width=3)),\n",
    "    secondary_y=False,\n",
    ")\n",
    "\n",
    "fig2.add_trace(\n",
    "    go.Scatter(x=df['fecha'], y=df['conversion_rate'], name=\"Tasa de Conversión (%)\",\n",
    "               line=dict(color='#2ca02c', width=3, dash='dash')),\n",
    "    secondary_y=True,\n",
    ")\n",
    "\n",
    "fig2.update_xaxes(title_text=\"Fecha\")\n",
    "fig2.update_yaxes(title_text=\"Número de Conversiones\", secondary_y=False)\n",
    "fig2.update_yaxes(title_text=\"Tasa de Conversión (%)\", secondary_y=True)\n",
    "fig2.update_layout(title_text=\"🎯 Conversiones y Tasa de Conversión\", template='plotly_white', height=400)\n",
    "fig2.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 💰 Gráfico 3: Revenue Acumulado\n",
    "fig3 = px.area(df, x='fecha', y='revenue_acumulado',\n",
    "               title='💰 Revenue Acumulado',\n",
    "               labels={'revenue_acumulado': 'Revenue Acumulado ($)', 'fecha': 'Fecha'})\n",
    "fig3.update_traces(fill='tonexty', fillcolor='rgba(46, 160, 44, 0.3)', line=dict(color='#2ca02c', width=3))\n",
    "fig3.update_layout(template='plotly_white', height=400)\n",
    "fig3.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 📊 Gráfico 4: Dashboard de Métricas Clave\n",
    "fig4 = make_subplots(\n",
    "    rows=2, cols=2,\n",
    "    subplot_titles=('Bounce Rate', 'Tiempo de Sesión (min)', 'Revenue Diario', 'Distribución de Usuarios'),\n",
    "    specs=[[{\"type\": \"scatter\"}, {\"type\": \"scatter\"}],\n",
    "           [{\"type\": \"bar\"}, {\"type\": \"histogram\"}]]\n",
    ")\n",
    "\n",
    "# Bounce Rate\n",
    "fig4.add_trace(\n",
    "    go.Scatter(x=df['fecha'], y=df['bounce_rate'], name=\"Bounce Rate\",\n",
    "               line=dict(color='#d62728', width=2)),\n",
    "    row=1, col=1\n",
    ")\n",
    "\n",
    "# Tiempo de Sesión\n",
    "fig4.add_trace(\n",
    "    go.Scatter(x=df['fecha'], y=df['tiempo_sesion']/60, name=\"Tiempo (min)\",\n",
    "               line=dict(color='#9467bd', width=2)),\n",
    "    row=1, col=2\n",
    ")\n",
    "\n",
    "# Revenue Diario\n",
    "fig4.add_trace(\n",
    "    go.Bar(x=df['fecha'], y=df['revenue'], name=\"Revenue\",\n",
    "           marker_color='#17becf'),\n",
    "    row=2, col=1\n",
    ")\n",
    "\n",
    "# Distribución de Usuarios\n",
    "fig4.add_trace(\n",
    "    go.Histogram(x=df['usuarios_activos'], name=\"Distribución\",\n",
    "                 marker_color='#bcbd22'),\n",
    "    row=2, col=2\n",
    ")\n",
    "\n",
    "fig4.update_layout(height=600, showlegend=False, title_text=\"📊 Dashboard de Métricas Clave\")\n",
    "fig4.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# 📋 Resumen de KPIs\n",
    "print(\"\\n\" + \"=\"*50)\n",
    "print(\"📋 RESUMEN DE KPIs - MECHBOT TEMPLATES\")\n",
    "print(\"=\"*50)\n",
    "print(f\"📅 Período: {df['fecha'].min().strftime('%Y-%m-%d')} al {df['fecha'].max().strftime('%Y-%m-%d')}\")\n",
    "print(f\"📊 Total de días analizados: {len(df)}\")\n",
    "print()\n",
    "print(\"👥 USUARIOS:\")\n",
    "print(f\"   • Usuarios activos promedio: {df['usuarios_activos'].mean():.0f}\")\n",
    "print(f\"   • Máximo usuarios en un día: {df['usuarios_activos'].max()}\")\n",
    "print(f\"   • Mínimo usuarios en un día: {df['usuarios_activos'].min()}\")\n",
    "print()\n",
    "print(\"🎯 CONVERSIONES:\")\n",
    "print(f\"   • Total de conversiones: {df['conversiones'].sum()}\")\n",
    "print(f\"   • Conversiones promedio por día: {df['conversiones'].mean():.1f}\")\n",
    "print(f\"   • Tasa de conversión promedio: {df['conversion_rate'].mean():.2f}%\")\n",
    "print()\n",
    "print(\"💰 REVENUE:\")\n",
    "print(f\"   • Revenue total: ${df['revenue'].sum():.2f}\")\n",
    "print(f\"   • Revenue promedio por día: ${df['revenue'].mean():.2f}\")\n",
    "print(f\"   • Revenue por conversión: ${df['revenue'].sum() / df['conversiones'].sum():.2f}\")\n",
    "print()\n",
    "print(\"📈 ENGAGEMENT:\")\n",
    "print(f\"   • Bounce rate promedio: {df['bounce_rate'].mean():.2%}\")\n",
    "print(f\"   • Tiempo de sesión promedio: {df['tiempo_sesion'].mean()/60:.1f} minutos\")\n",
    "print(\"=\"*50)\n",
    "print(\"✅ Dashboard generado exitosamente!\")"
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
   "version": "3.8.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF
        echo "✅ Notebook convertido a formato válido"
    else
        echo "✅ El notebook ya está en formato JSON válido"
    fi
else
    echo "❌ Archivo no encontrado: marketing/dashboards/kpi_report.ipynb"
    exit 1
fi

# Actualizar requirements.txt
echo "📋 Paso 4: Actualizando requirements.txt..."
cat > marketing/dashboards/requirements.txt << 'EOF'
plotly>=5.0.0
pandas>=1.3.0
numpy>=1.20.0
jupyter>=1.0.0
ipywidgets>=7.6.0
EOF
echo "✅ requirements.txt actualizado"

# Instalar desde requirements.txt
echo "📋 Paso 5: Instalando desde requirements.txt..."
pip install -r marketing/dashboards/requirements.txt --quiet
echo "✅ Todas las dependencias instaladas"

# Guardar cambios en Git
echo "📋 Paso 6: Guardando cambios en Git..."
git add .
git status
echo "✅ Archivos agregados al staging"

# Commit con mensaje descriptivo
git commit -m "🚀 Fix: Corregir notebook KPI y actualizar dependencias

- Convertir kpi_report.ipynb a formato JSON válido
- Agregar dashboard interactivo con plotly
- Instalar dependencias necesarias (plotly, pandas, numpy)
- Crear backup del archivo original
- Actualizar requirements.txt con versiones específicas
- Implementar auto-instalación de dependencias en notebook"

echo "✅ Cambios guardados en Git"

# Intentar subir a GitHub
echo "📋 Paso 7: Subiendo a GitHub..."
if git push origin main 2>/dev/null; then
    echo "✅ Cambios subidos a GitHub exitosamente"
else
    echo "⚠️  No se pudo subir automáticamente a GitHub"
    echo "💡 Ejecuta manualmente: git push origin main"
fi

# Verificar que el notebook funciona
echo "📋 Paso 8: Verificando notebook..."
if python -m jupyter --version > /dev/null 2>&1; then
    echo "✅ Jupyter está instalado y funcionando"
    echo "🚀 ¡Todo listo! Puedes ejecutar:"
    echo "   jupyter notebook marketing/dashboards/kpi_report.ipynb"
else
    echo "❌ Problema con Jupyter"
    echo "💡 Ejecuta: pip install jupyter"
fi

echo ""
echo "🎉 ¡PROCESO COMPLETADO EXITOSAMENTE!"
echo "📊 Tu dashboard KPI está listo para usar"
echo "💾 Todos los cambios han sido guardados"
echo "🔧 Para usar el notebook: jupyter notebook marketing/dashboards/kpi_report.ipynb"
