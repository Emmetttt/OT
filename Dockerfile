FROM emmettttd/ot:latest

EXPOSE 7171 7172
WORKDIR /srv
VOLUME /srv
ENTRYPOINT ["/srv/tfs"]
