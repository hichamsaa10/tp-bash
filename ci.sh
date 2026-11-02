
#!/bin/bash
set -Eeuo pipefail

# 1. Recuperer l'URL du depot
REPO_URL="${1:-}"

# Dossier de travail et fichier journal
WORK_DIR="$HOME/tp-bash-ci"
LOG_FILE="$HOME/tp-bash/ci.log"

mkdir -p "$(dirname "$LOG_FILE")"

# Fonction de journalisation
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Gestion des erreurs
trap 'log "ERREUR : une commande a echoue."' ERR

# 2. Verifier l'argument
if [ -z "$REPO_URL" ]; then
    log "ERREUR : veuillez fournir l'URL du depot Git."
    exit 1
fi

log "Debut du pipeline CI."

# 3. Cloner ou mettre a jour le depot
if [ -d "$WORK_DIR/.git" ]; then
    log "Depot deja present : mise a jour."
    git -C "$WORK_DIR" pull --ff-only
else
    if [ -e "$WORK_DIR" ]; then
        log "ERREUR : le dossier existe mais n'est pas un depot Git."
        exit 1
    fi

    log "Clonage du depot Git."
    git clone "$REPO_URL" "$WORK_DIR"
fi

# 4. Fonction qui execute les tests
run_tests() {
    log "Debut des tests."

    for fichier in README.md check_disk.sh backup.sh ci.sh; do
        if [ ! -f "$WORK_DIR/$fichier" ]; then
            log "ECHEC : fichier manquant : $fichier"
            return 1
        fi
    done

    log "Verification de la syntaxe Bash."

    for fichier in check_disk.sh backup.sh ci.sh; do
        bash -n "$WORK_DIR/$fichier"
    done

    log "Tous les tests sont reussis."
}

# 5. Executer les tests
if run_tests; then
    log "PIPELINE CI : SUCCES."
    exit 0
else
    log "PIPELINE CI : ECHEC."
    exit 1
fi
