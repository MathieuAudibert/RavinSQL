Table : _Utilisateur_

| Colonne         | Type         | Description                                   | Contraintes    |
| --------------- | ------------ | --------------------------------------------- | -------------- |
| id_u            | SERIAL       | Identifiant de l'utilisateur                  | PRIMARY KEY    |
| pseudo          | VARCHAR(50)  | Pseudo de l'utilisateur                       | NOT NULL       |
| prenom          | VARCHAR(50)  | Prenom de l'utilisateur                       |                |
| nom             | VARCHAR(50)  | Nom de l'utilisateur                          |                |
| ville           | VARCHAR(100) | Ville de l'utilisateur                        |                |
| pays            | VARCHAR(50)  | Pays de l'utilisateur                         |                |
| genre           | VARCHAR(50)  | Genre de l'utilisateur                        |                |
| orientation     | VARCHAR(50)  | Orientation sexuelle de l'utilisateur         |                |
| taille          | INT          | Taille en cm                                  |                |
| poids           | FLOAT        | Poids en kg                                   |                |
| couleur_y       | VARCHAR(10)  | Couleur des yeux de l'utilisateur             |                |
| est_abonne      | BOOLEAN      | L'utilisateur est abonné (vrai) ou non (faux) | DEFAULT: FALSE |
| interets        | TEXT[]       | Intérêts de l'utilisateur                     |                |
| hobbies         | TEXT[]       | Hobbies de l'utilisateur                      |                |
| age_pref_min    | INT          | Âge minimum préféré pour les matchs           |                |
| age_pref_max    | INT          | Âge maximum préféré pour les matchs           |                |
| taille_pref_min | INT          | Taille minimum préférée pour les matchs       |                |
| taille_pref_max | INT          | Taille maximum préférée pour les matchs       |                |
| education       | VARCHAR(100) | Niveau d'éducation de l'utilisateur           |                |
| profession      | VARCHAR(100) | Profession de l'utilisateur                   |                |
| langues_parlees | TEXT[]       | Langues parlées par l'utilisateur             |                |

Table : _Evenement_

| Colonne     | Type         | Description                           | Contraintes        |
| ----------- | ------------ | ------------------------------------- | ------------------ |
| id_e        | SERIAL       | Identifiant de l'événement            | PRIMARY KEY        |
| description | VARCHAR(100) | Description de l'événement            | NOT NULL           |
| lieu        | INT          | Identifiant du lieu lié à l'événement | FOREIGN KEY (Lieu) |
| prix        | FLOAT        | Prix de l'événement                   |                    |
| date        | TIMESTAMP    | Date & heure de l'événement           |                    |
| categorie   | VARCHAR(50)  | Catégorie de l'événement              |                    |
| capacite    | INT          | Capacité maximale de l'événement      |                    |
| duree       | INTERVAL     | Durée de l'événement                  |                    |

Table : _Lieu_

| Colonne       | Type         | Description                     | Contraintes |
| ------------- | ------------ | ------------------------------- | ----------- |
| id_l          | SERIAL       | Identifiant du lieu             | PRIMARY KEY |
| nom           | VARCHAR(100) | Nom du lieu                     | NOT NULL    |
| adresse       | VARCHAR(100) | Adresse du lieu                 |             |
| type          | VARCHAR(50)  | Type du lieu (cinéma, musée...) |             |
| capacite      | INT          | Capacité maximale du lieu       |             |
| accessibilite | TEXT         | Informations d'accessibilité    |             |

Table : _MotCle_

| Colonne   | Type        | Description                                               | Contraintes |
| --------- | ----------- | --------------------------------------------------------- | ----------- |
| id_m      | SERIAL      | Identifiant du mot-clé                                    | PRIMARY KEY |
| mot       | VARCHAR(50) | Mot clé pour taguer les utilisateurs, événements et lieux | NOT NULL    |
| categorie | VARCHAR(50) | Catégorie du mot-clé                                      |             |

Table : _HistoriqueAchat_

| Colonne        | Type         | Description                                              | Contraintes               |
| -------------- | ------------ | -------------------------------------------------------- | ------------------------- |
| id_h           | SERIAL       | Identifiant de l'historique d'achats                     | PRIMARY KEY               |
| id_utilisateur | INT          | Identifiant de l'utilisateur lié à l'historique d'achats | FOREIGN KEY (Utilisateur) |
| site           | VARCHAR(100) | Site où l'utilisateur a effectué l'achat                 |                           |
| description    | VARCHAR(100) | Description de l'achat                                   |                           |
| date           | TIMESTAMP    | Date & heure de l'achat                                  |                           |
| categorie      | VARCHAR(50)  | Catégorie de l'achat                                     |                           |

Table : _ReseauSocial_

| Colonne | Type         | Description                  | Contraintes |
| ------- | ------------ | ---------------------------- | ----------- |
| id_r    | SERIAL       | Identifiant du réseau social | PRIMARY KEY |
| nom     | VARCHAR(50)  | Nom du réseau social         |             |
| url     | VARCHAR(255) | URL du réseau social         |             |

