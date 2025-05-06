import psycopg2
import csv
import os
import random
from faker import Faker

fake = Faker('fr_FR')

def create_and_get_ids(cursor, table_name, num_records):
    if table_name == 'Utilisateur':
        ids = []
        for i in range(num_records):
            pseudo = fake.user_name()
            prenom = fake.first_name()
            nom = fake.last_name()
            ville = fake.city()
            pays = fake.country()
            genre = random.choice(['Homme', 'Femme', 'Autre'])
            orientation = random.choice(['Hétéro', 'Homosexuel', 'Bisexuel', 'Autre'])
            taille = random.randint(150, 200)
            poids = round(random.uniform(50, 100), 1)
            couleur_y = fake.safe_color_name()
            est_abonne = fake.boolean(chance_of_getting_true=50)

            cursor.execute("""
                INSERT INTO Utilisateur (pseudo, prenom, nom, ville, pays, genre, orientation, taille, poids, couleur_y, est_abonne)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id_u
            """, (pseudo, prenom, nom, ville, pays, genre, orientation, taille, poids, couleur_y, est_abonne))

            id_value = cursor.fetchone()[0]
            ids.append(id_value)
        return ids

    elif table_name == 'Lieu':
        ids = []
        for i in range(num_records):
            nom = fake.company()
            adresse = fake.address()
            type_lieu = random.choice(['Bar', 'Restaurant', 'Salle de concert', 'Parc'])

            cursor.execute("""
                INSERT INTO Lieu (nom, adresse, type)
                VALUES (%s, %s, %s)
                RETURNING id_l
            """, (nom, adresse, type_lieu))

            id_value = cursor.fetchone()[0]
            ids.append(id_value)
        return ids

    elif table_name == 'MotCle':
        ids = []
        for i in range(num_records):
            mot = fake.word()

            cursor.execute("""
                INSERT INTO MotCle (mot)
                VALUES (%s)
                RETURNING id_m
            """, (mot,))

            id_value = cursor.fetchone()[0]
            ids.append(id_value)
        return ids

    elif table_name == 'ReseauSocial':
        ids = []
        for i in range(num_records):
            nom = fake.word()

            cursor.execute("""
                INSERT INTO ReseauSocial (nom)
                VALUES (%s)
                RETURNING id_r
            """, (nom,))

            id_value = cursor.fetchone()[0]
            ids.append(id_value)
        return ids

    return []

def create_dependent_data(cursor, lieu_ids, utilisateur_ids, motcle_ids, reseau_ids):
    evenement_ids = []
    num_evenements = 75
    for i in range(num_evenements):
        description = fake.sentence()
        lieu_id = random.choice(lieu_ids)
        prix = round(random.uniform(10, 100), 2)
        date = fake.date_time_this_decade()

        cursor.execute("""
            INSERT INTO Evenement (description, lieu, prix, date)
            VALUES (%s, %s, %s, %s)
            RETURNING id_e
        """, (description, lieu_id, prix, date))

        id_value = cursor.fetchone()[0]
        evenement_ids.append(id_value)

    num_historiques = 150
    for i in range(num_historiques):
        utilisateur_id = random.choice(utilisateur_ids)
        site = fake.url()
        description = fake.sentence()
        date = fake.date_time_this_decade()
        prix = round(random.uniform(10, 100), 2)

        cursor.execute("""
            INSERT INTO HistoriqueAchat (id_utilisateur, site, prix, description, date)
            VALUES (%s, %s, %s, %s, %s)
        """, (utilisateur_id, site, prix, description, date))

    num_activites = 200
    for i in range(num_activites):
        utilisateur_id = random.choice(utilisateur_ids)
        reseau_id = random.choice(reseau_ids)
        type_activite = random.choice(['Post', 'Commentaire', 'Like'])
        description = fake.text()
        date = fake.date_time_this_decade()

        cursor.execute("""
            INSERT INTO ActiviteReseau (id_utilisateur, id_reseau, type, description, date)
            VALUES (%s, %s, %s, %s, %s)
        """, (utilisateur_id, reseau_id, type_activite, description, date))

    num_likes = 300
    used_likes = set()
    count = 0
    while count < num_likes:
        id1 = random.choice(utilisateur_ids)
        id2 = random.choice(utilisateur_ids)
        if id1 != id2 and (id1, id2) not in used_likes:
            used_likes.add((id1, id2))
            date = fake.date_time_this_decade()

            cursor.execute("""
                INSERT INTO Likes (id_utilisateur1, id_utilisateur2, date)
                VALUES (%s, %s, %s)
            """, (id1, id2, date))
            count += 1

    num_matches = 100
    used_matches = set()
    count = 0
    while count < num_matches:
        id1 = random.choice(utilisateur_ids)
        id2 = random.choice(utilisateur_ids)
        if id1 != id2 and (id1, id2) not in used_matches and (id2, id1) not in used_matches:
            used_matches.add((id1, id2))
            date = fake.date_time_this_decade()

            cursor.execute("""
                INSERT INTO Match (id_utilisateur1, id_utilisateur2, date)
                VALUES (%s, %s, %s)
            """, (id1, id2, date))
            count += 1

    num_interets = 150
    used_interets = set()
    count = 0
    while count < num_interets:
        user_id = random.choice(utilisateur_ids)
        event_id = random.choice(evenement_ids)
        if (user_id, event_id) not in used_interets:
            used_interets.add((user_id, event_id))

            cursor.execute("""
                INSERT INTO Interet (id_utilisateur, id_evenement)
                VALUES (%s, %s)
            """, (user_id, event_id))
            count += 1

    num_participations = 200
    used_participations = set()
    count = 0
    while count < num_participations:
        user_id = random.choice(utilisateur_ids)
        event_id = random.choice(evenement_ids)
        if (user_id, event_id) not in used_participations:
            used_participations.add((user_id, event_id))

            cursor.execute("""
                INSERT INTO Participe (id_utilisateur, id_evenement)
                VALUES (%s, %s)
            """, (user_id, event_id))
            count += 1

    num_tags = 250
    used_tags = set()
    count = 0
    while count < num_tags:
        user_id = random.choice(utilisateur_ids)
        motcle_id = random.choice(motcle_ids)
        if (user_id, motcle_id) not in used_tags:
            used_tags.add((user_id, motcle_id))

            cursor.execute("""
                INSERT INTO Tag (id_utilisateur, id_motcle)
                VALUES (%s, %s)
            """, (user_id, motcle_id))
            count += 1

    num_tagevenements = 150
    used_tagevenements = set()
    count = 0
    while count < num_tagevenements:
        event_id = random.choice(evenement_ids)
        motcle_id = random.choice(motcle_ids)
        if (event_id, motcle_id) not in used_tagevenements:
            used_tagevenements.add((event_id, motcle_id))

            cursor.execute("""
                INSERT INTO TagEvenement (id_evenement, id_motcle)
                VALUES (%s, %s)
            """, (event_id, motcle_id))
            count += 1

    num_taglieux = 100
    used_taglieux = set()
    count = 0
    while count < num_taglieux:
        lieu_id = random.choice(lieu_ids)
        motcle_id = random.choice(motcle_ids)
        if (lieu_id, motcle_id) not in used_taglieux:
            used_taglieux.add((lieu_id, motcle_id))

            cursor.execute("""
                INSERT INTO TagLieu (id_lieu, id_motcle)
                VALUES (%s, %s)
            """, (lieu_id, motcle_id))
            count += 1

    num_organisateurs = 50
    used_organisateurs = set()
    count = 0
    while count < num_organisateurs:
        user_id = random.choice(utilisateur_ids)
        event_id = random.choice(evenement_ids)
        if (user_id, event_id) not in used_organisateurs:
            used_organisateurs.add((user_id, event_id))

            cursor.execute("""
                INSERT INTO OrganisateurEvenement (id_utilisateur, id_evenement)
                VALUES (%s, %s)
            """, (user_id, event_id))
            count += 1

    return evenement_ids

