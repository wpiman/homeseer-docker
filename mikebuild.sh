  docker buildx build \
    --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg VERSION="4.2.22.4"     \
    --build-arg DOWNLOAD="https://homeseer.com/updates4/linux_4_2_22_4.tar.gz"   \
    --platform linux/amd64,linux/arm64 \
    --tag wpiman/homeseer:4.2.22.4__with_gpg \
    --push .

  sleep 5
  docker stop buildx_buildkit_homseer-builder0
