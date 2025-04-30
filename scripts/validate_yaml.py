#!/usr/bin/env python3
import yaml
from pathlib import Path

def validate_yaml_file(path):
    try:
        with open(path) as f:
            yaml.safe_load(f)
        print(f"✓ YAML válido: {path}")
        return True
    except Exception as e:
        print(f"❌ Error en {path}: {str(e)}")
        return False

def validate_all_yaml_files():
    # Check standard locations
    paths_to_check = [
        Path("variables/globales.yaml"),
        Path(".github/ISSUE_TEMPLATE/bug_report.yml"),
        Path(".github/workflows/")
    ]
    
    all_valid = True
    for path in paths_to_check:
        if path.is_dir():
            for yaml_file in path.glob("**/*.yaml") + path.glob("**/*.yml"):
                if not validate_yaml_file(yaml_file):
                    all_valid = False
        elif path.exists():
            if not validate_yaml_file(path):
                all_valid = False
        else:
            print(f"⚠️ Archivo no encontrado: {path}")
    
    return all_valid

if __name__ == "__main__":
    if not validate_all_yaml_files():
        exit(1)
