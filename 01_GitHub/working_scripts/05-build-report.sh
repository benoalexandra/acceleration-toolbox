#!/bin/bash
set -euo pipefail

RESULTS_DIR=$1
MULTIQC_CONFIG=$2

echo "Generating MultiQC report"

multiqc "$RESULTS_DIR" -c "$MULTIQC_CONFIG" -o "$RESULTS_DIR"/multiqc_report

# check if multiqc_report directory was generated, and exit code 1 if not
if [ ! -d "$RESULTS_DIR/multiqc_report" ]; then
    echo "Error: MultiQC report was not generated at $RESULTS_DIR/multiqc_report."
    exit 1
fi

echo "Report assets copied"
