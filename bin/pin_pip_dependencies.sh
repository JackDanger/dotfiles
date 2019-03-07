#!/bin/bash

set -euo pipefail
set -x

start_line=$(grep 'install_requires=\[' setup.py -n | cut -d : -f 1)
head -n ${start_line} setup.py > setup.py.tmp && mv setup.py.tmp setup.py
pip freeze | grep -v '-e git' | gsed 's/\(.\+\)/        "\1",/g' >> setup.py
echo "    ]," >> setup.py
echo ")" >> setup.py
