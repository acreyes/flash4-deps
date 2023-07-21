# Intel compiler Docker image for running FLASH

* build image and create a container
```
make
docker container create -i -t -h intel --name flash4-intel -v $(pwd):/mnt/local flashcenter/intel
```

* builds the image `flashcenter/intel`
* creates container `flash4-intel` with hostname `intel` and a volume mounted at `/mnt/local` to your current working directory

Start and attach to the container

```
docker container start -ai flash4-intel
```

Before doing anything you will need to setup the intel environment

```
source /opt/intel/oneapi/setvars.sh
```
