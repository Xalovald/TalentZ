# Étapes

**Attention, les étapes doivent toutes être effectuées dans le même dossier**

1. Créer une nouvelle application flutter nommée talentz_mobile
2. Créer une nouvelle api asp.net core nommée talentz_api (Sans docker!)
3. Insérer les deux Dockerfile placées dans talentz_mobile et talentz_api dans leur dossier respectifs que vous venez de créer
4. Aller dans le dossier talentz_api et allez dans le dossier: talentz_api/Properties/launchSettings.json et chercher la ligne:
    ```"applicationUrl": "https://localhost:{PORT_HTTPS};http://localhost:{PORT_HTTP}"```
5. Allez dans le Dockerfile de talentz_api et remplacez le Expose avec le {PORT_HTTP} de l'étape précédente
6. Toujours dans le même Dockerfile, remplacer le port de la ligne: ```ENV ASPNETCORE_URLS=http://*:5212``` par le {PORT_HTTP} de l'étape 4
7. Allez dans le docker-compose.yaml et cherchez talentz_api puis modifiez les ports par le {PORT_HTTP} de l'étape 4


## IMPORTANT

La commande a effectuer pour lancer votre docker est la suivante: ```docker compose up --build```