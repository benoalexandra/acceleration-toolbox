#!/bin/bash
set -euo pipefail

RESULTS_DIR=$1
N_FILES=12

echo "Counting matches into summary matrix"

# GROUP 4 - WRITE HERE THE COMMAND TO RUN THE PYTHON SCRIPT THAT BUILDS THE SUMMARY MATRIX
# THE PYTHON SCRIPT TAKES THE RESULTS DIRECTORY AS A PARAMETER
python 01_GitHub/scripts/build_matrix.py "$RESULTS_DIR"

# check if the matrix file was created successfully
if [ ! -f "$RESULTS_DIR/matches_summary.csv" ]; then
    echo "Error: matches_summary.csv was not created in $RESULTS_DIR."
    exit 1
fi

echo "Matches matrix built"
