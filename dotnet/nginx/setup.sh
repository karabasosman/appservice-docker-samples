#!/bin/bash
service nginx start
cd /app
exec dotnet HelloWorld.dll