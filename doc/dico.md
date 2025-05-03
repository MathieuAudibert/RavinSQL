Table : _Utilisateur_

| Colonne     | Type         | Description                                   | Contraintes    |
| ----------- | ------------ | --------------------------------------------- | -------------- |
| id_u        | SERIAL       | Identifiant de l'utilisateur                  | PRIMARY KEY    |
| pseudo      | VARCHAR(50)  | Pseudo de l'utilisateur                       | NOT NULL       |
| prenom      | VARCHAR(50)  | Prenom de l'utilisateur                       |                |
| nom         | VARCHAR(50)  | Nom de l'utilisateur                          |                |
| ville       | VARCHAR(100) | Ville de l'utilisateur                        |                |
| pays        | VARCHAR(50)  | Pays de l'utilisateur                         |                |
| genre       | VARCHAR(50)  | Genre de l'utilisateur                        |                |
| orientation | VARCHAR(50)  | Orientation sexuelle de l'utilisateur         |                |
| taille      | INT          | Taille en cm                                  |                |
| poids       | FLOAT        | Poids en kg                                   |                |
| couleur_y   | VARCHAR(10)  | couleur des yeux de l'utilisateur             |                |
| est_abonne  | BOOLEAN      | L'utilisateur est abonne (vrai) ou non (faux) | DEFAULT: FALSE |

Table : _Evenement_

| Colonne     | Type         | Description                           | Contraintes        |
| ----------- | ------------ | ------------------------------------- | ------------------ |
| id_e        | SERIAL       | Identifiant de l'evenement            | PRIMARY KEY        |
| description | VARCHAR(100) | Description de l'evenement            | NOT NULL           |
| lieu        | INT          | Identifiant du lieu lié a l'evenement | FOREIGN KEY (Lieu) |
| prix        | FLOAT        | Prix de l'evenement                   |                    |
| date        | TIMESTAMP    | Date & heure de l'evenement           |                    |

Table : _Lieu_

| Colonne | Type         | Description                     | Contraintes |
| ------- | ------------ | ------------------------------- | ----------- |
| id_l    | SERIAL       | Identifiant du lieu             | PRIMARY KEY |
| nom     | VARCHAR(100) | Nom du lieu                     | NOT NULL    |
| adresse | VARCHAR(100) | Adresse du lieu                 |             |
| type    | VARCHAR(50)  | Type du lieu (cinema, musée...) |             |

Table : _MotCle_

| Colonne | Type        | Description                                               | Contraintes |
| ------- | ----------- | --------------------------------------------------------- | ----------- |
| id_m    | SERIAL      | Identifiant du mot-clé                                    | PRIMARY KEY |
| mot     | VARCHAR(50) | Mot clé pour taguer les utilisateur, evenemnents et lieux | NOT NULL    |

Table : _HistoriqueAchat_

| Colonne        | Type         | Description                                              | Contraintes               |
| -------------- | ------------ | -------------------------------------------------------- | ------------------------- |
| id_h           | SERIAL       | Identifiant de l'historique d'achats                     | PRIMARY KEY               |
| id_utilisateur | INT          | Identifiant de l'utilisateur lié a l'historique d'achats | FOREIGN KEY (Utilisateur) |
| site           | VARCHAR(100) | Site ou l'utilisateur a éfféctué l'achat                 |                           |
| description    | VARCHAR(100) | Description de l'achat                                   |                           |
| date           | TIMESTAMP    | Date & heure de l'achat                                  |                           |

Table : _ReseauSocial_

| Colonne | Type        | Description                  | Contraintes |
| ------- | ----------- | ---------------------------- | ----------- |
| id_r    | SERIAL      | Identifiant du reseau social | PRIMARY KEY |
| nom     | VARCHAR(50) | Nom du reseau social         |             |

Table : _ActiviteReseau_

