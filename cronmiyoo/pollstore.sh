#!/bin/sh

# Can't launch script from cron folder because bash work with -S not sh.
dotnet fsi /scripts/alistockcheck.fsx