#########################################
# HOMESEER (V4) LINUX - DOCKERFILE
#########################################
ARG BASE_IMAGE=wpiman/homeseer-base:latest
FROM ${BASE_IMAGE}

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
#LABEL org.label-schema.vcs-url="https://github.com/HomeSeerLinux/docker"
LABEL org.label-schema.vcs-url="https://github.com/wpiman/homeseer-docker"
LABEL org.label-schema.vendor="Homeseer.sh"
LABEL org.label-schema.version=$VERSION

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER HOMESEER ($VERSION) IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

# configure build time environment variables
ENV HOMESEER_VERSION="$VERSION"

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# download appropriate version of HomeSeer Linux
RUN  apt-get update && \
  apt-get install -y htop vim zip jq ffmpeg \
  android-sdk-platform-tools gnupg libsodium-dev \
  libsqlite3-0 sqlite3

RUN wget -O /homeseer.tar.gz "$DOWNLOAD" 

# Typical usage
# docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S') -t homeseer/homeseer:4.2.22.0-linux .

