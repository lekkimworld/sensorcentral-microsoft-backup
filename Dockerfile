FROM golang:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y lsb-release curl
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install postgresql-client-15 git -y

WORKDIR /app
RUN curl -s -L https://git.io/JRie0 | bash
COPY entrypoint.sh .
ENTRYPOINT ["/app/entrypoint.sh"]
