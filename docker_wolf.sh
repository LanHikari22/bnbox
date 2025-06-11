docker run \
    --name wolf \
    -e XDG_RUNTIME_DIR=/tmp/sockets \
    -e TZ=America/New_York \
    -e HOST_APPS_STATE_FOLDER=/etc/wolf \
    -v /tmp/sockets:/tmp/sockets:rw \
    -v /etc/wolf:/etc/wolf:rw \
    -v /var/run/docker.sock:/var/run/docker.sock:rw \
    --device /dev/dri/ \
    -p 47984:47984/tcp \
    -p 47989:47989/tcp \
    -p 47999:47999/udp \
    -p 48010:48010/tcp \
    -p 48100-48110:48100-48110/udp \
    -p 48200-48210:48200-48210/udp \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    --gpus all \
    ghcr.io/games-on-whales/wolf:stable

#    --network=host \
