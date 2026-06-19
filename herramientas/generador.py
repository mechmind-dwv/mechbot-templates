#!/usr/bin/env python3
"""
MechBot Template Generator
Usage: python herramientas/generador.py -t <template_dir>
"""
import argparse
import os
import sys
from pathlib import Path

import yaml
from jinja2 import Environment, FileSystemLoader


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
                return yaml.safe_load(f) or {}
    # Fallback empty dict if no variable file found
    return {}


def render_templates(template_dir: str, variables: dict):
    """Render all templates in the given directory using Jinja2."""
    env = Environment(loader=FileSystemLoader(template_dir))
    output_base = Path("salida") / Path(template_dir).name
    output_base.mkdir(parents=True, exist_ok=True)

    for root, _, files in os.walk(template_dir):
        for file in files:
            if file.endswith((".j2", ".jinja", ".jinja2", ".template")):
                filepath = Path(root) / file
                rel_path = filepath.relative_to(template_dir)
                # Remove template extension for output file
                out_name = filepath.stem if filepath.suffix in {".j2", ".jinja", ".jinja2", ".template"} else filepath.name
                out_path = output_base / rel_path.parent / out_name
                out_path.parent.mkdir(parents=True, exist_ok=True)

                try:
                    template = env.get_template(str(rel_path.as_posix()))
                    rendered = template.render(**variables)
                    with open(out_path, "w") as f:
                        f.write(rendered)
                    print(f"✓ Generated {out_path}")
                except Exception as e:
                    print(f"✗ Error in {filepath}: {e}", file=sys.stderr)

    print("Generation complete.")


def main():
    parser = argparse.ArgumentParser(description="MechBot Template Generator")
    parser.add_argument("-t", "--template", required=True, help="Template directory to render")
    args = parser.parse_args()

    template_dir = args.template
    if not Path(template_dir).is_dir():
        print(f"Error: directory '{template_dir}' not found.", file=sys.stderr)
        sys.exit(1)

    variables = load_variables()
    if not variables:
        print("Warning: no variables loaded. Templates may be rendered empty.", file=sys.stderr)

    render_templates(template_dir, variables)


if __name__ == "__main__":
    main()
