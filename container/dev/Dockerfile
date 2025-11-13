FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

# ---- Base packages and build deps ----
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    openssh-client \
    pkg-config \
    sudo \
    tar \
    tmux \
    unzip \
    xz-utils \
    zlib1g-dev \
    zsh \
    zsh-syntax-highlighting \
    shellcheck \
    make \
    jq \
    htop \
    less \
    rsync \
    unar \
    wget \
    tzdata \
    ripgrep \
    fd-find \
    eza \
    sqlite3 \
    python3-minimal \
    locales \
    parallel \
    \
    biber \
    texlive-pictures \
    fonts-ipaexfont \
    fonts-ipafont \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    fonts-noto-color-emoji \
    fonts-noto-mono \
    latexmk \
    lmodern \
    texlive-bibtex-extra \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-science \
    && rm -rf /var/lib/apt/lists/*

# Set timezone
# Set timezone and locale
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# ---- Create unprivileged user ----
RUN useradd -ms /bin/zsh appuser && \
    echo "appuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appuser && \
    chmod 0440 /etc/sudoers.d/appuser

# ---- Install mise via official apt repository ----
# hadolint ignore=DL3008
RUN install -d -m 755 /etc/apt/keyrings && \
    curl -fsSL -o /tmp/mise.gpg https://mise.jdx.dev/gpg-key.pub && \
    gpg --dearmor --batch --yes -o /etc/apt/keyrings/mise-archive-keyring.gpg /tmp/mise.gpg && \
    rm /tmp/mise.gpg && \
    chmod 644 /etc/apt/keyrings/mise-archive-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" > /etc/apt/sources.list.d/mise.list && \
    apt-get update && apt-get install -y --no-install-recommends mise && \
    rm -rf /var/lib/apt/lists/*

# ---- Configure global shell hook for mise ----
RUN install -d -m 755 /etc/zsh/zshrc.d && \
    printf '%s\n' \
      "if command -v mise >/dev/null 2>&1; then" \
      "  eval \"\$(mise activate zsh)\"" \
      "fi" \
    > /etc/zsh/zshrc.d/90-mise.zsh && \
    printf '%s\n' \
      "if command -v mise >/dev/null 2>&1; then" \
      "  eval \"\$(mise activate bash)\"" \
      "fi" \
    > /etc/profile.d/90-mise.sh

# Setup script
RUN echo 'zsh-newuser-install() { :; }' >> /etc/zsh/zshenv
COPY container/dev/setup_dev.sh /config/setup_dev.sh
COPY container/dev/ssh_config /config/ssh/config
RUN chmod 755 /config/setup_dev.sh

USER appuser
ENV USER=appuser
WORKDIR /repo
ENV PATH=/home/appuser/.local/share/mise/shims:/home/appuser/.local/bin:$PATH
