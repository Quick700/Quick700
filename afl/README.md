# Fuzzing Apache with AFL
## Dependency
- Docker

## How to run
### Use prebuilt images
- Fuzz through input file: `docker run -it ysli/fuzz-apache:afl`
- On persistent mode: `docker run -it ysli/fuzz-apache:aflp`

### Customize your build
1. Modify [Dockerfile](Dockerfile) or
  [Dockerfile.persistence](Dockerfile.persistence)
2. Build docker images with `docker build -f Dockerfile .`, or `docker build -f
  Dockerfile.persistence .`. Consider using `-t` option for convenience.
3. `docker run -it IMAGE`, where `IMAGE` is the ID or tag of the image built in
   previous step.
