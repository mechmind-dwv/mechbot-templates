#!/usr/bin/env python3
import yaml
import sys
import os
from pathlib import Path

def validate_yaml_file(file_path):
    """Valida un archivo YAML"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            yaml.safe_load(f)
        print(f"✅ {file_path} - Válido")
        return True
    except yaml.YAMLError as e:
        print(f"❌ {file_path} - Error: {e}")
        return False

def main():
    """Valida todos los archivos YAML del proyecto"""
    yaml_files = [
        ".github/workflows/CI.yml",
        "docker/docker-compose.yml"
    ]
    
    all_valid = True
    for file_path in yaml_files:
        if os.path.exists(file_path):
            if not validate_yaml_file(file_path):
                all_valid = False
        else:
            print(f"⚠️ {file_path} - No encontrado")
    
    if not all_valid:
        sys.exit(1)
    
    print("🎉 Todos los archivos YAML son válidos")

if __name__ == "__main__":
    main()
