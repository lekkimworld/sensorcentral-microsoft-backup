DTSTAMP=`date "+%Y%m%d-%H%M"`
echo $POSTGRES_HOSTNAME:5432:$POSTGRES_USERNAME:$POSTGRES_USERNAME:$POSTGRES_PASSWORD > ~/.pgpass
chmod 600 ~/.pgpass
pg_dump -h $POSTGRES_HOSTNAME -U $POSTGRES_USERNAME --no-owner --no-acl $POSTGRES_DATABASE -Fc > /backup/dump.latest-$DTSTAMP

onedrive-uploader -c /settings/config.json upload /backup/dump.latest-$DTSTAMP "$MICROSOFT_PARENT_FOLDER_NAME"
rm /backup/dump.latest-$DTSTAMP
FILE_COUNT=`onedrive-uploader -c /settings/config.json ls "$MICROSOFT_PARENT_FOLDER_NAME" | wc -l`
echo "Found $FILE_COUNT file(s) on OneDrive - maximum is $MICROSOFT_NUMBER_FILES"

if [ $FILE_COUNT -gt $MICROSOFT_NUMBER_FILES ]; then
    FILE_DELETE=`onedrive-uploader -c /settings/config.json ls "$MICROSOFT_PARENT_FOLDER_NAME" | cut -c 3- | head -n1`
    onedrive-uploader -c /settings/config.json rm "${MICROSOFT_PARENT_FOLDER_NAME}/${FILE_DELETE}"
fi
