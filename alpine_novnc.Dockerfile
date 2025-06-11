# Use a base image
# FROM alpine:latest
FROM novaspirit/alpine_xfce4_novnc

USER root

ENV VNC_RESOLUTION=1280x720

# Install necessary packages
 RUN apk update && apk add --no-cache \
  wget \
  openssh-server \
  python3 \
  py3-pip \
  gcc


# Download the mGBA AppImage 
RUN wget -O /home/alpine/mGBA.AppImage https://github.com/mgba-emu/mgba/releases/download/0.10.3/mGBA-0.10.3-appimage-x64.appimage && \
    chmod +x /home/alpine/mGBA.AppImage

# Create a Python virtual environment
RUN python3 -m venv /opt/venv

# Set up SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY app /app/

# Let's install the requirements by the app
# RUN . /opt/venv/bin/activate && pip install -r /app/requirements.txt

# Expose ports
EXPOSE 22

USER alpine

# Copy the entrypoint script
# COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh
 
# Use the custom entrypoint
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
