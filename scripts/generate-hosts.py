#!/usr/bin/env python3

import argparse
import json
import yaml
from pathlib import Path
import sys

def main():
    parser = argparse.ArgumentParser(
        description="Generate Ansible hosts from Terraform outputs"
    )
    parser.add_argument(
        "--env",
        required=True,
        help="Environment name (dev, prod, staging, etc.)"
    )

    args = parser.parse_args()
    env = args.env

    input_file = Path(f"../infrastructure/envs/{env}/outputs.json")
    output_file = Path(f"../ansible/inventories/{env}/hosts.yml")

    if not input_file.exists():
        print(f" Terraform output file not found: {input_file}")
        sys.exit(1)

    with input_file.open() as f:
        tf_outputs = json.load(f)

    try:
        bastion_ip = tf_outputs["bastion_server"]["value"]
        api_ips = tf_outputs["api_servers"]["value"]
        db_ip = tf_outputs["db_server"]["value"]
    except KeyError as e:
        print(f" Missing required Terraform output: {e}")
        sys.exit(1)

    hosts = {
        "all": {
            "vars": {
                "bastion_ip": bastion_ip
            },
            "children": {
                "api": {
                    "hosts": {
                        f"{env}-api-{i}": {
                            "ansible_host": ip
                        }
                        for i, ip in enumerate(api_ips)
                    }
                },
                "db": {
                    "hosts": {
                        f"{env}-db-0": {
                            "ansible_host": db_ip
                        }
                    }
                }
            }
            
        }
    }

    output_file.parent.mkdir(parents=True, exist_ok=True)

    with output_file.open("w") as f:
        yaml.dump(hosts, f, default_flow_style=False, sort_keys=False)

    print(f" hosts.yml generated for '{env}' at: {output_file}")

if __name__ == "__main__":
    main()
