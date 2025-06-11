# Use a base image
FROM lizardbyte/sunshine:latest-ubuntu-22.04

USER root

RUN apt-get update && apt-get install -y software-properties-common \
  && add-apt-repository ppa:graphics-drivers/ppa

# Install necessary packages
RUN apt-get update && apt-get install -y \
  curl \
  libgbm1 \
  openssh-server \
  libnvidia-fbc1-560 \
  python3.10-venv \
  python3-pip \
  gcc \
  xvfb \
  weston


# Create a Python virtual environment
RUN python3 -m venv /opt/venv

# For Wayland Setup
ENV XDG_RUNTIME_DIR=/tmp/runtime-dir
RUN mkdir -p /tmp/runtime-dir && chmod 0700 /tmp/runtime-dir

# Set up SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set the timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup place for bins in $PATH
RUN mkdir -p /root/.local/bin
RUN echo 'PATH=/root/.local/bin:$PATH' >> /root/.zshrc

COPY app /app/

# Let's install the requirements by the app
# RUN . /opt/venv/bin/activate && pip install -r /app/requirements.txt

# Expose ports
EXPOSE 22

# Copy the entrypoint script
# COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh
 
# Use the custom entrypoint
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
