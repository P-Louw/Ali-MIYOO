# MIYOO-MINI notifier - Ali express

Check if stock for retro console has been filled.
If so receive e-mail. The request method is naive in the sense that it
does no effort to be anonymous. Overuse or any other issues will prevent you from viewing the page.

Using a docker container to hold settings etc, so a few env variables have to be set on creation.

## Requirements

- Docker
- docker-compose (optional)

## Usage

There are a few required environment args that are set using env variables.
These have to be set in the 'miyoo.env' file. Alternatively you can
use the dockerfile directly and set those use '--build-arg' or in the dockerfile.

**Using docker-compose**

```shell
$ docker-compose up --build -d
# Build compose file without watching output after '-d'.
```

**Using dockerfile**

Set env variables using multiple '--build-arg' or in dockerfile.
From the directory that contains the dockerfile.

```docker
docker build \
-t miyooali
--build-arg mail="smtpsender@mail.com" \
--build-arg server="smtphost.mail.com" \
--build-arg port=587 \
--build-arg password="smtpmailpassword" \
--build-arg recipient="myemail@mail.com" \
--no-cache .
```

## Test mail

When the container starts a testmail is sent to the smtp address itself.

## Logging

Just simple printing to stdout that can be read using docker.

```sh
$ docker --follow logs miyoopol
# Tracks logs i.e. stdout messages
```
