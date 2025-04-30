import yaml
import os
from pathlib import Path

def validate_yaml_files():
    yaml_dir = Path("variables")
    errors = []
    
    for yaml_file in yaml_dir.glob("*.yaml"):
        try:
            with open(yaml_file) as f:
                yaml.safe_load(f)
            print(f"✓ {yaml_file} es válido")
        except Exception as e:
            errors.append(f"❌ Error en {yaml_file}: {str(e)}")
    
    if errors:
        raise ValueError("\n".join(errors))

if __name__ == "__main__":
    validate_yaml_files()
