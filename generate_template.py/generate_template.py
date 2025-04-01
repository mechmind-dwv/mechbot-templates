## Script de Automatización
```python
# generate_template.py
from jinja2 import Environment, FileSystemLoader
import yaml

env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('emails/onboarding.md')

with open('variables_globales.yaml') as f:
    variables = yaml.safe_load(f)

output = template.render(
    nombre="[CLIENTE]",
    **variables
)

with open('output/onboarding_personalizado.md', 'w') as f:
    f.write(output)
```
