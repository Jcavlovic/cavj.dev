# Custom CloudNativePG image with the wal2json logical decoding output plugin.
#
# wal2json is NOT bundled in the standard cloudnative-pg/postgresql images.
# Image volume extensions (spec.postgresql.extensions) would be preferable,
# but they require PostgreSQL 18+ and Kubernetes 1.33 with the ImageVolume
# feature gate -- not available on EKS with PG 17.

ARG PG_MAJOR=17
ARG BASE_TAG=17.5

FROM ghcr.io/cloudnative-pg/postgresql:${BASE_TAG}

ARG PG_MAJOR

# The base image runs as non-root; switch to root to install packages.
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         postgresql-${PG_MAJOR}-wal2json \
    && rm -rf /var/lib/apt/lists/*

# Back to the postgres user CNPG expects.
USER 26
