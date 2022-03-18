# opendkim-docker

[![Build Status](https://drone.delphi-sucks.de/api/badges/Sebastian/opendkim-docker/status.svg)](https://drone.delphi-sucks.de/Sebastian/opendkim-docker)

opendkim for signing and verification.

## Docker

```
docker run opendkim -p 8891:8891 -v dkimkey:/etc/dkimkeys
```

### docker-compose

```yaml
version: "3"

services:
  opendkim:
    image: opendkim:latest
    restart: always
    ports:
      - 8891:8891
    volumes:
      - dkimkeys:/etc/dkimkeys
    environment:
      OPENDKIM_SELECTOR: 2020
      OPENDKIM_DOMAIN: example.com

volumes:
  dkimkeys:
```

## Environment variables

* OPENDKIM_SELECTOR (required)
* OPENDKIM_DOMAIN (required)

## License

This project is licensed under the [MIT License](LICENSE).