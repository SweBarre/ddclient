FROM opensuse/tumbleweed

RUN zypper install --no-confirm --no-recommends \
         openSUSE-release-appliance-docker \
         ddclient \
         perl-IO-Socket-SSL \
    && zypper clean --all \
    && usermod -s /bin/bash ddclient \
    && mkdir -m 0750 /srv/ddclient \
    && chown ddclient /srv/ddclient

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/ddclient", "-foreground", "-cache", "/srv/ddclient/ddclient.cache", "-file /srv/ddclient/ddclient.conf"]