Table : _ActiviteReseau_

| Colonne        | Type         | Description                                       | Contraintes                |
| -------------- | ------------ | ------------------------------------------------- | -------------------------- |
| id_a           | SERIAL       | Identifiant de l'activité sur le réseau social    | PRIMARY KEY                |
| id_utilisateur | INT          | Identifiant de l'utilisateur lié à l'activité     | FOREIGN KEY (Utilisateur)  |
| id_reseau      | INT          | Identifiant du réseau social associé à l'activité | FOREIGN KEY (ReseauSocial) |
| type           | VARCHAR(100) | Type d'activité (like, commentaire...)            |                            |
| description    | TEXT         | Description de l'activité                         |                            |
| date           | TIMESTAMP    | Date & heure de l'activité                        |                            |
| url            | VARCHAR(255) | URL de l'activité                                 |                            |

Table : _Likes_

| Colonne         | Type        | Description                                 | Contraintes               |
| --------------- | ----------- | ------------------------------------------- | ------------------------- |
| id_utilisateur1 | INT         | Identifiant de l'utilisateur qui a liké     | FOREIGN KEY (Utilisateur) |
| id_utilisateur2 | INT         | Identifiant de l'utilisateur qui a été liké | FOREIGN KEY (Utilisateur) |
| date            | TIMESTAMP   | Date & heure du like                        |                           |
| type_like       | VARCHAR(50) | Type de like (Like, Super Like)             |                           |

Table : _Match_

| Colonne         | Type      | Description                             | Contraintes               |
| --------------- | --------- | --------------------------------------- | ------------------------- |
| id_utilisateur1 | INT       | Identifiant de l'utilisateur 1 du match | FOREIGN KEY (Utilisateur) |
| id_utilisateur2 | INT       | Identifiant de l'utilisateur 2 du match | FOREIGN KEY (Utilisateur) |
| date            | TIMESTAMP | Date & heure du match                   |                           |
| score           | FLOAT     | Score du match                          |                           |

Table : _Interet_

| Colonne        | Type      | Description                                            | Contraintes               |
| -------------- | --------- | ------------------------------------------------------ | ------------------------- |
| id_utilisateur | INT       | Identifiant de l'utilisateur intéressé par l'événement | FOREIGN KEY (Utilisateur) |
| id_evenement   | INT       | Identifiant de l'événement                             | FOREIGN KEY (Evenement)   |
| date_interet   | TIMESTAMP | Date & heure de l'intérêt                              |                           |

Table : _Participe_

| Colonne            | Type      | Description                                            | Contraintes               |
| ------------------ | --------- | ------------------------------------------------------ | ------------------------- |
| id_utilisateur     | INT       | Identifiant de l'utilisateur participant à l'événement | FOREIGN KEY (Utilisateur) |
| id_evenement       | INT       | Identifiant de l'événement                             | FOREIGN KEY (Evenement)   |
| date_participation | TIMESTAMP | Date & heure de la participation                       |                           |

Table : _Tag_

| Colonne        | Type      | Description                                | Contraintes               |
| -------------- | --------- | ------------------------------------------ | ------------------------- |
| id_utilisateur | INT       | Identifiant de l'utilisateur tagué         | FOREIGN KEY (Utilisateur) |
| id_motcle      | INT       | Identifiant du mot clé utilisé pour le tag | FOREIGN KEY (MotCle)      |
| date_tag       | TIMESTAMP | Date & heure du tag                        |                           |

Table : _TagEvenement_

| Colonne      | Type      | Description                                | Contraintes             |
| ------------ | --------- | ------------------------------------------ | ----------------------- |
| id_evenement | INT       | Identifiant de l'événement tagué           | FOREIGN KEY (Evenement) |
| id_motcle    | INT       | Identifiant du mot clé utilisé pour le tag | FOREIGN KEY (MotCle)    |
| date_tag     | TIMESTAMP | Date & heure du tag                        |                         |

Table : _TagLieu_

| Colonne   | Type      | Description                                | Contraintes          |
| --------- | --------- | ------------------------------------------ | -------------------- |
| id_lieu   | INT       | Identifiant du lieu tagué                  | FOREIGN KEY (Lieu)   |
| id_motcle | INT       | Identifiant du mot clé utilisé pour le tag | FOREIGN KEY (MotCle) |
| date_tag  | TIMESTAMP | Date & heure du tag                        |                      |

Table : _OrganisateurEvenement_

| Colonne           | Type      | Description                                              | Contraintes               |
| ----------------- | --------- | -------------------------------------------------------- | ------------------------- |
| id_utilisateur    | INT       | Identifiant de l'utilisateur organisateur de l'événement | FOREIGN KEY (Utilisateur) |
| id_evenement      | INT       | Identifiant de l'événement                               | FOREIGN KEY (Evenement)   |
| date_organisation | TIMESTAMP | Date & heure de l'organisation                           |                           |
