Arborescence :
- doc ==> toute la doc
-- dico.md ==> dictionnaire de données
-- mcd.png ==> mcd (potentiellement bancal) de la bdd
-- raw.png ==> schema de la bdd (pas propre)
- src ==> scripts python pr la bdd
-- forge.py ==> engrosse la bdd (j'ai pas d'autre termes) avec les csv 
-- generator.py ==> ptit script fait en 2-2 qui genere les fichier csv avec des fausses données (Faker) réalistes
-- csv ==> contient les fichier csv qui peuplent la bdd
- bdd.sql ==> la creation de la base de données en sql
- requirements.txt ==> bibliotheques python nécéssaires pr le projet 

Pour run le bordel : 
- Dans votre cmd "pip install -r requirements" pour installer Faker & psycopg
- allez dans src/forge.py et changez les identifiants de connexion a la base de données
- Ensuite "python forge.py" et on est bon normalement 

/!\ Lancez forge.py une seule fois sinon ca va recreer des données a chaque fois... 