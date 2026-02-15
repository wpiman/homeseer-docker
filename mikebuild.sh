  docker buildx build \
    --build-arg BASE_IMAGE="wpiman/homeseer-base:Mono182" \
    --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg VERSION="4.2.22.94"     \
    --build-arg DOWNLOAD="https://homeseer.com/updates4/linux_4_2_22_94.tar.gz"   \
    --platform linux/amd64,linux/arm64 \
    --tag wpiman/homeseer:4.2.22.94_mono182_shutdownchanges \
    --push .

  sleep 5
  docker stop buildx_buildkit_homseer-builder0

  docker buildx build \
    --build-arg BASE_IMAGE="wpiman/homeseer-base:Mono200_v1" \
    --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg VERSION="4.2.22.94"     \
    --build-arg DOWNLOAD="https://homeseer.com/updates4/linux_4_2_22_94.tar.gz"   \
    --platform linux/amd64,linux/arm64 \
    --tag wpiman/homeseer:4.2.22.94_mono200_shutdownchanges \
    --push .

  sleep 5
  docker stop buildx_buildkit_homseer-builder0
