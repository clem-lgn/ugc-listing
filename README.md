# ugc-listing

Plugin Claude Code : un lien de profil de créateur UGC devient une fiche dans ta base créateurs Notion et une fiche dans le listing UGC de ton client.

## Ce que ça fait

Tu colles un lien de profil (Fiverr, Canva, Youdji, site perso) et le nom du client. Claude :

1. récupère le nom, ce que le profil expose et 2 vidéos du portfolio ;
2. te montre ce qu'il a trouvé et attend ton oui ;
3. retrouve ou crée la fiche du créateur dans ta base créateurs Notion ;
4. ajoute le créateur au listing du client (2 vidéos, `Validation` à `?`).

## Installer

Dans Claude Code :

```
/plugin marketplace add clem-lgn/ugc-listing
/plugin install ugc@ugc-tools
```

Redémarre Claude Code, puis lance le skill une première fois.

## Premier lancement

Tu n'as rien à préparer : **Claude vérifie ta machine et te guide** pour ce qui manque.

| Prérequis | Qui s'en charge |
|---|---|
| yt-dlp et ffmpeg (récupérer les vidéos) | Claude les installe, avec ton accord |
| Homebrew (installeur Mac, s'il manque) | toi, une commande à coller dans Terminal (Claude te la donne) |
| Extension Claude in Chrome | toi, en 3 clics (Claude te donne le lien et les étapes) |
| Liens Notion (base créateurs, listings clients) | toi, Claude te les demande une fois et les garde sur ta machine |

Claude in Chrome demande un abonnement Claude Pro, Max, Team ou Enterprise.

## Utiliser

```
/ugc:listing https://www.fiverr.com/... pour <client>
```

ou simplement : « ajoute ce créateur au listing <client> » + le lien. Nouveau client : « ajoute le client X » + le lien de sa page listing.

Mise à jour du plugin : `/plugin marketplace update ugc-tools`.
