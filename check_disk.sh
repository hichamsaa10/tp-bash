#!/bin/bash
# Alerte si l'espace disque utilisé dépasse un seuil (80% par défaut)

SEUIL=${1:-80}
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : disque utilisé à ${UTILISATION}% (seuil : ${SEUIL}%)"
    exit 1
fi

echo "OK : disque utilisé à ${UTILISATION}% (seuil : ${SEUIL}%)"
exit 0
