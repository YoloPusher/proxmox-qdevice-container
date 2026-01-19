# Pull base image
FROM debian:13-slim

# Install required packages
RUN apt update \
    && apt -y upgrade \
    && apt install --no-install-recommends -y iproute2 supervisor openssh-server corosync-qnetd \
    && apt -y autoremove \
    && apt clean all

# Copy build context
COPY context/supervisord.conf /etc/supervisord.conf
COPY context/init-qnetd-nssdb.sh /usr/local/bin/init-qnetd-nssdb.sh
COPY context/update-root-password.sh /usr/local/bin/update-root-password.sh
COPY context/disable-root-login.sh /usr/local/bin/disable-root-login.sh

# Make helper scripts executable
RUN chmod +x /usr/local/bin/update-root-password.sh
RUN chmod +x /usr/local/bin/init-qnetd-nssdb.sh

# Enable root password login in sshd
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create sshd directory
RUN mkdir -p /run/sshd
RUN chown root:root /run/sshd
RUN chmod 640 /run/sshd

# Create runtime directories
RUN mkdir -p /run/corosync-qnetd/
RUN chown -R coroqnetd:coroqnetd /run/corosync-qnetd/ 
RUN mkdir -p /var/run/corosync-qnetd/
RUN chown -R coroqnetd:coroqnetd /var/run/corosync-qnetd/

# Expose SSH Corosync port
EXPOSE 22 
EXPOSE 5403

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
