#!/usr/bin/env bash
set -euo pipefail

REGION="${REGION:-us-west-1}"
REPO="${REPO:-cnpg-postgresql-wal2json}"
PG_MAJOR="${PG_MAJOR:-17}"
BASE_TAG="${BASE_TAG:-17.5}"
TAG="${TAG:-${BASE_TAG}-wal2json}"

ACCOUNT="$(aws sts get-caller-identity --query Account --output text)"
REGISTRY="${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com"
IMAGE="${REGISTRY}/${REPO}:${TAG}"

aws ecr describe-repositories --repository-names "${REPO}" --region "${REGION}" >/dev/null 2>&1 \
  || aws ecr create-repository --repository-name "${REPO}" --region "${REGION}"

aws ecr get-login-password --region "${REGION}" \
  | docker login --username AWS --password-stdin "${REGISTRY}"

# CNPG nodes are linux/amd64 unless you run Graviton -- set PLATFORM=linux/arm64 if so.
docker buildx build \
  --platform "${PLATFORM:-linux/amd64}" \
  --build-arg "PG_MAJOR=${PG_MAJOR}" \
  --build-arg "BASE_TAG=${BASE_TAG}" \
  -t "${IMAGE}" \
  --push .

echo
echo "Pushed: ${IMAGE}"
echo
echo "Now point the cluster at it:"
echo "  kubectl -n postgres patch cluster pg --type=merge -p '{\"spec\":{\"imageName\":\"${IMAGE}\"}}'"
