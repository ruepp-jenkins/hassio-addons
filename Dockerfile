ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install Node.js and npm for Internxt CLI
RUN apk add --no-cache nodejs npm

# Install Internxt CLI globally
RUN npm install -g @internxt/cli

# Copy root filesystem
COPY rootfs /

# Set up permissions
RUN chmod a+x /etc/s6-overlay/s6-rc.d/internxt-webdav/run
