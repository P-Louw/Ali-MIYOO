FROM mcr.microsoft.com/dotnet/sdk:6.0.100-alpine3.14

# Args the set env variables, only added/used in case of manual launch dockerfile:
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


WORKDIR /scripts

# copy script files except the cron script:
COPY [^p]*  .
RUN chmod +x alistockcheck.fsx
RUN chmod +x *.sh

# Add cron job script:
COPY pollstore.sh /etc/periodic/10min/pollstore
RUN chmod +x /etc/periodic/10min/pollstore
# Using alpine so no need to redirect output cron to STDOUT and STDERR for docker log viewing.
RUN echo "*/10 * * * * run-parts /etc/periodic/10min" >> /etc/crontabs/root

# Start foreground cron:
ENTRYPOINT /scripts/entrypoint.sh

