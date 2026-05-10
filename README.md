# phones-rtpengine

Docker image for [rtpengine](https://github.com/sipwise/rtpengine), the Sipwise RTP proxy. Built using-non free ffmpeg packages from [deb-multimedia.org/](https://deb-multimedia.org/)

## TODO

- [X] Get basic rtpengine container operational
- [X] Add support for AMR codecs
- [X] Add transcoding support
- [ ] Add support for kernel module

## Building

```sh
make build   # build locally
make push    # build and push to registry
```

The image name, tag, and platform are defined at the top of the `Makefile`.

## Running

```sh
docker compose up -d
```

The container uses host networking so rtpengine can handle RTP traffic directly on the host's interfaces.

## Configuration

rtpengine arguments are passed via `command:` in `docker-compose.yml`:

```yaml
command:
  - --listen-ng=0.0.0.0:5000
  - --foreground
  - --log-stderr
  - --log-level=6
  - --table=-1
  - --listen-cli=0.0.0.0:6000
  - --listen-http=0.0.0.0:7000
```

## Updating rtpengine

Update the two `ARG` values at the top of the `Dockerfile` to match the desired release from the [rtpengine releases page](https://github.com/sipwise/rtpengine/releases):

```dockerfile
ARG RTPENGINE_TAG=mr13.5.1.10
ARG RTPENGINE_VERSION=13.5.1.10+0.mr13.5.1.10+gh+trixie
```
