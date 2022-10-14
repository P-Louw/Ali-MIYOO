# MIYOO-MINI notifier - Ali express

Check if stock for retro console has been filled.
If so receive e-mail.

Using a docker container to hold settings etc, so a few env variables have to be set on creation.

## Requirements

- Docker
- cron
- Linux machine

## Usage

1. Setup container

    There are a few required environment args that are set using --build-args.
    Before using you have to set these in the file 'enable_stockcheck.sh' file.
    See file for comments.
    
    *This has to be done here so we can access them for validating smtp mail on build!*
    
    during the image build a testmail will be sent to the smtp mail address mailbox.

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

2. Run setup script

    Run shell script that sets everything up.

    ```sh
    $ enable_stockcheck.sh
    # Create image.
    # Create container.
    # Adds cron job to user jobs.
    ```

    Using cron job from executing machine because containers exit without a main process.
    This can be done with Windows task scheduler as well but it's a hassle and inconsistent.

## Test mail

When the initial image is built a testmail is sent to the smtp address itself.
this is why whe need to set the env variables on build of the image itself.
The recipient mail can be left out on image build if you wanted. But if any of the others are missing it fails.

## Logging

just simple printing to stdout that can be read using docker.

```sh
$ docker logs miyoopol
# Show logs i.e. stdout messages
```
