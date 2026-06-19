#!/usr/bin/env python3
"""
MechBot Template Generator.
Usage:
  python herramientas/generador.py -t <template_dir>   # single directory
  python herramientas/generador.py -t all               # all known template dirs
"""
import argparse
import os
import sys
from pathlib import Path
import yaml
from jinja2 import Environment, FileSystemLoader

TEMPLATE_DIRS = ["comunicacion", "marketing", "tecnica", "reportes"]

def load_variables() -> dict:
    """Load variables from the global YAML configuration."""
    var_files = [
        "variables/variables_globales.yaml",
        "variables/globales.yaml",
        "variables/global_vars.yaml",
    ]
    for vf in var_files:
        if Path(vf).exists():
            with open(vf, "r") as f:
                data = yaml.safe_load(f)
                if data:
                    return data
    return {}

def render_templates(template_dir: str, variables: dict):
    """Render all Jinja2 templates in a directory."""
    env = Environment(loader=FileSystemLoader(template_dir))
    output_base = Path("salida") / Path(template_dir).name
    output_base.mkdir(parents=True, exist_ok=True)

    for root, _, files in os.walk(template_dir):
        for file in files:
            if file.endswith((".j2", ".jinja", ".jinja2", ".template")):
                filepath = Path(root) / file
                rel_path = filepath.relative_to(template_dir)
                out_name = filepath.stem  # removes the template extension
                out_path = output_base / rel_path.parent / out_name
                out_path.parent.mkdir(parents=True, exist_ok=True)
                try:
                    template = env.get_template(str(rel_path.as_posix()))
                    rendered = template.render(**variables)
                    out_path.write_text(rendered)
                    print(f"✓ Generated {out_path}")
                except Exception as e:
                    print(f"✗ Error in {filepath}: {e}", file=sys.stderr)
    print(f"Finished {template_dir}.")

def main():
    parser = argparse.ArgumentParser(description="MechBot Template Generator")
    parser.add_argument("-t", "--template", required=True, help="Template directory or 'all'")
    args = parser.parse_args()

    target = args.template
    if target == "all":
        dirs = [d for d in TEMPLATE_DIRS if Path(d).is_dir()]
        if not dirs:
            print("Error: no template directories found.", file=sys.stderr)
            sys.exit(1)
    else:
        if not Path(target).is_dir():
            print(f"Error: directory '{target}' not found.", file=sys.stderr)
            sys.exit(1)
        dirs = [target]

    variables = load_variables()
    if not variables:
        print("Warning: no variables loaded. Templates may be rendered empty.", file=sys.stderr)

    for d in dirs:
        print(f"Processing {d}...")
        render_templates(d, variables)

if __name__ == "__main__":
    main()
