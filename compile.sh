#!/usr/bin/env bash
# Compile the CV in all three languages (English, Italian, German).
# Usage: ./compile.sh
set -euo pipefail

cd "$(dirname "$0")/cv"

if ! command -v pdflatex >/dev/null 2>&1; then
    echo "error: pdflatex not found. Install a LaTeX distribution first," >&2
    echo "       e.g.: brew install --cask mactex-no-gui" >&2
    exit 1
fi

files=(
    zuppichini_curriculum.tex
    zuppichini_curriculum_it.tex
    zuppichini_curriculum_de.tex
)

for f in "${files[@]}"; do
    echo "==> Compiling $f"
    # Two passes: first resolves labels, second fixes any cross-references.
    pdflatex -interaction=nonstopmode -halt-on-error "$f"
    pdflatex -interaction=nonstopmode -halt-on-error "$f"
done

echo
echo "Done. Generated in cv/:"
echo "  zuppichini_curriculum.pdf     (English)"
echo "  zuppichini_curriculum_it.pdf  (Italian)"
echo "  zuppichini_curriculum_de.pdf  (German)"
