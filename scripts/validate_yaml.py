#!/usr/bin/env python3Add commentMore actions
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
def validate_yaml(path):
    try:
        with open(path) as f:
            yaml.safe_load(f)
        print(f"✓ {path} es válido")
        return True
    except Exception as e:
        print(f"❌ Error en {path}: {str(e)}")
        return False

if __name__ == "__main__":
    validate_yaml_files()
    yaml_file = Path("variables/globales.yaml")
    if not yaml_file.exists():
        print(f"Archivo no encontrado: {yaml_file}")
        exit(1)
    
    if not validate_yaml(yaml_file):
        exit(1)