| Colonne        | Type         | Description                                       | Contraintes                |
| -------------- | ------------ | ------------------------------------------------- | -------------------------- |
| id_a           | SERIAL       | Identifiant de l'activite sur le reseau social    | PRIMARY KEY                |
| id_utilisateur | INT          | Identifiant de l'utilisateur lié a l'activite     | FOREIGN KEY (Utilisateur)  |
| id_reseau      | INT          | Identifiant du reseau social associé a l'activite | FOREIGN KEY (ReseauSocial) |
| type           | VARCHAR(100) | Type d'activite (like, commentaire...)            |                            |
| description    | TEXT         | Description de l'activite                         |                            |
| date           | TIMESTAMP    | Date & heure de l'activite                        |                            |

Table : _Likes_

| Colonne         | Type      | Description                                 | Contraintes               |
| --------------- | --------- | ------------------------------------------- | ------------------------- |
| id_utilisateur1 | INT       | Identifiant de l'utilisateur qui a liké     | FOREIGN KEY (Utilisateur) |
| id_utilisateur2 | INT       | Identifiant de l'utilisateur qui a été liké | FOREIGN KEY (Utilisateur) |
| date            | TIMESTAMP | Date & heure du like                        |                           |

Table : _Match_

| Colonne         | Type      | Description                             | Contraintes               |
| --------------- | --------- | --------------------------------------- | ------------------------- |
| id_utilisateur1 | INT       | Identifiant de l'utilisateur 1 du match | FOREIGN KEY (Utilisateur) |
| id_utilisateur2 | INT       | Identifiant de l'utilisateur 2 du match | FOREIGN KEY (Utilisateur) |
| date            | TIMESTAMP | Date & heure du match                   |                           |

Table : _Interet_

| Colonne        | Type | Description                                            | Contraintes               |
| -------------- | ---- | ------------------------------------------------------ | ------------------------- |
| id_utilisateur | INT  | Identifiant de l'utilisateur interesse par l'evenement | FOREIGN KEY (Utilisateur) |
| id_evenement   | INT  | Identifiant de l'evenement                             | FOREIGN KEY (Evenement)   |

Table : _Participe_

| Colonne        | Type | Description                                            | Contraintes               |
| -------------- | ---- | ------------------------------------------------------ | ------------------------- |
| id_utilisateur | INT  | Identifiant de l'utilisateur participant a l'evenement | FOREIGN KEY (Utilisateur) |
| id_evenement   | INT  | Identifiant de l'evenement                             | FOREIGN KEY (Evenement)   |

Table : _Tag_

| Colonne        | Type | Description                              | Contraintes               |
| -------------- | ---- | ---------------------------------------- | ------------------------- |
| id_utilisateur | INT  | Identifiant de l'utilisateur tagué       | FOREIGN KEY (Utilisateur) |
| id_motcle      | INT  | Identifiant du mot cle utilise pr le tag | FOREIGN KEY (MotCle)      |

Table : _TagEvenement_

| Colonne      | Type | Description                              | Contraintes             |
| ------------ | ---- | ---------------------------------------- | ----------------------- |
| id_evenement | INT  | Identifiant de l'evenement tagué         | FOREIGN KEY (Evenement) |
| id_motcle    | INT  | Identifiant du mot cle utilise pr le tag | FOREIGN KEY (MotCle)    |

Table : _Lieu_

| Colonne   | Type | Description                              | Contraintes          |
| --------- | ---- | ---------------------------------------- | -------------------- |
| id_lieu   | INT  | Identifiant du lieu tagué                | FOREIGN KEY (Lieu)   |
| id_motcle | INT  | Identifiant du mot cle utilise pr le tag | FOREIGN KEY (MotCle) |

Table : _OrganisateurEvenement_

| Colonne        | Type | Description                                              | Contraintes               |
| -------------- | ---- | -------------------------------------------------------- | ------------------------- |
| id_utilisateur | INT  | Identifiant de l'utilisateur organisateur de l'evenement | FOREIGN KEY (Utilisateur) |
| id_evenement   | INT  | Identifiant de l'evenement                               | FOREIGN KEY (Evenement)   |
