ARG ASPNETCORE_ENVIRONMENT=production

# --------
#  STEP 1 - Building app
# --------
# Install .NET Core SDK docker container
FROM microsoft/dotnet:2.2-sdk AS build-env

# Create app directory
WORKDIR /app

# Install app dependencies
COPY src .

# Copy build output
RUN dotnet publish --configuration Release  --output /out

# --------
#  STEP 2 - Configuring environment
# --------


# Install .NET Core Runtime docker container
FROM microsoft/dotnet:2.2-aspnetcore-runtime

# Copy SSH config 
COPY sshd_config /etc/ssh/
# Copy shell script
COPY setup.sh /bin/ 
# Copy build output 
COPY --from=build-env /out /app/

# Install required packages and give permission 
RUN apt-get update \
  && apt-get install -y apt-utils --no-install-recommends \
  && echo "root:Docker!" | chpasswd \
  && echo "cd /home" >> /etc/bash.bashrc \
  && apt update \
  && apt install -y --no-install-recommends openssh-server vim curl wget tcptraceroute \
  && chmod 755 /bin/setup.sh \
  && mkdir -p /home/LogFiles/

# Ports
EXPOSE 2222 8080

# Configure environment
ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/app
ENV ASPNETCORE_ENVIRONMENT=$ASPNETCORE_ENVIRONMENT
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
ENV ASPNETCORE_URLS=

WORKDIR /app

ENTRYPOINT ["/bin/setup.sh"]
