#  Aspen Dev Environment

This is an Aspen-discovery Docker instance designed to make developing Aspen 
easier. 

Still in early stages and there are a number of improvements to be made

## Requirements

### Software

This project is self contained and all you need is:

- A text editor to tweak configuration files
- Docker ([install instructions](https://docs.docker.com/engine/install/))
- Docker Compose v2 ([install instructions](https://docs.docker.com/compose/install/linux/#install-using-the-repository))

Note: **Windows** and **macOS** users use [Docker Desktop](https://docs.docker.com/compose/install/compose-desktop/) which already ships Docker Compose v2.

## Setup

It is not a bad idea to organize your projects in a directory. For the purpose
of simplifying the instructions we pick `~/git` as the place in which to put
all the repository clones:

```shell
mkdir -p ~/git
export PROJECTS_DIR=~/git
```

* Clone the `aspen-dev-box` project:

```shell
cd $PROJECTS_DIR
git clone https://github.com/Jacobomara901/aspen-dev-box.git aspen-deb-box
```

* Clone the `aspen-discovery` project (skip and adjust the paths if you already have it):

```shell
cd $PROJECTS_DIR
git clone https://github.com/mdnoble73/aspen-discovery.git aspen-discovery
```

* Set some **mandatory** environment variables:

```
export ASPEN_DEV_BOX=~/Documents/aspendockerstruct
export ASPEN_CLONE=$ASPEN_DEV_BOX/aspen-discovery
export ASPEN_DOCKER=$ASPEN_DEV_BOX/aspen-dev-box
```

**Note:** you will need to log out and log back in (or start a new terminal window) for this to take effect.

## Running the dev box

Now you can start up your devbox

```shell
cd aspen-dev-box
docker compose up
```

### Accessing the console

You should now be able to access the console using:

```shell
docker exec -it containeraspen bash
```

### Getting to the web interface

The IP address of the web server in your docker group will be variable. Once you are in with SSH, issuing a

```shell
ip a
```
should display the IP address of the webserver. At this point the web interface of Aspen can be accessed by going to
http://<the displayed IP>:8083 for the Aspen UI
http://<the displayed IP>:8084 for the Solr UI

