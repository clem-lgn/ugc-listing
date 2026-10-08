# Installation : vérifier et guider

Se lit à chaque lancement, avant tout travail. Le but : la personne n'a rien à préparer seule ; Claude vérifie, installe ce qu'il peut, et donne pas à pas le reste. Parler simplement, une étape à la fois, attendre que la personne dise « c'est fait » avant de revérifier.

## 1. Outils locaux (yt-dlp, ffmpeg)

Le check de `SKILL.md` (étape 0) donne une ligne par élément.

- **Tout est OK** → passer à l'étape 2 sans rien dire.
- **yt-dlp ou ffmpeg MANQUE, brew OK** → dire en une phrase ce qui manque et à quoi ça sert (« récupérer les vidéos du portfolio »), demander son accord, puis lancer soi-même `brew install yt-dlp ffmpeg` (quelques minutes). Relancer le check.
- **brew MANQUE (Mac)** → Homebrew demande le mot de passe de l'ordinateur, Claude ne peut pas l'installer lui-même. Donner cette marche à suivre :
  1. Ouvrir l'app **Terminal** (cmd + espace, taper « Terminal »).
  2. Coller la commande ci-dessous, Entrée, taper le mot de passe de l'ordinateur quand il le demande (rien ne s'affiche pendant la frappe, c'est normal) :
     ```
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```
  3. À la fin, Homebrew affiche « Next steps » avec deux ou trois lignes à copier-coller : les lancer aussi.
  4. Revenir ici et dire « c'est fait ». Claude relance alors le check, puis installe yt-dlp et ffmpeg.
- **Windows** → proposer de lancer `winget install yt-dlp.yt-dlp Gyan.FFmpeg`, puis de redémarrer Claude Code pour que les outils soient trouvés.

## 2. Claude in Chrome

Tester : les outils `mcp__claude-in-chrome__*` sont-ils disponibles, et `list_connected_browsers` renvoie-t-il un navigateur ?

- **Oui** → étape 3.
- **Non** → donner cette marche à suivre :
  1. Installer l'extension **Claude** dans Google Chrome : https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn
  2. Cliquer sur l'icône de l'extension (pièce de puzzle en haut à droite de Chrome, puis épingler Claude) et se connecter avec **le même compte Claude** que Claude Code.
  3. Dans Claude Code, taper `/chrome` et choisir **Enable by default** (une fois pour toutes). En ligne de commande, on peut aussi relancer avec `claude --chrome`.
  4. Revenir ici et dire « c'est fait ». Claude reteste.
- **Extension installée mais pas de navigateur connecté** → `/chrome` puis **Reconnect extension**, Chrome ouvert.
- Il faut un abonnement Claude Pro, Max, Team ou Enterprise.

## 3. Notion et config

- **Ligne `MANQUE config`** → premier lancement : poser les questions de `config-modele.md`, une à la fois, ouvrir chaque lien dans Chrome pour le vérifier, puis écrire le fichier à l'emplacement donné par le check (créer le dossier s'il n'existe pas).
- Ouvrir dans Chrome la base créateurs (lien de la config) et faire une capture.
  - **La base s'affiche** → installation terminée, lancer le travail demandé.
  - **Page de connexion ou « pas d'accès »** → demander de se connecter à Notion dans **ce** Chrome avec son compte de travail, puis de dire « c'est fait ».

## 4. Premier téléchargement Canva ou site perso (Mac)

`yt-dlp --cookies-from-browser chrome` fait apparaître une fenêtre macOS « yt-dlp souhaite accéder à Chrome Safe Storage ». Prévenir avant le premier lancement : taper le mot de passe de l'ordinateur et cliquer **Toujours autoriser**, sinon le téléchargement échoue.
