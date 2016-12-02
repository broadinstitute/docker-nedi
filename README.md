docker-nedi
===============
[![Docker Hub](http://img.shields.io/badge/docker-hub-brightgreen.svg?style=flat)](https://registry.hub.docker.com/u/broadinstitute/nedi/)

This repository is used to create a [NeDi][1] [Docker][2] image.  This image is based on [Phusion Baseimage][3]

Running nedi
----------------

Words here...

```bash
docker run -d --hostname test.example.org \
    -e SERVER_NAME=test.example.org \
    -p 80:80 \
    -p 443:443 \
    -v /path/to/ssl/key:/etc/ssl/private/server.key:ro \
    -v /path/to/ssl/certificate:/etc/ssl/certs/server.crt:ro \
    -v /path/to/ssl/chain:/etc/ssl/certs/ca-bundle.crt:ro \
    broadinstitute/nedi:latest
```

You can also use [Docker Compose][4] to start the container as well:

```YAML
nedi:
    image: broadinstitute/nedi:latest
    hostname: test.example.org
    ports:
        - "80:80"
        - "443:443"
    environment:
        HTTPD_PORT: 80
        LOG_LEVEL: warn
        SERVER_ADMIN: webmaster@example.org
        SERVER_NAME: test.example.org
        SSL_HTTPD_PORT: 443
    volumes:
        - /path/to/ssl/key:/etc/ssl/private/server.key:ro
        - /path/to/ssl/certificate:/etc/ssl/certs/server.crt:ro
        - /path/to/ssl/chain:/etc/ssl/certs/ca-bundle.crt:ro
```

[1]: http://www.nedi.ch/ "NeDi"
[2]: https://www.docker.com/ "Docker"
[3]: https://hub.docker.com/r/phusion/baseimage/ "Phusion Baseimage"
[4]: https://docs.docker.com/compose/ "Docker Compose"
