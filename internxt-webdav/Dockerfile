ARG BUILD_FROM=internxt/webdav:latest
FROM ${BUILD_FROM}

# Install jq, nginx, and apache2-utils for htpasswd
RUN apk add --no-cache jq nginx apache2-utils

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3005/ || exit 1

ENTRYPOINT []
CMD [ "/run.sh" ]
