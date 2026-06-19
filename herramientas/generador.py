#!/usr/bin/env python3
"""
MechBot Template Generator.
Usage:
  python herramientas/generador.py -t <template_dir>   # single directory
  python herramientas/generador.py -t all               # all known template dirs
"""
import argparse
import logging
import os
import sys
from pathlib import Path
import yaml
from jinja2 import Environment, FileSystemLoader

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler("generator.log", mode='a', encoding='utf-8')
    ]
)
logger = logging.getLogger("MechBotGenerator")

TEMPLATE_DIRS = ["comunicacion", "marketing", "tecnica", "reportes"]

def load_variables() -> dict:
    """
    Load variables from the first valid YAML mapping found.
    Returns a dict (possibly empty) with the variables.
    """
    var_files = [
        "variables/variables_globales.yaml",
        "variables/globales.yaml",
        "variables/global_vars.yaml",
    ]
    for vf in var_files:
        if Path(vf).exists():
            try:
                with open(vf, "r") as f:
                    data = yaml.safe_load(f)
                    if isinstance(data, dict):
                        logger.info(f"Loaded variables from {vf}")
                        return data
                    else:
                        logger.warning(f"File {vf} does not contain a mapping (dict), skipping.")
            except Exception as e:
                logger.error(f"Error reading {vf}: {e}")
    logger.warning("No valid variable file found; templates will be rendered with empty context.")
    return {}

def render_templates(template_dir: str, variables: dict):
    """Render all Jinja2 templates in a directory."""
    logger.info(f"Processing directory: {template_dir}")
    env = Environment(loader=FileSystemLoader(template_dir))
    output_base = Path("salida") / Path(template_dir).name
    output_base.mkdir(parents=True, exist_ok=True)

    for root, _, files in os.walk(template_dir):
        for file in files:
            if file.endswith((".j2", ".jinja", ".jinja2", ".template")):
                filepath = Path(root) / file
                rel_path = filepath.relative_to(template_dir)
                out_name = filepath.stem  # removes template extension
                out_path = output_base / rel_path.parent / out_name
                out_path.parent.mkdir(parents=True, exist_ok=True)
                try:
                    template = env.get_template(str(rel_path.as_posix()))
                    rendered = template.render(**variables)
                    out_path.write_text(rendered)
                    logger.info(f"Generated: {out_path}")
                except Exception as e:
                    logger.error(f"Error rendering {filepath}: {e}")

    logger.info(f"Finished processing {template_dir}.")

def main():
    parser = argparse.ArgumentParser(description="MechBot Template Generator")
    parser.add_argument("-t", "--template", required=True, help="Template directory or 'all'")
    args = parser.parse_args()

    target = args.template
    if target == "all":
        dirs = [d for d in TEMPLATE_DIRS if Path(d).is_dir()]
        if not dirs:
            logger.error("No template directories found.")
            sys.exit(1)
    else:
        if not Path(target).is_dir():
            logger.error(f"Directory '{target}' not found.")
            sys.exit(1)
        dirs = [target]

    variables = load_variables()
    for d in dirs:
        render_templates(d, variables)

if __name__ == "__main__":
    main()
