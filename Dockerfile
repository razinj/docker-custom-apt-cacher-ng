FROM ubuntu:21.04

# Disable watchtower checking
LABEL com.centurylinklabs.watchtower.enable="false"

# Expose the cache directory for volume binding
VOLUME ["/var/cache/apt-cacher-ng"]

# Update apt-get cache
RUN apt-get update -y && \
        # Install apt-cacher-ng package
        apt-get install apt-cacher-ng -y && \
        # Clean up
        rm -rf /var/lib/apt/lists/*

# Expose the apt-cacher-ng port to be binded
EXPOSE 3142

# Set cache directory permissions
CMD chmod 777 /var/cache/apt-cacher-ng && \
        # Append PassThroughPattern config for SSL/TLS proxying (optional)
        echo "PassThroughPattern: .*" >> /etc/apt-cacher-ng/acng.conf && \
        # Start the service
        /etc/init.d/apt-cacher-ng start && \
        # Output all logs of apt-cacher-ng
        tail -f /var/log/apt-cacher-ng/*
