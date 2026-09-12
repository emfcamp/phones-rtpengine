# phones-rtpengine

Docker image for [rtpengine](https://github.com/sipwise/rtpengine), the Sipwise RTP proxy.

## TODO

- [X] Get basic rtpengine container operational
- [X] Add transcoding support
- [ ] Add support for kernel module

## Configuration

[`entrypoint.sh`](entrypoint.sh) builds the rtpengine arguments from environment variables, which can be overridden in  `compose.yml`, e.g:

```yaml
environment:
  RTPENGINE_INTERFACE: 127.0.0.1
```

| Env var                | Default        | rtpengine option |
| ---------------------- | -------------- | ---------------- |
| `RTPENGINE_INTERFACE`  | `127.0.0.1`    | `--interface`    |
| `RTPENGINE_LISTEN_NG`  | `0.0.0.0:2223` | `--listen-ng`    |
| `RTPENGINE_LISTEN_CLI` | `0.0.0.0:6000` | `--listen-cli`   |
| `RTPENGINE_LISTEN_HTTP`| `0.0.0.0:7000` | `--listen-http`  |
| `RTPENGINE_TABLE`      | `-1`           | `--table`        |
| `RTPENGINE_PORT_MIN`   | `10000`        | `--port-min`     |
| `RTPENGINE_PORT_MAX`   | `29999`        | `--port-max`     |
| `RTPENGINE_LOG_LEVEL`  | `6`            | `--log-level`    |

`--foreground` and `--log-stderr` are always set


## Usage

To build locally:

```sh
docker buildx build -t phones-rtpengine .
```

To run:

```sh
docker compose up -d
```

## Updating rtpengine

Update the `ARG` value at the top of the `Dockerfile` to match the desired release from the [rtpengine releases page](https://github.com/sipwise/rtpengine/releases):

```dockerfile
ARG RTPENGINE_TAG=mr26.2.1.1
```
