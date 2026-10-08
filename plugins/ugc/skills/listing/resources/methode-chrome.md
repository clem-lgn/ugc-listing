# Méthode Chrome dans Notion (validée sur une première série de 8 fiches)

## Poser la fiche

- **Créateur déjà dans le listing d'un autre client** : sélectionner sa fiche par la poignée, `cmd+c`, coller sous la dernière fiche de « Creator to validate » (vidéos comprises), puis la mettre au format client.
- **Nouveau créateur** : dupliquer une fiche déjà au format client (`cmd+d`), renommer, remplacer `Name` et `Profile`, vider « UGC examples », puis y ajouter les vidéos.
- **Mettre une ancienne fiche au format** : supprimer des lignes de tableau par le navigateur n'est pas fiable (le menu de ligne s'ouvre sur la mauvaise ligne). Copier le tableau d'une fiche déjà au format (poignée `⋮⋮` du bloc → `Échap` → `cmd+c`), sélectionner l'ancien tableau par sa poignée, `cmd+v` (colle dessous), supprimer l'ancien (poignée → Delete, vérifier le nombre de mots indiqué dans le menu), puis changer `Name` et `Profile`.
- **Plusieurs fiches** : poser d'abord tous les tableaux (le presse-papiers garde le modèle), puis tous les raccourcis (chaque `pbcopy` d'URL écrase le modèle). Recopier le modèle juste avant de coller : le presse-papiers a pu changer entre-temps.

## Le raccourci `Profile`

- Cellule vide, au milieu de l'écran, `cmd+v`, attendre le menu « Paste as », `Entrée` sur **Mention**. Si la cellule affiche l'URL en clair, le menu n'est pas venu : effacer au `Backspace` et recoller.
- **Ne jamais cliquer sur une cellule qui contient une mention** : le clic ouvre la page liée et la frappe suivante écrase son titre. Entrer dans la cellule vide `Notes`, puis `Tab` `Tab` jusqu'à `Profile`.

## Les vidéos

- Curseur en fin du titre « UGC examples » → `Entrée` → `/video`. Cliquer dans le vide du toggle crée le bloc hors de la fiche.
- **Upload sans sélecteur de fichier** : avant de cliquer « Choose a video », intercepter `HTMLInputElement.prototype.click` pour accrocher l'input `file` au DOM, puis `file_upload` sur sa ref.
- Fichiers < 10 Mo, 2 vidéos par créateur suffisent.

## Divers

- **Titre de toggle** : `cmd+a` ne sélectionne pas le titre ; se placer en fin de texte et effacer au `Backspace` le nombre exact de caractères.
- **Coordonnées** : après tout changement de page ou de scroll, reprendre une capture avant de cliquer.
