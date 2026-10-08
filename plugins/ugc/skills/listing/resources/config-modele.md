# Config : modèle

Les adresses Notion ne sont **pas** dans ce repo. Chaque personne a sa config, sur sa machine, dans le dossier de données du plugin (`config.md`, chemin donné par le check de `SKILL.md`). Elle se remplit au premier lancement (`installation.md`, étape 3) en posant les questions ci-dessous, une à la fois.

## Questions à poser

1. « Colle le lien de la base Notion des créateurs UGC (celle où chaque créateur a sa fiche). »
2. « Y a-t-il une deuxième base créateurs plus ancienne à vérifier avant de créer une fiche ? Si oui, colle son lien, sinon dis non. »
3. Pour chaque client : « Nom du client, lien de sa page listing UGC, et langue de la fiche (anglais par défaut). » Continuer jusqu'à ce que la personne dise qu'il n'y en a plus.

Vérifier chaque lien en l'ouvrant dans Chrome avant de l'écrire.

## Fichier à écrire

```markdown
# Config listing UGC

## Base créateurs
- Principale : <lien>
- Ancienne (à vérifier aussi) : <lien ou « aucune »>

## Listings clients
| Client | Page listing | Langue |
|---|---|---|
| <Client> | <lien> | <anglais> |
```

Ajouter un client plus tard : la personne dit « ajoute le client X » avec le lien, on ajoute la ligne.

## Format client

La fiche est **dans la langue du client** (colonne Langue).

| Ligne | Contenu |
|---|---|
| Name | prénom + initiale du nom (`Prénom N.`) |
| Notes | vide à l'insertion |
| Profile | **mention Notion** vers la fiche du créateur dans la base créateurs |
| Validation | `?`, ligne grisée |

À droite, un toggle **« UGC examples »** avec 2 vidéos. La fiche se pose sous la dernière fiche de la section « Creator to validate ».

## Base créateurs

- Avant de créer une fiche, chercher le nom par la recherche globale Notion (`cmd+k`), qui couvre la base principale et l'ancienne.
- **Absent** → bouton `New` dans la base principale, titre = nom affiché, puis les propriétés que le profil public expose (genre, langue maternelle, ville et pays, lien du portfolio). Jamais de valeur devinée.
- **Doublons** (même nom, deux fiches) : la recherche `@` ne dit pas laquelle est la bonne. Prendre l'URL exacte de la page voulue, `pbcopy`, coller dans la cellule `Profile`, choisir **Mention**.
