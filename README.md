# 🛠️ Repositorio de Plantillas MechBot 2.0x

![Estado](https://img.shields.io/badge/Estado-Producción-brightgreen)
![Último commit](https://img.shields.io/github/last-commit/mechmind-dwv/mechbot-templates)

Repositorio centralizado de plantillas para el proyecto MechBot 2.0x. Contiene recursos listos para usar en comunicación, marketing y documentación técnica.

## 📌 Características Principales

- ✅ Plantillas estandarizadas por área
- ✅ Variables personalizables mediante archivos YAML
- ✅ Generación automática por CLI y CI/CD
- ✅ Workflows de validación, seguridad y despliegue
- ✅ Logging profesional en el generador

## 🗂 Estructura del Repositorio

```

mechbot-templates/
├── comunicacion/          # Emails, presentaciones, guiones
├── marketing/            # Redes sociales, anuncios
├── tecnica/              # Documentación API, manuales
├── datos/                # Archivos de datos auxiliares
├── herramientas/         # Scripts de automatización
│   ├── generador.py      # Motor de renderizado Jinja2
│   └── requirements.txt  # Dependencias Python
├── variables/            # Configuración global
│   ├── global_vars.yaml  # Marca, contactos, URLs
│   ├── globales.yaml     # Parámetros de entorno
│   └── variables_globales.yaml
├── backend/              # Aplicación Django (admin, monitoreo)
├── deploy/               # Scripts y templates para producción
├── .github/workflows/    # CI/CD pipelines
└── README.md

```

## 🚀 Primeros Pasos

### Requisitos
- Git 2.30+
- Python 3.8+
- Dependencias: `pip install -r herramientas/requirements.txt`

### Instalación y uso básico
```bash
git clone git@github.com:mechmind-dwv/mechbot-templates.git
cd mechbot-templates
pip install -r herramientas/requirements.txt

# Generar todas las plantillas
python herramientas/generador.py -t all

# Generar solo las de onboarding de comunicación
python herramientas/generador.py -t comunicacion/onboarding
```

Las variables se cargan automáticamente desde variables/global_vars.yaml (el archivo principal). El resultado aparece en la carpeta salida/.

🧩 Ejemplos Prácticos

Generar un email de bienvenida

```bash
python herramientas/generador.py -t comunicacion/onboarding
cat salida/onboarding/bienvenida.html
```

Usar Jinja2 directamente (avanzado)

```python
from jinja2 import Template
import yaml

with open('marketing/post_linkedin.j2') as f:
    template = Template(f.read())

with open('variables/global_vars.yaml') as f:
    context = yaml.safe_load(f)

print(template.render(**context))
```

⚙️ Configuración CI/CD (GitHub Actions)

El repositorio incluye workflows avanzados listos para producción:

Workflow Propósito
generate-on-schedule.yml Generación programada (lunes a viernes 9 AM)
generate-templates.yml Generación en cada push
validate-templates.yml Validación YAML + Jinja2 en PRs
notify.yml / slack-notification.yml Notificaciones al finalizar generación
deploy.yml Despliegue continuo con Docker
codeql.yml Análisis de seguridad

Los artefactos generados se almacenan en GitHub Artifacts o, opcionalmente, se sincronizan con AWS S3.

🔄 Metodología de Versionado

Usamos SemVer:

· MAYOR: Cambios incompatibles en variables o estructura
· MENOR: Nuevas plantillas o funcionalidades
· PATCH: Correcciones de estilo o bugs

```bash
git tag -a v1.2.0 -m "Agrega plantillas para webinars"
git push origin --tags
```

La configuración está en .versionrc (compatible con standard-version).

🚨 Troubleshooting

Problema Solución
Las variables no se renderizan Verificar que variables/global_vars.yaml tenga formato YAML válido (yamllint variables/global_vars.yaml)
Error "directory not found" en el generador Confirmar que el nombre de la carpeta coincide (usa -t comunicacion, no -t comunicacion/ si no existe el subdirectorio)
Permisos denegados en scripts chmod +x herramientas/generador.py deploy/scripts/*.sh
El servidor Django no arranca Asegurar que ALLOWED_HOSTS incluya 0.0.0.0 y aplicar migraciones (python manage.py migrate)

🚢 Despliegue (Producción)

Cuando tengas Docker disponible, el despliegue se realiza con:

```bash
./deploy/scripts/deploy.sh production
./deploy/scripts/rollback.sh v1.1.0   # en caso necesario
```

Las variables de entorno están en deploy/configs/env.template. Nunca subas secretos reales al repositorio; usa GitHub Secrets o Vault.

🤝 Cómo Contribuir

1. Haz fork del repositorio
2. Crea una rama (git checkout -b mejora/descripcion)
3. Realiza tus cambios y commitea (git commit -m 'Añade X plantilla')
4. Push a tu rama (git push origin mejora/descripcion)
5. Abre un Pull Request

📝 Licencia

MIT License. Consulta el archivo LICENSE.

---

📬 Contacto

Equipo de Ingeniería MechBot
📧 ia.mechmind@gmail.com
🔗 Sitio Oficial
