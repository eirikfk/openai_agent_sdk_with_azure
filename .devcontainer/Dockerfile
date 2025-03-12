ARG VARIANT=3-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ARG USERNAME=vscode

# Switching to root to install packages
USER root

RUN apt-get update && apt-get install -y \
    cmake \
    curl \
    build-essential \
    python3-dev \
    unixodbc \
    gnupg \
    g++ \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt update -y && apt install -y curl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Switch back to the vscode user
USER vscode

RUN curl -sSL https://install.python-poetry.org | python -

RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
    && chown -R $USERNAME \
    /home/$USERNAME/.vscode-server

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/commandhistory/.zsh_history" \
    && mkdir /home/$USERNAME/commandhistory \
    && touch /home/$USERNAME/commandhistory/.zsh_history \
    && chown -R $USERNAME /home/$USERNAME/commandhistory \
    && echo "$SNIPPET" >> "/home/$USERNAME/.zshrc"

