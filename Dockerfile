#########################################
# HOMESEER (V4) LINUX - DOCKERFILE
#########################################
FROM wpiman/homeseer-base:5.0
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

# download appropriate version of HomeSeer Linux
RUN wget -O /homeseer.tar.gz "$DOWNLOAD" && \
  apt-get update && \
  apt-get install -y htop vim zip jq ffmpeg \
  android-sdk-platform-tools gnupg libsodium-dev \
  libsqlite3-0 sqlite3

# Typical usage
# docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S') -t homeseer/homeseer:4.2.22.0-linux .

