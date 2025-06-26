 /usr/bin/env python3
import yaml
from pathlib import Path
from itertools import chain


def validate_yaml():
    # Buscar en posibles ubicaciones
    possible_paths = chain(Path(".").glob("**/*.yaml"), Path(".").glob("**/*.yml"))

    all_valid = True
    for path in possible_paths:
        try:
            with open(path) as f:
                yaml.safe_load(f)
            print(f"✓ YAML válido: {path}")
        except Exception as e:
            print(f"❌ Error en {path}: {str(e)}")
            all_valid = False

    return all_valid


if __name__ == "__main__":
    exit(0 if validate_yaml() else 1)