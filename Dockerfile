#########################################
# HOMESEER (V4) LINUX - DOCKERFILE
#########################################
FROM homeseer/base:latest
ARG TARGETARCH
ARG BUILDDATE
ARG VERSION
ARG DOWNLOAD
ARG DEBIAN_FRONTEND=noninteractive

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="homeseer/homeseer"
LABEL org.label-schema.description="HomeSeer Docker Image"
LABEL org.label-schema.url="https://homseer.sh/"
LABEL org.label-schema.vcs-url="https://github.com/HomeSeerLinux/docker"
LABEL org.label-schema.vendor="Homeseer.sh"
LABEL org.label-schema.version=$VERSION

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER HOMESEER ($VERSION) IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

# configure build time environment variables
ENV HOMESEER_VERSION="$VERSION"

# download appropriate version of HomeSeer Linux
RUN wget -O /homeseer.tar.gz "$DOWNLOAD" && \
  sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
  sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
  sed -i '/updates/d' /etc/apt/sources.list && \
  apt-get update -o Acquire::Check-Valid-Until=false && \
  apt-get update && \
  apt-get install --allow-downgrades -y libsqlite3-0=3.27.2-3+deb10u1 && \
  apt-get install --allow-downgrades -y sqlite3=3.27.2-3+deb10u1 && \
  apt-get install -y htop && \
  apt-get install -y vim && \
  apt-get install -y zip && \
  apt-get install -y jq && \
  apt-get install -y ffmpeg && \
  apt-get install -y android-sdk-platform-tools && \
  apt-get install -y gnupg && \
  apt-get install -y libsodium-dev

# Typical usage
# docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S') -t homeseer/homeseer:4.2.22.0-linux .

