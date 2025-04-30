#!/usr/bin/env python3
import yaml
from pathlib import Path

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
    yaml_file = Path("variables/globales.yaml")
    if not yaml_file.exists():
        print(f"Archivo no encontrado: {yaml_file}")
        exit(1)
    
    if not validate_yaml(yaml_file):
        exit(1)
