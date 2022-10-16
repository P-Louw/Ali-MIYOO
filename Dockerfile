FROM mcr.microsoft.com/dotnet/sdk:6.0

# Optional, used to set environment variables for smtp server
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

COPY ./alistockcheck.fsx .

RUN chmod +x alistockcheck.fsx

# Send a test email on creation:
RUN [ "dotnet", "fsi", "/scripts/alistockcheck.fsx", "testmail" ]
# Check stocks:
ENTRYPOINT [ "dotnet", "fsi", "/scripts/alistockcheck.fsx" ]

