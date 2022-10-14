FROM mcr.microsoft.com/dotnet/sdk:6.0

# Used to set environment variables for smtp server
ARG mail
ARG server
ARG password
ARG port=25

ARG recipient

ENV mail = ${mail}
ENV server = ${server}
ENV password = ${password}
ENV port = ${port}
ENV recipient = ${recipient}

WORKDIR /scripts

COPY ./alistockcheck.fsx .
COPY ./check_stock.sh .

RUN chmod +x alistockcheck.fsx
RUN chmod +x check_stock.sh

RUN apt-get update
RUN apt-get -y install cron

RUN [ "/scripts/check_stock.sh"]
RUN [ "/scripts/alistockcheck.fsx"]

