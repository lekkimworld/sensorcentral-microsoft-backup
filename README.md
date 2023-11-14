# sensorcentral-backup-onedrive #
Docker image used to backup the sensorcentral database and upload to Microsoft OneDrive. The backup 
is performed with `pg_dump` and creates a compressed backup called `dump.latest-YYYYMMDD` in `/backup`. Once the backup completes the backup is copied to Microsoft OneDrive.

## Environment variables ##
* POSTGRES_HOSTNAME
* POSTGRES_USERNAME
* POSTGRES_PASSWORD
* POSTGRES_DATABASE
* MICROSOFT_FOLDER_NAME
* MICROSOFT_CONFIG_FILE (defaults to `/settings/config.json`)
* MICROSOFT_NUMBER_FILES (number of files to keep in the folder)

## Building docker image ##
```
docker build --tag lekkim/sensorcentral-backup-onedrive .
```

## Running with docker ##
```
docker run --rm --env-file ./.env -v /tmp:/backup -v ${PWD}/config.json:/settings/config.json lekkim/sensorcentral-backup-onedrive
```

## Run bash in containr ##
```
docker run -it --rm --entrypoint=bash --env-file ./.env -v /tmp:/backup -v ${PWD}/config.json:/settings/config.json lekkim/sensorcentral-backup-microsoft
```