def export_to_csv(cursor, table_name, file_path):
    cursor.execute(f"SELECT * FROM {table_name}")
    rows = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    with open(file_path, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(colnames)
        writer.writerows(rows)

def main():
    conn = psycopg2.connect(
        dbname='RavinSQL',
        user='postgres',
        password='postgres',
        host='localhost',
        port='5432'
    )

    conn.autocommit = False
    cursor = conn.cursor()

    try:
        print("utilisateur Ok")
        utilisateur_ids = create_and_get_ids(cursor, 'Utilisateur', 100)

        print("lieu Ok...")
        lieu_ids = create_and_get_ids(cursor, 'Lieu', 50)

        print("motcle Ok...")
        motcle_ids = create_and_get_ids(cursor, 'MotCle', 40)

        print("reseausocial Ok...")
        reseau_ids = create_and_get_ids(cursor, 'ReseauSocial', 10)

        print("records...")
        evenement_ids = create_dependent_data(cursor, lieu_ids, utilisateur_ids, motcle_ids, reseau_ids)

        conn.commit()
        print("tout est ok")

        print("csv...")
        export_to_csv(cursor, 'Utilisateur', 'csv/Utilisateur.csv')
        export_to_csv(cursor, 'Lieu', 'csv/Lieu.csv')
        export_to_csv(cursor, 'MotCle', 'csv/MotCle.csv')
        export_to_csv(cursor, 'ReseauSocial', 'csv/ReseauSocial.csv')
        export_to_csv(cursor, 'Evenement', 'csv/Evenement.csv')
        export_to_csv(cursor, 'HistoriqueAchat', 'csv/HistoriqueAchat.csv')
        export_to_csv(cursor, 'ActiviteReseau', 'csv/ActiviteReseau.csv')
        export_to_csv(cursor, 'Likes', 'csv/Likes.csv')
        export_to_csv(cursor, 'Match', 'csv/Match.csv')
        export_to_csv(cursor, 'Interet', 'csv/Interet.csv')
        export_to_csv(cursor, 'Participe', 'csv/Participe.csv')
        export_to_csv(cursor, 'Tag', 'csv/Tag.csv')
        export_to_csv(cursor, 'TagEvenement', 'csv/TagEvenement.csv')
        export_to_csv(cursor, 'TagLieu', 'csv/TagLieu.csv')
        export_to_csv(cursor, 'OrganisateurEvenement', 'csv/OrganisateurEvenement.csv')
        print("csv ok")

    except Exception as e:
        conn.rollback()
        print(f"erreur: {e}")

    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    main()

