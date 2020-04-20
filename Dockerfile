FROM opensuse/tumbleweed

RUN zypper install --no-confirm \
         openSUSE-release-appliance-docker \
         ddclient \
    && zypper clean --all \
    && mkdir -m 0750 /srv/ddclient \
    && chown ddclient /srv/ddclient

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["ddclient", "-foreground", "-cache", "/srv/ddclient/ddclient.cache", "-file /srv/ddclient/ddclient.conf"]
