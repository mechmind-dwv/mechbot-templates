Primeros Pasos
Requisitos
Git 2.30+
Python 3.8+ (para scripts de automatización)
Librerías: Jinja2, PyYAML
Instalación
git clone https://github.com/mechmind-dwv/mechbot-templates.git
cd mechbot-templates
pip install -r herramientas/requirements.txt
Uso Básico
Edita las variables en variables/globales.yaml
Genera plantillas:
python herramientas/generador.py -t comunicacion/onboarding
