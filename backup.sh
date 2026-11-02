
#!/bin/bash

set -Eeuo pipefail

DOSSIER="${1:-$HOME/tp-bash/data}"
DESTINATION="$HOME/tp-bash/backups"
DATE=$(date +"%Y%m%d_%H%M%S")

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier n'existe pas."
    exit 1
fi

mkdir -p "$DESTINATION"

ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

tar -czf "$ARCHIVE" -C "$DOSSIER" .

echo "Sauvegarde créée : $ARCHIVE"

find "$DESTINATION" -type f -name "backup_*.tar.gz" -mtime +7 -delete

echo "Nettoyage des anciennes sauvegardes terminé."
