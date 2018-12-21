ARG REGISTRY
FROM $REGISTRY/debian:stretch

# Maintainer
MAINTAINER Thijs Cramer <thijs.cramer@gmail.com>

# Prerequisites
ENV http_proxy "http://145.77.103.133:8080"
ENV https_proxy "http://145.77.103.133:8080"

RUN apt update && apt install -y \
  wget \
  dos2unix \
  gnupg2

# Setup Repo
RUN wget  --no-check-certificate https://repo.saltstack.com/py3/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub -O salt.pub && apt-key add salt.pub
RUN echo "deb http://repo.saltstack.com/py3/debian/9/amd64/latest stretch main" > /etc/apt/sources.list.d/saltstack.list
RUN apt update

# Install Salt
RUN apt install -y \
  salt-master \
  salt-ssh \
  salt-cloud

# Volumes
VOLUME "/etc/salt/pki"
VOLUME "/var/cache/salt"
VOLUME "/var/logs/salt"
VOLUME "/etc/salt/master.d"
VOLUME "/srv/salt"

# Pots
EXPOSE 4505 4506

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN dos2unix /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]