ARG ASPNETCORE_ENVIRONMENT=production

# --------
#  STEP 1 - Building app
# --------
# Install .NET Core SDK docker container
FROM microsoft/dotnet:2.1-sdk AS build-env

# Create app directory
WORKDIR /app

# Install app dependencies
COPY src .

# Copy build output
RUN dotnet publish --configuration Release  --output /out

FROM microsoft/dotnet:2.1-aspnetcore-runtime

ENV ASPNETCORE_URLS http://+:5000

# Copy shell script
COPY setup.sh /bin/
# Copy build output 
COPY --from=build-env /out /app/


RUN apt-get update && \
    apt-get install -y nginx

RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx

WORKDIR /app
EXPOSE 5000 80
ENTRYPOINT ["/bin/setup.sh"]