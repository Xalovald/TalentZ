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

La commande a effectuer pour lancer votre docker est la suivante: ```docker compose up --build -d```

## Concernant l'application

### Étapes

1. Lancer l'application en mode debug
2. Attendre que l'application s'ouvre sur le téléphone
3. Lancer un invite de commande
4. Taper
    ```bat
    adb shell
    ```
5. Une fois rentrée, taper:
    ```bat
    run-as com.example.talentz
    ```
6. Puis faire:
    ```bat
    cd app_flutter
    cd files
    ```
7. Vous devriez avoir un ficher nommé base.txt
8. Pour le modifier:
    - Créer ou Modifier le fichier base.txt:
      ```bat
      echo "{votre_id}" > base.txt
      ```
      Ou:
      ```bat
      echo > base.txt
      ```
    - Supprimer le fichier base.txt:
      ```ps
      rm -f base.txt
      ```
### Post-Scriptum

Si vous lancez l'application mobile, rentrez absolument
tous les champs de l'inscription pour l'instant, l'application n'est pas terminée.

Si vous désinstallez l'application, vous devrez recommencer le processus, si vous vous êtes déjà créé un compte, allez dans adb shell et remettez votre id dans le fichier base.txt .

