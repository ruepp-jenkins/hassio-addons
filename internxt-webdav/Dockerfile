ARG BUILD_FROM=internxt/webdav:latest
FROM ${BUILD_FROM}

# Install jq to read Home Assistant config
RUN apt-get update && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
