# Stage 1: Security Audit / Linting
FROM node:alpine AS linter
WORKDIR /audit
COPY . .
# Run a simple scan or lint (example using an HTML linter)
RUN npx htmlhint index.html

# Stage 2: Final Production Image
# Added docker.io/library/ prefix so Podman resolves the SHA correctly
FROM docker.io/library/nginx:alpine@sha256:5616878291a2eed594aee8db4dade5878cf7edcb475e59193904b198d9b830de
COPY --from=linter /audit/ /usr/share/nginx/html/
