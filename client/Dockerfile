FROM mcr.microsoft.com/dotnet/sdk:5.0
COPY .dotnet-completion.sh /root
COPY .pgpass /root
RUN apt-get update; \
    apt-get install bash-completion -y; \
    echo ". .dotnet-completion.sh" >> /root/.bashrc; \
    echo "export PATH=$PATH:~/.dotnet/tools" >> /root/.bashrc; \
    chmod go-rwx /root/.pgpass; \
    dotnet tool install --global dotnet-ef
