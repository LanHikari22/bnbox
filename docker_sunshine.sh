docker run -d \
  --device /dev/dri/ \
  --name=sunshine \
  --restart=unless-stopped \
  --ipc=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -v /home/lan/data/mounted/sunshine:/config \
  -p 47984-47990:47984-47990/tcp \
  -p 48010:48010 \
  -p 47998-48000:47998-48000/udp \
  --gpus all \
  lizardbyte/sunshine:latest-ubuntu-22.04
