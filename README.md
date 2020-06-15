# JSatOrb project: Dockerisation module

This JSatOrb module is dedicated to the JSatOrb servers dockerisation.
It contains all thge information needed to produce the various Docker images and the Docker compose which runs them all.

All Docker images run into a Linux Ubuntu 18.04 LTS 64 bit environment, which is the JSatOrb target platform.

The Linux free edition of Docker is the Community Edition (CE).


## Uninstalling old Docker versions

To uninstall a possible previous Docker installation, run the command:
```
>sudo apt-get remove docker docker-engine docker.io containerd runc
```


## Installing Docker

---

**NOTE**

___This whole paragraph ("Installing Docker"), except the last part ("Post-installation steps")  is an extract of the repository setup section from [this Docker documentation webpage.](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository#install-using-the-repository)___

---

### Set up the repository

1. Update the `apt` package index and install packages to allow apt to use a repository over HTTPS:

```
>sudo apt-get update

>sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

2. Add Docker’s official GPG key:

```
>curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Verify that you now have the key with the fingerprint `9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88`, by searching for the last 8 characters of the fingerprint.

```
>sudo apt-key fingerprint 0EBFCD88

pub   rsa4096 2017-02-22 [SCEA]
        9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

3. Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.

---

**NOTE**

The lsb_release -cs sub-command below returns the name of your Ubuntu distribution, such as xenial. Sometimes, in a distribution like Linux Mint, you might need to change $(lsb_release -cs) to your parent Ubuntu distribution. For example, if you are using Linux Mint Tessa, you could use bionic. Docker does not offer any guarantees on untested and unsupported Ubuntu distributions.

---

```
>sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
```    

#### Install Docker Engine

1. Update the `apt` package index, and install the _latest version_ of Docker Engine and containerd, or go to the next step to install a specific version:

```
>sudo apt-get update
>sudo apt-get install docker-ce docker-ce-cli containerd.io
```

---

**Got multiple Docker repositories ?**

If you have multiple Docker repositories enabled, installing or updating without specifying a version in the apt-get install or apt-get update command always installs the highest possible version, which may not be appropriate for your stability needs.

---

2. To install a specific version of Docker Engine, list the available versions in the repo, then select and install:

    a. List the versions available in your repo:

```
>apt-cache madison docker-ce

    docker-ce | 5:18.09.1~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
    docker-ce | 5:18.09.0~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
    docker-ce | 18.06.1~ce~3-0~ubuntu       | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
    docker-ce | 18.06.0~ce~3-0~ubuntu       | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages

```

   b. Install a specific version using the version string from the second column, for example, `5:18.09.1~3-0~ubuntu-xenial`.

```
>sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

3. Verify that Docker Engine is installed correctly by running the hello-world image.

```
>sudo docker run hello-world
```

This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

Docker Engine is installed and running. The `docker` group is created but no users are added to it. You need to use `sudo` to run Docker commands. Continue to `Linux postinstall` to allow non-privileged users to run Docker commands and for other optional configuration steps.

#### Upgrade Docker Engine

To upgrade Docker Engine, first run `sudo apt-get update`, then follow the installation instructions, choosing the new version you want to install.


#### Post-installation steps

If the previous Docker successfull installation step above failed (with the running of the Hello-world image), you may configure your proxy.  
To do so, follow the steps below.

##### Add user to docker group

---

**NOTE**

The information given in this paragraph is an adaptation fom [this Docker documentation webpage](https://docs.docker.com/engine/install/linux-postinstall/).

---

Create the docker group if it's not already existing:
```
>sudo groupadd docker
```

Add your user to the docker group:
```
>sudo usermod -aG docker $USER
```

Log out and log back in so that your group membership is re-evaluated.

On Linux, you can also run the following command to activate the changes to groups:
```
>newgrp docker
```

Verify that you can run docker commands without sudo.
```
>docker info
```


##### Proxy setup

---

**NOTE**

The information given in this paragraph is an adaptation fom [this Docker documentation webpage](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy).

---

This example overrides the default docker.service file.

If you are behind an HTTP or HTTPS proxy server, for example in corporate settings, you need to add this configuration in the Docker systemd service file.

Create a systemd drop-in directory for the docker service:
```
>sudo mkdir -p /etc/systemd/system/docker.service.d
```

Create a file called /etc/systemd/system/docker.service.d/http-proxy.conf that adds the HTTP_PROXY environment variable:

```
[Service]    
Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"
```

Or, if you are behind an HTTPS proxy server, create a file called /etc/systemd/system/docker.service.d/https-proxy.conf that adds the HTTPS_PROXY environment variable:

```
[Service]    
Environment="HTTPS_PROXY=https://proxy.example.com:443/" "NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"
```

Flush changes: 
```
>sudo systemctl daemon-reload
```

Restart Docker: 
```
>sudo systemctl restart docker
```

Verify that the configuration has been loaded:
```
>systemctl show --property=Environment docker
Environment=HTTP_PROXY=http://proxy.example.com:80/
```

Or, if you are behind an HTTPS proxy server:

```
>systemctl show --property=Environment docker
Environment=HTTPS_PROXY=https://proxy.example.com:443/
```


## Installing docker compose

To get the latest Docker compose version, get the command from [this page](https://docs.docker.com/compose/install/) or use the one below for the 1.26.0 version:

```
>sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Add execution permission:
```
>sudo chmod +x /usr/local/bin/docker-compose
```

Check installation works:
```
>docker-compose --version
docker-compose version 1.26.0, build d4451659
```

## Building JSatOrb Docker images

Build an image and give it a name
```
docker build -t [IMAGE_NAME] .
```

Run a Docker image (in detached mode)
```
docker run -d [-p HOST_PORT:CONTAINER_PORT] [IMAGE_NAME]
```


## Usefull links

[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
[Configure proxy for the Docker Daemon](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy)
[Linux post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/)
[Install Docker compose](https://docs.docker.com/compose/install/)
