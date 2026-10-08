---
name: listing
allowed-tools: Bash(bash ${CLAUDE_SKILL_DIR}/scripts/check-setup.sh *)
description: "À partir d'un lien de profil de créateur UGC (Fiverr, Canva, Youdji, site perso), crée ou retrouve sa fiche dans la base créateurs Notion, puis l'ajoute avec 2 vidéos d'exemple au listing UGC d'un client. Tout passe par Claude in Chrome. Utiliser quand l'utilisateur dit '/ugc:listing', 'ajoute ce créateur', 'listing ugc', 'propose ce créateur à <client>', 'ajoute le client X au listing', ou colle un lien de profil Fiverr / Youdji / Canva en demandant de l'ajouter à un listing. Hors scope : chercher des créateurs (sourcing), caster un créateur sur une carte de production."
---

# Listing UGC

Un lien de profil de créateur → (1) sa fiche dans la **base créateurs** Notion, (2) sa fiche au **format client** dans le listing UGC du client, avec 2 vidéos d'exemple. Le client lit cette fiche pour choisir ses créateurs.

## Étape 0 : installation (à chaque lancement)

Avant tout travail, vérifier que la machine est prête :

```bash
bash ${CLAUDE_SKILL_DIR}/scripts/check-setup.sh "${CLAUDE_PLUGIN_DATA}"
```

Tout est OK → enchaîner sans commentaire. Une ligne MANQUE → suivre `resources/installation.md` : installer soi-même ce qui peut l'être (avec l'accord de la personne), donner pas à pas les instructions pour le reste, revérifier, puis reprendre la demande là où elle en était.

La config de la personne (base créateurs, pages listing des clients) vit dans `${CLAUDE_PLUGIN_DATA}/config.md`, jamais dans le plugin. Modèle et questions : `resources/config-modele.md`.

## Entrée

Un ou plusieurs liens de profil + le **client** visé. Client non précisé → le demander. Client absent de la config → demander le lien de sa page listing et l'ajouter à la config. Plusieurs liens = une fiche par créateur.

## Flux

1. **Lire** `${CLAUDE_PLUGIN_DATA}/config.md`, `resources/config-modele.md` (format client, base créateurs) et `resources/methode-chrome.md` (gestes Notion validés).
2. **Extraire** depuis le lien : nom affiché, ce que le profil public expose (genre, langue maternelle, ville et pays), URL du profil, URL des vidéos du portfolio. Méthode par plateforme : `resources/sources.md`.
3. **Télécharger 2 vidéos** représentatives dans `~/Downloads/ugc-listing/<slug-createur>/`. Chaque fichier doit faire moins de 10 Mo ; sinon réencoder en 960p (`resources/sources.md`, fin).
4. **Montrer l'extraction** en chat (nom, champs, 2 vidéos choisies, client visé) et attendre le oui avant d'écrire dans Notion.
5. **Base créateurs** : chercher le créateur (`cmd+k`). Présent → garder sa fiche et noter son URL. Absent → la créer.
6. **Listing client** : ajouter la fiche au format client sous la dernière fiche de « Creator to validate », `Profile` = mention vers la fiche de la base créateurs, puis les 2 vidéos dans le toggle « UGC examples ».
7. **Vérifier** par une capture du listing : tableau rempli, mention cliquable, 2 vidéos qui se lisent.
8. **Reporter** en chat : lien du listing, lien de la fiche dans la base, ce qui manquait sur le profil.

## Règles

- **Jamais de valeur devinée.** Un champ que le profil n'expose pas reste vide, et on le dit dans le compte rendu.
- **La fiche client ne contient que ce qui aide le client à choisir** : pas d'adresse, pas d'email, pas de lien Fiverr / Canva / Youdji (ces liens vont dans la base créateurs).
- **`Validation` reste `?`** : c'est le client qui tranche.
- **Ne jamais archiver une fiche de la base qui a des backlinks** (reliée à d'autres pages) : on aligne ses champs, on ne fusionne pas.
- **Ne jamais cliquer dans une cellule qui contient une mention** : le clic ouvre la page liée et la frappe suivante écrase son titre.
