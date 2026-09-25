# Use Microsoft's Debian Bookworm base image
FROM mcr.microsoft.com/devcontainers/base:bookworm
ARG USERNAME=vscode

# Pre-create directories that will be used by volumes and set proper permissions
RUN mkdir -p /workspace/node_modules \
    && chown -R ${USERNAME}:${USERNAME} /workspace \
    && mkdir -p /home/${USERNAME}/.cache \
    && mkdir -p /home/${USERNAME}/.local/share/mise \
    && mkdir -p /home/${USERNAME}/.vscode-server/extensions \
    && mkdir -p /home/${USERNAME}/commandhistory \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.cache \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.local \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.vscode-server \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/commandhistory

# Switch to vscode user to install mise
USER ${USERNAME}

# Install mise (manages bun, uv, ... per the repo's mise.toml).
# The mise binary is baked into the image; the actual tools are provisioned at
# runtime by postCreateCommand.sh, once the bind-mounted mise.toml is available.
ENV MISE_DATA_DIR=/home/${USERNAME}/.local/share/mise
ENV PATH=/home/${USERNAME}/.local/bin:${MISE_DATA_DIR}/shims:$PATH
RUN curl -fsSL https://mise.run | sh

# Activate mise for interactive zsh shells and configure history persistence
RUN echo 'eval "$(mise activate zsh)"' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTFILE=/home/vscode/commandhistory/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTSIZE=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'export SAVEHIST=10000' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt SHARE_HISTORY' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_IGNORE_ALL_DUPS' >> /home/${USERNAME}/.zshrc \
    && echo 'setopt HIST_FIND_NO_DUPS' >> /home/${USERNAME}/.zshrc \
    && touch /home/${USERNAME}/commandhistory/.zsh_history

# Switch back to root for any remaining setup (if needed by features)
USER root
