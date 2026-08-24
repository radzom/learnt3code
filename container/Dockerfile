ARG NODE_VERSION=24.19.0
FROM node:${NODE_VERSION}-bookworm-slim

ARG T3_VERSION=0.0.33
ARG CODEX_VERSION=0.149.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        g++ \
        make \
        openssh-client \
        python3 \
        tini \
    && npm install --global \
        "t3@${T3_VERSION}" \
        "@openai/codex@${CODEX_VERSION}" \
    && npm cache clean --force \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 10001 agent \
    && useradd --uid 10001 --gid 10001 --create-home --shell /bin/bash agent \
    && install -d -o agent -g agent \
        /workspace \
        /var/lib/t3 \
        /var/lib/codex

ENV HOME=/home/agent \
    T3CODE_HOME=/var/lib/t3 \
    CODEX_HOME=/var/lib/codex \
    NPM_CONFIG_CACHE=/tmp/npm-cache

USER agent
WORKDIR /workspace

EXPOSE 3773

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["t3", "serve", "--mode", "web", "--host", "0.0.0.0", "--port", "3773", "--base-dir", "/var/lib/t3", "--no-browser", "/workspace"]
