#!/bin/bash
#set -xv

# shellcheck disable=SC1091
source /opt/ansible/env36/bin/activate

#sphinx-quickstart
sphinx-build -b html ./ _build/
# or make html

exit 0
