#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# Pick any base image, but if you select node, skip installing node. 😊
FROM debian:11

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # install git iproute2, required tools installed
    && apt-get install -y \
    bash-completion \
    git \
    openssh-client \
    less \
    curl \
    fd-find \
    procps \
    unzip \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    python3-pip \
    graphviz \
    jq \
    vim \
    lsb-release 2>&1
    #
    # [Optional] For local testing instead of cloud shell
    # Install Docker CE CLI.
RUN curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce-cli
    #
    # Install the AWS CLI tools
    #
RUN mkdir -p /tmp/aws \
    && cd /tmp/aws \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && pip3 install git-remote-codecommit \
    && pip3 install boto3 \
    # Support `cidr.py`
    && pip3 install tabulate \
    # Session manager plugin for SSHing etc
    && curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb" \
    && dpkg -i /tmp/session-manager-plugin.deb
    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    #
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
    #
    # Starship prompt
    #
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- --yes \
    && echo 'eval "$(starship init bash)"' >> /home/$USERNAME/.bashrc
    #
    # Add sudo support for the non-root user
    #
RUN apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME
    #
    # GO - https://golang.org/doc/install
    #
RUN curl -sL https://golang.org/dl/go1.15.3.linux-amd64.tar.gz | tar -xz -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin
    #
    # Assume role
    #
RUN /usr/local/go/bin/go get -u github.com/remind101/assume-role \
    && cp /root/go/bin/assume-role /usr/bin/assume-role
    #
    # SSH config
    #
RUN mkdir /home/${USERNAME}/.ssh \
    && echo "Host *\n\tIdentitiesOnly=yes\n\tServerAliveInterval=25" > /home/${USERNAME}/.ssh/config \
    && chown 1000:1000 -R /home/${USERNAME}/.ssh/
    #
    # Locales
    #
RUN apt-get install -y locales \
    && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8
    #
    # NVM and Exact version of Node
    #
RUN mkdir /usr/local/nvm \
    && chown $USERNAME /usr/local/nvm \
    && curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | NVM_DIR=/usr/local/nvm bash \
    && export NVM_DIR="/usr/local/nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 14.19.1 \
    && echo 'export NVM_DIR="/usr/local/nvm"' >> /home/$USERNAME/.bashrc \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/$USERNAME/.bashrc
    #
    # Yarn & Groff needed for AWS CLI
    #
RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update
RUN apt-get install -y apt-utils nodejs yarn groff
    #
    # Clean up
    #
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
