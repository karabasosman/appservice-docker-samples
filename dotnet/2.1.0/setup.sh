#!/usr/bin/env bash
cat /etc/motd
echo running
service ssh start

[ -z "$ASPNETCORE_URLS" ] && export ASPNETCORE_URLS=http://*:"$PORT"
cd /app
exec dotnet HelloWorld.dll