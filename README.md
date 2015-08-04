Vagrant configuration to set up an OSX worker for your anaconda.org build queue.

OSX box via [Andrew/Drygavagrant-box-osx](https://github.com/AndrewDryga/vagrant-box-osx). Licensing terms allow you to run this only on Apple hardware.

Setup:

* [Create a build queue](http://docs.anaconda.org/build-config.html#CreateABuildQueue):

```
anaconda-build queue --create USERNAME/QUEUENAME
```
    
* [Make a build token](http://docs.anaconda.org/build-config.html#BuildWorkerTokens):

```
anaconda auth --create -n 'token name' --scopes api:build-worker --out binstar.token
```

* Edit `me.dougal.conda-worker.plist`'s second entry in `ProgramArguments` to your `USERNAME/QUEUENAME`.

* `vagrant up`

After it's done provisioning, you should see an osx-64 worker on [your build queue page](https://anaconda.org/settings/build-queue).

You can then submit jobs to it with `anaconda-build submit . --queue USERNAME/QUEUENAME`. Unless you also add Linux workers to this queue, you probably want to submit your builds twice, once to this queue and once to `binstar/public`.

Logs are saved to `~/.log/conda-worker-stdout` and `~/.log/conda-worker-stderr`. These files are not rotated (yet).
