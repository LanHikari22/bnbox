docker run -d \
  --device /dev/dri/ \
  --name=sunshine \
  --restart=unless-stopped \
  --ipc=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -e XDG_RUNTIME_DIR=/tmp/runtime-dir \
  -e DISPLAY=:99 \
  -e WAYLAND_DISPLAY=wayland-0 \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -v /home/lan/data/mounted/sunshine:/config \
  -p 47984-47990:47984-47990/tcp \
  -p 48010:48010 \
  -p 47998-48000:47998-48000/udp \
  --cap-add=SYS_ADMIN \
  --gpus all \
  lan-sunshine:latest
