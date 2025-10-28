# Use Microsoft's Debian Bookworm base image
FROM mcr.microsoft.com/devcontainers/base:bookworm
ARG USERNAME=vscode

# Pre-create directories that will be used by volumes and set proper permissions
RUN mkdir -p /workspace/node_modules \
    && chown -R ${USERNAME}:${USERNAME} /workspace \
    && mkdir -p /home/${USERNAME}/.cache \
    && mkdir -p /home/${USERNAME}/.bun \
    && mkdir -p /home/${USERNAME}/.vscode-server/extensions \
    && mkdir -p /home/${USERNAME}/commandhistory \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.bun \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.vscode-server \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/commandhistory

# Switch to vscode user to install Bun
USER ${USERNAME}

# Install Bun as vscode user
ENV BUN_INSTALL=/home/vscode/.bun
ENV PATH=$BUN_INSTALL/bin:$PATH
RUN curl -fsSL https://bun.sh/install | bash

# Configure zsh history persistence (using zsh's precmd instead of bash PROMPT_COMMAND)
RUN echo 'export HISTFILE=/home/vscode/commandhistory/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTSIZE=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'export SAVEHIST=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt SHARE_HISTORY' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_ALL_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_FIND_NO_DUPS' >> /home/${USERNAME}/.zshrc \
    && touch /home/${USERNAME}/commandhistory/.zsh_history

# Switch back to root for any remaining setup (if needed by features)
USER root

