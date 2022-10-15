FROM mcr.microsoft.com/dotnet/sdk:6.0.100-alpine3.14

# Args the set env variables, only added in case of manual launc dockerfile:
ARG mail
ARG server
ARG password
ARG port

ARG recipient

ENV mail ${mail}
ENV server ${server}
ENV password ${password}
ENV port ${port}
ENV recipient ${recipient}

#RUN apk add firefox-esr

WORKDIR /scripts

# copy script files except the cron script:
COPY [^p]*  .
RUN chmod +x alistockcheck.fsx
RUN chmod +x *.sh
RUN ls
# Add cron job script:
COPY pollstore.sh /etc/periodic/10min/pollstore
RUN chmod +x /etc/periodic/10min/pollstore
# No need to redirect output alpine write cron to STDOUT and STDERR so viewable in docker logs.
RUN echo "*/10 * * * * run-parts /etc/periodic/10min" >> /etc/crontabs/root

# Send a test email on creation:
RUN [ "dotnet", "fsi", "/scripts/alistockcheck.fsx", "testmail" ]

# Start foreground cron:
ENTRYPOINT /scripts/entrypoint.sh

