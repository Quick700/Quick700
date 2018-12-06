# Ocaml-Fuzz

This subproject uses QuickChick and FuzzChick to test the apache server.

## Getting Started


### Prerequisites


You need to install the docker :).
Follow this website: https://www.docker.com/get-started

### Installing

You can directly build from the docker file inside the directory to obtain a working environment.

```
docker build -t ocmal-fuzz .
```
After the docker is successfully built, run

```
docker run --privileged -it --name ocmal-fuzz-fun ocmal-fuzz
```

Trouble shoot: if you the docker build process fails with exit code 137, it means the your computer don't have enough memory. Run:
```
mv Dockerfile Dockerfile_old
mv Dockerfile_137 Dockerfile
docker build .
docker run --privileged -it --name ocmal-fuzz-fun ocmal-fuzz
./setup.sh
make -C src
```

## Running the tests

The test should run automatically after you run the docker image, but if you want to play around with the codes more, you can delete the last line in Dockerfile. which is

```
CMD make -C src
```

and
```
cd src
```
to get into the codes.

## Citation

* QuickChick: https://github.com/QuickChick/QuickChick
* FuzzChick: https://github.com/QuickChick/QuickChick/tree/FuzzChick
* Compcert: https://github.com/AbsInt/CompCert
* Use AFL fuzz Apache: https://sensepost.com/blog/2017/fuzzing-apache-httpd-server-with-american-fuzzy-lop-%2B-persistent-mode/
