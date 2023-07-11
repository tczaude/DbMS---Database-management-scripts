#!/bin/bash

### Create base user for backups
### 
### CREATE USER 'backup'@'localhost' IDENTIFIED BY 'backup';
### GRANT RELOAD, PROCESS, LOCK TABLES, BINLOG MONITOR ON *.* TO 'backup'@'localhost';
### 

### The user account information can be specified with the --user and --password command-line options. For example:

### $ mariabackup --backup \
###    --target-dir=/var/mariadb/backup/ \
###    --user=mariabackup --password=mypassword

### The user account information can also be specified in a supported client option group in an option file. For example:

### [mariabackup]
### user=mariabackup
### password=mypassword

### Mariabackup does not need to authenticate with the database server when preparing or restoring a backup.

# Init vars

DB_USER="UserName"
DB_PASSWORD="Password"
DB_NAME=""
BACKUP_DIR="/mnt/backup/mysql/current"
LOCK_FILE="/tmp/backup.lock"

# Sprawdzenie czy istnieje plik blokady
check_lock_file() {
  if [ -f "${LOCK_FILE}" ]; then
    echo "Inny proces backupu jest ju¿ uruchomiony. Wyjœcie."
    exit 1
  fi
}

# Tworzenie pliku blokady
create_lock_file() {
  touch "${LOCK_FILE}"
}

# Ustalenie daty i czasu
DATE_FULL=$(date +"%Y-%m-%d")
DATE_INC=$(date +"%Y-%m-%d_%H:%M:%S")

# Pe³ny backup - nowy dzieñ
perform_full_backup() {
  BACKUP_DIR_FULL="${BACKUP_DIR}/${DATE_FULL}_full"

  mariabackup --user="${DB_USER}" --password="${DB_PASSWORD}" --target-dir="${BACKUP_DIR_FULL}" --backup

  echo "Wykonano pe³ny backup: ${BACKUP_DIR_FULL}"
}

# Przyrostowy backup
perform_incremental_backup() {
  BACKUP_DIR_INCR="${BACKUP_DIR}/${DATE_INC}_incr"
  LATEST_FULL_BACKUP=$(find "${BACKUP_DIR}" -maxdepth 1 -name "*_full" -type d | sort | tail -n 1)

  mariabackup --user="${DB_USER}" --password="${DB_PASSWORD}" --target-dir="${BACKUP_DIR_INCR}" --incremental --incremental-basedir="${LATEST_FULL_BACKUP}"

  echo "Wykonano przyrostowy backup: ${BACKUP_DIR_INCR}"
}

# Usuniêcie pliku blokady po zakoñczeniu skryptu

remove_lock_file() {
  rm "${LOCK_FILE}"
}

# Planowane zadania

# Sprawdzenie czy istnieje plik blokady
check_lock_file

# Tworzenie pliku blokady
create_lock_file

# Sprawdzenie, czy mamy nowy dzieñ
LAST_FULL_BACKUP_DATE=""
if [ -d "${BACKUP_DIR}" ]; then
  LAST_FULL_BACKUP=$(find "${BACKUP_DIR}" -maxdepth 1 -name "*_full" -type d | sort | tail -n 1)
  if [ -n "${LAST_FULL_BACKUP}" ]; then
    LAST_FULL_BACKUP_DATE=$(basename "${LAST_FULL_BACKUP}" | cut -d'_' -f1)
  fi
fi

# Pe³ny backup - nowy dzieñ
if [ "${DATE_FULL}" != "${LAST_FULL_BACKUP_DATE}" ]; then
  perform_full_backup
else
  # Przyrostowy backup
  perform_incremental_backup
fi

# Usuniêcie pliku blokady po zakoñczeniu skryptu
remove_lock_file