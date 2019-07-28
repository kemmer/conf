#!/bin/sh

# Folder to be backed up
SOURCE="$HOME/Files"

# Targets for fast and slow disk drives
TARGET_FAST="/run/media/crke/KENTUCKY"
TARGET_SLOW="/run/media/crke/PARUDO"

# The RECORD_ID
RECORD_ID=""


# Generate the RECORD_ID for this transaction, a number intended to uniquely 
# identify this batch of operations
generate_record_id()
{
    RECORD_ID=$(shuf -i 100000000-999999999 -n 1)
}

# Check if the tools provided in parameters are available to be executed in
# the shell
# Display error messages for each of not found command and terminates the
# execution with return code 1
check_prerequisite()
{
    local program_name="$1"
    local some_not_found=0
    while [ ! -z $program_name ]; do
        if [ ! -x "$(command -v $program_name)" ]; then
            some_not_found=1
            echo "[ERROR] -> $program_name is not available. Cannot proceed."
        fi

        shift
        program_name="$1"
    done

    if [ $some_not_found -eq 1 ]; then
        exit 1
    fi
}

# Check if the RECORD_ID variable was populated, otherwise we cannot proceed
check_record_id()
{
    if [ -z RECORD_ID ]; then
        echo "[ERROR] -> RECORD_ID was not generated. Cannot proceed."
        exit 1
    fi
}

# Performs a backup in the fast disk drive
backup_fast()
{
    check_record_id

    local status_borg=0
    local status_rsync=0

    echo && echo "[FAST][ID $RECORD_ID] -> Starting Borg backup to $TARGET_FAST"
    borg create --progress $TARGET_FAST/Borg::Files:$RECORD_ID:{user}@{hostname} $SOURCE
    status_borg=$?

    echo && echo "[FAST][ID $RECORD_ID] -> Starting rsync backup to $TARGET_FAST"
    rsync --info=progress2 -a $SOURCE $TARGET_FAST/NoBorg && echo "$RECORD_ID" >> $TARGET_FAST/NoBorg/info.txt
    status_rsync=$?

    if [ $status_borg -ne 0 -o $status_rsync -ne 0 ]; then
        echo "[FAST][ERROR] -> Some operations were not successfully performed. Please check output logs."
        return
    fi

    echo && echo "[FAST][ID $RECORD_ID] -> Backup done for $TARGET_FAST"
}

# Performs a backup in the slow disk drive
backup_slow()
{
    check_record_id

    local status_borg=0
    local status_rsync=0

    echo && echo "[SLOW][ID $RECORD_ID] -> Starting Borg backup to $TARGET_SLOW"
    borg create --progress $TARGET_SLOW/Borg::Files:$RECORD_ID:{user}@{hostname} $SOURCE
    status_borg=$?

    echo && echo "[SLOW][ID $RECORD_ID] -> Starting rsync backup to $TARGET_SLOW"
    rsync --info=progress2 -a $SOURCE $TARGET_SLOW/NoBorg && echo "$RECORD_ID" >> $TARGET_FAST/NoBorg/info.txt
    status_rsync=$?

    if [ $status_borg -ne 0 -o $status_rsync -ne 0 ]; then
        echo "[FAST][ERROR] -> Some operations were not successfully performed. Please check output logs."
        return
    fi

    echo && echo "[SLOW][ID $RECORD_ID] -> Backup done for $TARGET_SLOW"
}

main()
{
    local backups_performed=0
    local run_fast=0
    local run_slow=0

    while [ $# -ne 0 ]; do
        case "$1" in
            --fast) run_fast=1 ;;
            --slow) run_slow=1 ;;
        esac

        shift
    done

    if [ $run_fast -eq 1 ]; then
        backups_performed=1
        backup_fast
    fi

    if [ $run_slow -eq 1 ]; then
        backups_performed=1
        backup_slow
    fi

    if [ $backups_performed -eq 0 ]; then
        echo "[INFO] -> No backups performed!"
    fi
}

check_prerequisite borg rsync shuf
generate_record_id
main $@

