# Configuring container for flashTest

* Build with:

```bash
docker container create -i -t -h gnu-mpich --name gnu-mpich -v /home/acreyes/podman:/mnt/local flashcenter/gnu-mpich
```

* checkout flashTest

    ```bash
    svn co svn+ssh://acreyes@flash.rochester.edu/home/svn/repos/flashTest/trunk ./flashTest
    ```

    * configure flashTest for `gnu-mpich`
    
        ``` bash
        ln -s ConfigFiles/config.gnu-mpich ./config
        ln -s ExeScripts/lahey-mpi2/exeScript exeScript
        ```

    * edit `config` to point to right things (this can be done on the repo for `flashTest`)
    * turned of netcdf in sfocu
    * had to point to local `test.info` file. Couldn't copy from remote on `flash`

* `flashTest.py` queries environment variable `$LOGNAME`, but container doesn't seem to set this. I exported it from CL

* Run with:

```bash
./flashTest.py -v -f TestFiles/lahey-mpi2/quickTests
```
