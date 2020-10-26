#!/bin/bash
set -e

source ${INSTALL_DIR}/conda/etc/profile.d/conda.sh
conda activate

# exec bash "$@"
exec "$@"

conda deactivate

