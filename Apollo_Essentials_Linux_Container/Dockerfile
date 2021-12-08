# Sample Dockerfile script for running APOLLO Essentials in a Docker on CentOS 8
# Copyright 2021 Hexagon AB and/or its subsidiaries and affiliates. All rights reserved.

# Example Usage
# -------------
# By running the following commands, you acknowledge reading and acceptance of the EULA:
# To build this Dockerfile:
#  docker build -t apollo-docker --build-arg ACCEPT_EULA=1 --build-arg LICENSE_SERVER=<your_license_server> --build-arg APOLLO_INSTALLER=ERDAS-APOLLO-Essentials_2022.bin .
# To run a container with the resulting image:
#  docker run --rm -p 8088:80 apollo-docker:latest
# To configure the server, attach to the container and run /usr/local/hexagon/erdas-apollo/tools/configurationWizard.sh

FROM centos:8

ARG APOLLO_INSTALLER
ARG ACCEPT_EULA
ARG LICENSE_SERVER

# Copy APOLLO Essentials installer to docker image
COPY $APOLLO_INSTALLER /home/

# Extract RPM and process EULA acceptance (please refer to header comment)
RUN /home/$APOLLO_INSTALLER /S ACCEPT_EULA=$ACCEPT_EULA \
 && rm /home/$APOLLO_INSTALLER

# Install APOLLO Essentials
RUN yum localinstall -y /home/ERDASAPOLLOEssentials*.rpm \
 && rm /home/ERDASAPOLLOEssentials*.rpm \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && rm -f /anaconda-post.log

# Postinstall.sh needs to run manually after installing in the docker image
RUN /usr/local/hexagon/erdas-apollo/storage/config_clean/postinstall.sh

# Configure license server
RUN echo $LICENSE_SERVER > /usr/local/intergraph/licensing/INGRTS_LICENSE_PATH

# Note: create and mount volume for server configuration
# Config files are stored in /usr/local/hexagon/erdas-apollo/config


# Note: create and mount volume(s) for datasets


# Copy startup script into image and setup
COPY apollo-entry.sh /
RUN chmod u+x /apollo-entry.sh

# Expose necessary ports for server and database access
EXPOSE 80

# Specify entrypoint script for Apollo Essentials
ENTRYPOINT /apollo-entry.sh
