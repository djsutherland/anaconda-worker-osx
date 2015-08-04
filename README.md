Vagrant configuration to set up an OSX worker for your anaconda.org build queue.

OSX box for Virtualbox via [AndrewDryga/vagrant-box-osx](https://github.com/AndrewDryga/vagrant-box-osx). Licensing terms allow you to run this only on Apple hardware.

Setup:

* [Create a build queue](http://docs.anaconda.org/build-config.html#CreateABuildQueue):

```
anaconda-build queue --create USERNAME/QUEUENAME
```

* Put your queue name into the file `queuename`:

```
echo USERNAME/QUEUENAME > queuename
```
    
* [Make a build token](http://docs.anaconda.org/build-config.html#BuildWorkerTokens):

```
anaconda auth --create -n 'token name' --scopes api:build-worker --out binstar.token
```

* `vagrant up`

After it's done provisioning, you should see an osx-64 worker on [your build queue page](https://anaconda.org/settings/build-queue).

You can then submit jobs to it with `anaconda-build submit . --queue USERNAME/QUEUENAME`. Unless you also add Linux workers to this queue, you probably want to submit your builds twice, once to this queue and once to `binstar/public`.

Logs are saved to `~/.log/conda-worker-stdout` and `~/.log/conda-worker-stderr`. These files are not rotated (yet).

Note that the machine state is *not* reset between jobs, as it is with `binstar/public`, so don't submit jobs that permanently alter the machine state. Relatedly, the conda cache should probably be occasionally cleaned, and so on.
