# Extraire un profil et télécharger ses vidéos, par plateforme

Ce qu'on cherche partout : **nom affiché**, ce que le profil expose (genre, langue maternelle, ville et pays), **URL du profil** (sans query string), **URL réelle des vidéos**. Destination des vidéos : `~/Downloads/ugc-listing/<slug-createur>/<slug>-01.mp4`, `-02.mp4`.

Garde-fous Chrome communs :
- Retirer les query strings des URL avant de les renvoyer (`u.split('?')[0]`) : une URL à jeton fait bloquer la sortie JS.
- `javascript_tool` : éviter les IIFE `async` (la promesse revient vide) ; faire des appels synchrones séparés.
- **Ne jamais reconstruire une URL vidéo à la main** : lire la `src` réelle du `<video>` et télécharger cette URL exacte.

## Fiverr (`fiverr.com`)

- `WebFetch` renvoie 403 : aller directement en Chrome (`navigate`, `get_page_text`, capture du header et de « À propos de ce service »).
- Nom = nom affiché seul (« Prénom N. »), sans @handle. La ville n'est pas exposée sur les gigs Pro. Le champ « Créateur » (Homme/Femme) est un attribut du gig, pas forcément le genre de la personne : ne pas s'en servir pour `Gender`.
- Vidéos servies par Cloudinary (publiques, stables). Dans l'onglet du gig :

```js
(() => {
  const set = new Set();
  document.querySelectorAll('video').forEach(v => { const s=v.currentSrc||v.src; if(s) set.add(s); });
  const re = /https?:\/\/fiverr-res\.cloudinary\.com\/video\/upload\/[^"'\\\s]+/gi;
  const html = document.documentElement.innerHTML; let m;
  while ((m = re.exec(html))) set.add(m[0]);
  const vids = [...set].filter(u => /project_item|seller_intro_video/.test(u) && !/\.png(\?|$)/i.test(u) && !/icon|guarantee/i.test(u));
  const byId = {}; vids.forEach(u => { const id=(u.match(/attachment\/([a-f0-9]+-\d+)/)||[])[1]||u; if(!byId[id]) byId[id]=u; });
  return Object.values(byId);
})()
```

`project_item` = portfolio (à prendre), `seller_intro_video` = intro du vendeur. Ajouter `.mp4` à l'URL, puis `curl -sL -o <fichier> "<url>.mp4"`.

## Canva (`my.canva.site`)

- Nom = `document.title`. Marques citées et niches lisibles dans la page.
- Vidéos en lazy-load : scroller jusqu'en bas avec l'action `scroll` du navigateur (le JS `window.scrollTo` est inerte, le scroll passe par un conteneur interne).
- Sur certains sites le `<video>` n'apparaît qu'au **clic play** sur la vignette : un clic = un `<video>`, relire les `src` après chaque clic.
- Le chemin vidéo est souvent préfixé par le slug de page (`/<page-slug>/_assets/video/<hash>.mp4`). D'où la règle : lire `document.querySelector('video').src.split('?')[0]` après le clic, jamais deviner.
- Download, une vidéo à la fois (le batch verrouille les cookies) :

```bash
yt-dlp --cookies-from-browser chrome --referer "<url-du-site>" -o "<fichier>.mp4" "<url-video>"
```

## Youdji (`youdji.com`)

- Il faut être connecté à Youdji dans Chrome. La page n'atteint jamais l'état « idle » : l'ouvrir dans un **onglet neuf** et lancer le JS après ~4 s.
- Nom = `h1` (« Prénom N. ») ; slug d'URL = handle. Profil plus riche que Fiverr : localisation, langues, équipement souvent exposés.
- Depuis une conversation Youdji : le lien profil est le seul `<a>` vers `youdji.com/<slug>` hors navigation.
- Vidéos (après scroll) : `[...document.querySelectorAll('video')].map(v=>(v.src||v.currentSrc||'').split('?')[0]).filter(Boolean)`. Deux CDN : Cloudflare Stream (`customer-<code>.cloudflarestream.com/<id>/manifest/video.m3u8`) et R2 Youdji (`r2.youdji.com/media/.../master.m3u8`, parfois un `.mov` direct).
- Download (public, sans cookies), une vidéo par appel :

```bash
ffmpeg -y -loglevel error -i "<url-m3u8>" -c copy "<fichier>.mp4"
```

Fichier `.mov` direct → `curl -sL -o`.

## Site perso de créateur (tout autre domaine)

Chaque site est unique. En Chrome, scroller (lazy-load), lire nom (`document.title` / `h1`) et marques citées.
- **Vidéos** : `[...document.querySelectorAll('video')].map(v=>v.src||v.currentSrc)`. Portfolio en `<canvas>` (WebGL) : cliquer chaque tuile pour que le `<video>` charge, en envoyant pointerdown / mousedown / pointerup / mouseup / click à la coordonnée du play.
- **src en `blob:`** (Squarespace) : chercher le `.m3u8` dans `performance.getEntriesByType('resource')`, puis `yt-dlp --referer <site>`.
- Tester le mp4 (`curl -sIL`) : `200` + `video/mp4` → `curl` direct ; sinon `yt-dlp --cookies-from-browser chrome --referer <site>`, une vidéo à la fois.

## Fichier > 10 Mo

```bash
ffmpeg -y -loglevel error -i in.mp4 -vf "scale=-2:960" -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 96k out.mp4
```

Monter le `-crf` (30, 32) si le fichier dépasse encore 10 Mo.
