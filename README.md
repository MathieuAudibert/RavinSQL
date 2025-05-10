# Arborescence :

```
📦doc
 ┣ 📂requetes
 ┃ ┗ 📂v2 ==> images
 ┣ 📜dico.md ==> dctionnaire de données (description, type...)
 ┣ 📜mcd.png ==> modele conceptuel de données
 ┗ 📜raw.png ==> schéma simplifié
 📦src
 ┣ 📂csv ==> les fichier csv avec les données a ingerer
 ┣ 📜forge.py ==> generateur de données
 ┗ 📜requetes_ravin.sql ==> les 20-25 requetes demandées par l'exo

```

# Run :

- Dans votre cmd "pip install -r requirements" pour installer Faker & psycopg
- allez dans src/forge.py et changez les identifiants de connexion a la base de données
- Ensuite "python forge.py" et on est bon normalement

> [!WARNING]
> Lancez forge.py une seule fois sinon ca va recreer des données a chaque fois...
