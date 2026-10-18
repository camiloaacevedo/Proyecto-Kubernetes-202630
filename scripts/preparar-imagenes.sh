#!/usr/bin/env bash
set -euo pipefail
RAIZ="$(cd "$(dirname "$0")/.." && pwd)"

echo "Apuntando Docker al demonio de Minikube..."
eval "$(minikube -p minikube docker-env)"

for lenguaje in python java c; do
  tag="kubernates-202630-${lenguaje}:1.0"
  echo "Construyendo ${tag}..."
  docker build -t "${tag}" "${RAIZ}/imagenes/${lenguaje}"
done

echo
echo "Imagenes disponibles dentro de Minikube:"
docker images --filter 'reference=kubernates-202630-*' \
  --format '  {{.Repository}}:{{.Tag}}  {{.ID}}  {{.CreatedSince}}'
