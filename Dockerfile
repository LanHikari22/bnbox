FROM dorowu/ubuntu-desktop-lxde-vnc
MAINTAINER Mohammed Alzakariya <lanhikarixx@gmail.com>

# ENV VNC_RESOLUTION=1280x720

# The repository that would build the ROM. Clone this from its respective repo, like https://github.com/dism-exe/bn6f/
# Make sure to run /root/setup.sh to be able to use it
ENV ROM_BUILD_REPO_NAME=bn6f

# Clone from git clone https://github.com/luckytyphlosion/agbcc -b new_layout_with_libs
# It is required for building the ROM. Put it in the mounting folder.
ENV AGBCC_REPO_NAME=agbcc

# The base ROM to be exposed to the environment
ENV BASE_ROM={ROM_BUILD_REPO_NAME}.gba

# Remove the Google Chrome repository if it exists
RUN rm -f /etc/apt/sources.list.d/google-chrome.list

# Install necessary packages
 RUN apt update && apt-get install -y \
  wget \
  curl \
  git \
  make \
  openssh-server \
  python3-pip \
  libpng-dev \
  exuberant-ctags \
  gcc
#  python3.10-venv \

# Download the mGBA AppImage 
 RUN wget -O /root/mGBA.AppImage https://github.com/mgba-emu/mgba/releases/download/0.10.3/mGBA-0.10.3-appimage-x64.appimage && \
     chmod +x /root/mGBA.AppImage && \
     /root/mGBA.AppImage --appimage-extract && \
     mv /root/squashfs-root/ /root/mgba/ && \
     ln -s /root/mgba/AppRun /usr/local/bin/mgba
 
# Create a Python virtual environment
# RUN python3 -m venv /opt/venv

# Set up SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# COPY app /app/

# Let's install the requirements by the app
# RUN . /opt/venv/bin/activate && pip install -r /app/requirements.txt

# Expose ports
EXPOSE 22

# Copy the entrypoint script
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
 
# Use the custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
