FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# Set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xtreemmak"

# Define environment variables
ENV TITLE=Msty
ENV CONFIG_DIR=/config
ENV MSTY_INSTALL_DIR=/opt/msty

RUN \
  echo "**** Install required packages ****" && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y --no-install-recommends \
    chromium \
    chromium-l10n \
    git \
    libgtk-3-bin \
    libatk1.0 \
    libatk-bridge2.0 \
    libnss3 \
    python3-xdg \
    wget \
    libfuse2 \
    gdebi-core && \
  echo "**** Install Msty ****" && \
  cd /tmp && \
  wget -O Msty.AppImage "https://assets.msty.app/prod/latest/linux/amd64/Msty_x86_64_amd64.AppImage" && \
  chmod +x Msty.AppImage && \
  ./Msty.AppImage --appimage-extract && \
  mv squashfs-root ${MSTY_INSTALL_DIR} && \
  chmod -R 755 ${MSTY_INSTALL_DIR} && \
  echo "**** Cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# Copy startup script and ensure it is executable
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Set PATH to include Msty
ENV PATH="${MSTY_INSTALL_DIR}:${PATH}"

# Expose ports and define volumes
EXPOSE 3000
VOLUME /config

# Run startup script
CMD ["bash", "-c", "/startup.sh"]
