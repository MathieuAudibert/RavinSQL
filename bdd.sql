CREATE TABLE Utilisateur (
    id_u SERIAL PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    nom VARCHAR(50),
    ville VARCHAR(100),
    pays VARCHAR(50),
    genre VARCHAR(50),
    orientation VARCHAR(50),
    taille INT,
    poids FLOAT,
    couleur_y VARCHAR(10),
    date_crea TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    est_abonne BOOLEAN DEFAULT FALSE,
    interets TEXT[],
    hobbies TEXT[],
    age_pref_min INT,
    age_pref_max INT,
    taille_pref_min INT,
    taille_pref_max INT,
    education VARCHAR(100),
    profession VARCHAR(100),
    langues_parlees TEXT[]
);

CREATE TABLE Lieu (
    id_l SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(100),
    type VARCHAR(50),
    capacite INT,
    accessibilite TEXT
);

CREATE TABLE Evenement (
    id_e SERIAL PRIMARY KEY,
    description VARCHAR(100) NOT NULL,
    lieu INT,
    prix FLOAT,
    date TIMESTAMP,
    categorie VARCHAR(50),
    capacite INT,
    duree INTERVAL,
    FOREIGN KEY (lieu) REFERENCES Lieu(id_l)
);

CREATE TABLE MotCle (
    id_m SERIAL PRIMARY KEY,
    mot VARCHAR(50) NOT NULL,
    categorie VARCHAR(50)
);

CREATE TABLE HistoriqueAchat (
    id_h SERIAL PRIMARY KEY,
    id_utilisateur INT,
    site VARCHAR(100),
    prix FLOAT,
    description VARCHAR(100),
    date TIMESTAMP,
    categorie VARCHAR(50),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u)
);

CREATE TABLE ReseauSocial (
    id_r SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    url VARCHAR(255)
);

CREATE TABLE ActiviteReseau (
    id_a SERIAL PRIMARY KEY,
    id_utilisateur INT,
    id_reseau INT,
    type VARCHAR(100),
    description TEXT,
    date TIMESTAMP,
    url VARCHAR(255),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_reseau) REFERENCES ReseauSocial(id_r)
);

CREATE TABLE Likes (
    id_utilisateur1 INT,
    id_utilisateur2 INT,
    date TIMESTAMP,
    type_like VARCHAR(50),
    FOREIGN KEY (id_utilisateur1) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_utilisateur2) REFERENCES Utilisateur(id_u)
);

CREATE TABLE Match (
    id_utilisateur1 INT,
    id_utilisateur2 INT,
    date TIMESTAMP,
    score FLOAT,
    FOREIGN KEY (id_utilisateur1) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_utilisateur2) REFERENCES Utilisateur(id_u)
);

CREATE TABLE Interet (
    id_utilisateur INT,
    id_evenement INT,
    date_interet TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_evenement) REFERENCES Evenement(id_e)
);

CREATE TABLE Participe (
    id_utilisateur INT,
    id_evenement INT,
    date_participation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_evenement) REFERENCES Evenement(id_e)
);

CREATE TABLE Tag (
    id_utilisateur INT,
    id_motcle INT,
    date_tag TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_motcle) REFERENCES MotCle(id_m)
);

CREATE TABLE TagEvenement (
    id_evenement INT,
    id_motcle INT,
    date_tag TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evenement) REFERENCES Evenement(id_e),
    FOREIGN KEY (id_motcle) REFERENCES MotCle(id_m)
);

CREATE TABLE TagLieu (
    id_lieu INT,
    id_motcle INT,
    date_tag TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_lieu) REFERENCES Lieu(id_l),
    FOREIGN KEY (id_motcle) REFERENCES MotCle(id_m)
);

CREATE TABLE OrganisateurEvenement (
    id_utilisateur INT,
    id_evenement INT,
    date_organisation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_u),
    FOREIGN KEY (id_evenement) REFERENCES Evenement(id_e)
);