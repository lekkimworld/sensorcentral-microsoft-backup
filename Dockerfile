FROM golang:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y lsb-release
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install postgresql-client-15 git -y

WORKDIR /app
RUN git clone https://github.com/virtualzone/onedrive-uploader.git
RUN cd onedrive-uploader && make 
RUN cp onedrive-uploader/build/onedrive-uploader_linux_amd64_v0.* /usr/bin/onedrive-uploader && rm -rf onedrive-uploader
COPY entrypoint.sh .
ENTRYPOINT "/app/entrypoint.sh"
