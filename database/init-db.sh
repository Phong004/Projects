#!/bin/bash

SQLCMD="/opt/mssql-tools18/bin/sqlcmd"

echo "WAITING FOR SQL SERVER TO START ... "

until $SQLCMD -S "$DB_HOST" -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" &> /dev/null
do
    echo "SQL Server is starting up ..."
    sleep 2
done

echo "SQL Server is UP ..."

$SQLCMD -S "$DB_HOST" -U sa -P $SA_PASSWORD \
    -v DB_USER="$DB_USER" DB_PASS="$DB_PASSWORD" -C -d master -i "/data/application/init.sql"

echo "SQL SERVER INITIALIZED"