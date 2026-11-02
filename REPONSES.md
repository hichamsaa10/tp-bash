  reponse au qst de reflexion :
1/
La commande chmod 644 donne les permissions suivantes :

6 pour le propriétaire : lecture (4) et écriture (2).

4 pour le groupe : lecture uniquement.

4 pour les autres utilisateurs : lecture uniquement.

Cela correspond aux permissions rw-r--r--.

Le fichier n'est donc pas exécutable par son propriétaire, car le droit d'exécution (1) n'est pas accordé.
2/
On utilise les guillemets autour de "$UTILISATION" pour protéger la valeur de la variable et éviter les problèmes liés à la séparation des mots et à l'expansion des caractères spéciaux.

Ils permettent également de traiter la variable comme un seul argument, même si elle est vide ou contient des espaces.

Cela rend le test conditionnel plus fiable et évite certaines erreurs d'exécution.
3/
Sans set -Eeuo pipefail, Bash ne s'arrête pas automatiquement lorsqu'une commande échoue. Il peut donc exécuter les instructions suivantes et afficher un message indiquant que la sauvegarde est terminée, alors que l'archive n'a pas été créée correctement.

Cette instruction permet une meilleure gestion des erreurs :

-e : arrête le script lorsqu'une commande échoue dans un contexte où cette option s'applique.

-E : permet de transmettre le comportement du piège ERR aux fonctions et sous-shells.

-u : signale l'utilisation d'une variable non définie.

pipefail : permet de détecter l'échec d'une commande dans un pipeline.

Ainsi, cette instruction rend le script plus fiable.
4/
Cron exécute les tâches automatiquement dans un environnement différent de celui du terminal interactif.

Il ne garantit pas que le répertoire courant soit celui du projet et son environnement, notamment la variable PATH, peut être limité.

Les chemins absolus permettent donc d'indiquer précisément l'emplacement des scripts et des fichiers.

Par exemple :

/home/hiichaam10/tp-bash/backup.sh

Cela garantit que cron trouve correctement le script à exécuter.
5/
Question 1 : Quelles étapes ajouteriez-vous pour transformer ce script en un vrai pipeline CI ?

Pour transformer ce script en un véritable pipeline CI, on peut ajouter plusieurs étapes :

Installer automatiquement les dépendances du projet.

Exécuter les tests unitaires.

Effectuer les tests d'intégration.

Vérifier la qualité et la sécurité du code.

Construire (build) l'application.

Générer et conserver les rapports de tests.

Déployer automatiquement l'application si toutes les étapes précédentes réussissent.

Question 2 : Quels seraient les points de défaillance à gérer avec des codes de retour ?

Les principaux points de défaillance sont :

Échec du clonage ou de la mise à jour du dépôt Git.

Absence de fichiers nécessaires au projet.

Échec de l'installation des dépendances.

Erreurs de syntaxe dans le code.

Échec des tests unitaires ou d'intégration.

Échec de la construction de l'application.

Échec du déploiement.

Chaque étape doit retourner un code de sortie explicite :

0 signifie que l'opération a réussi.

Une valeur différente de 0 indique qu'une erreur s'est produite.

Ces codes permettent au pipeline de détecter les erreurs et d'éviter de poursuivre inutilement les étapes suivantes.

