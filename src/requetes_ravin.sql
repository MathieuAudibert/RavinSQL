SELECT u.pseudo, COUNT(ar.id_a) AS act FROM Utilisateur AS u JOIN ActiviteReseau AS ar ON u.id_u = ar.id_utilisateur GROUP BY u.id_u ORDER BY act DESC LIMIT 10;
-- recupere le TOP 10 des utilisateurs les plus actifs sur les reseaux V

SELECT est_abonne, AVG(match) FROM (
    SELECT u.id_u, u.est_abonne, COUNT(*) AS match
    FROM Utilisateur AS u
    JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2
    GROUP BY u.id_u, u.est_abonne
) AS q2 WHERE q2.est_abonne = TRUE GROUP BY q2.est_abonne;
-- recupere le nombre moyen de match des utilisateurs abonnes  V

SELECT est_abonne, AVG(match) AS moyenne
FROM (
    SELECT u.id_u, u.est_abonne, COUNT(*) AS match
    FROM Utilisateur AS u
    JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2
    GROUP BY u.id_u, u.est_abonne
) GROUP BY est_abonne ORDER BY moyenne DESC;
-- comparer le nombre de match des utilisateur abonnés et pas abonnés V

SELECT u.pays, COUNT(ar.id_a) AS act FROM Utilisateur AS u JOIN ActiviteReseau AS ar ON u.id_u = ar.id_utilisateur 
GROUP BY u.pays ORDER BY act DESC;
-- recuperer les pays les + actifs sur les reseaux  V

SELECT DISTINCT(u.genre) FROM Utilisateur AS u JOIN Likes AS l ON u.id_u = l.id_utilisateur1 WHERE u.id_u = l.id_utilisateur1
ORDER BY u.genre DESC;
-- recuperer le genre qui like LE PLUS V

SELECT site, COUNT(id_h) FROM HistoriqueAchat GROUP BY site ORDER BY COUNT(id_h) DESC;
-- recuperer le site ou les utilisateurs font le plus d'achats V

SELECT u1.pseudo AS utilisateur1, u2.pseudo AS utilisateur2
FROM Utilisateur AS u1
JOIN Utilisateur AS u2 ON u1.id_u <> u2.id_u
JOIN Interet i1 ON u1.id_u = i1.id_utilisateur
JOIN Interet i2 ON u2.id_u = i2.id_utilisateur AND i1.id_evenement = i2.id_evenement;
-- recuperer les utilisateurs qui ont des interets communs V

SELECT
    (COUNT(DISTINCT (m.id_utilisateur1, m.id_utilisateur2))::FLOAT /
     COUNT(DISTINCT (l.id_utilisateur1, l.id_utilisateur2))) * 100 AS taux
FROM Likes AS l
LEFT JOIN Match m ON (l.id_utilisateur1 = m.id_utilisateur1 AND l.id_utilisateur2 = m.id_utilisateur2);
-- taux de conversion des likes en matchs V

SELECT DATE_TRUNC('month', date) AS mois, COUNT(id_h), SUM(prix) FROM HistoriqueAchat GROUP BY mois ORDER BY mois; 
-- evolution des achats au cours des mois V

SELECT u.pseudo, COUNT(*) AS nb_match FROM Utilisateur AS u JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2 
GROUP BY u.id_u ORDER BY nb_match DESC LIMIT 10;
-- top 10 utilisateurs avec le plus de matchs  V

SELECT l.adresse, COUNT(e.id_e) AS evenements FROM Lieu AS l JOIN Evenement AS e ON l.id_l = e.lieu 
GROUP BY l.adresse ORDER BY evenements DESC LIMIT 10;
-- les 10 villes avec le plus d'evenements V

SELECT EXTRACT(MONTH FROM e.date) as mois, COUNT(e.id_e) as evenements FROM Evenement AS e 
JOIN Lieu AS l ON e.lieu = l.id_l GROUP BY e.date ORDER BY mois DESC;
-- les type d'evenements les plus recurents au cours de l'année V

SELECT u.pseudo
FROM Utilisateur AS u
WHERE (SELECT COUNT(*) FROM Participe AS p WHERE p.id_utilisateur = u.id_u) > (SELECT AVG(participations) FROM (SELECT COUNT(*) AS participations FROM Participe GROUP BY id_utilisateur));
-- recuperer les utilisateurs qui participent plus que la moyenne des utilisateurs V

SELECT u.pseudo
FROM Utilisateur AS u
WHERE NOT EXISTS (SELECT 1 FROM Evenement e WHERE NOT EXISTS (SELECT 1 FROM Participe AS p WHERE p.id_utilisateur = u.id_u AND p.id_evenement = e.id_e));
--  recuperer les utilisateurs qui participent plus que la moyenne des utilisateurs sous requetes corrélées V

SELECT u.pseudo
FROM Utilisateur AS u
JOIN Participe AS p ON u.id_u = p.id_utilisateur
GROUP BY u.id_u
HAVING COUNT(DISTINCT p.id_evenement) = (SELECT COUNT(*) FROM Evenement);
--  recuperer les utilisateurs qui participent plus que la moyenne des utilisateurs avec aggrégation V

SELECT pseudo FROM Utilisateur WHERE poids > 70;
-- recuperer les utilisateurs qui pèsent plus de 70kg V
SELECT pseudo FROM Utilisateur WHERE poids IS NOT NULL AND poids > 70;
-- recuperer les utilisateurs qui pèsent plus de 70kg avec gestion des nulls V

WITH RECURSIVE disponible AS (
    SELECT
        lieu AS id_l,
        date AS prochaine_date
    FROM (
        SELECT
            lieu,
            date,
            ROW_NUMBER() OVER (PARTITION BY lieu ORDER BY date) AS rn
        FROM Evenement
    ) ranked
    WHERE rn = 1

    UNION ALL

    SELECT
        e.lieu AS id_l,
        e.date AS prochaine_date
    FROM Evenement AS e
    JOIN disponible d ON e.lieu = d.id_l AND e.date > d.prochaine_date
    WHERE
        e.date = (
            SELECT MIN(date)
            FROM Evenement
            WHERE lieu = e.lieu AND date > d.prochaine_date
        )
)
SELECT id_l, prochaine_date 
FROM disponible
WHERE prochaine_date > NOW()
ORDER BY prochaine_date
LIMIT 1;
-- recuperer le prochain evenement d'un lieu X

WITH rangs AS (
    SELECT
        pseudo,
        mot,
        RANK() OVER (PARTITION BY DATE_TRUNC('month', date) ORDER BY count DESC) AS rang
    FROM (
        SELECT
            u.pseudo,
            m.mot,
            COUNT(*) as count,
            ar.date
        FROM Utilisateur AS u
        JOIN Tag AS t ON u.id_u = t.id_utilisateur
        JOIN MotCle AS m ON t.id_motcle = m.id_m
        JOIN ActiviteReseau AS ar ON u.id_u = ar.id_utilisateur
        WHERE ar.type = 'nope'
        GROUP BY u.pseudo, m.mot, DATE_TRUNC('month', ar.date), ar.date
    )
)
SELECT pseudo, mot, rang
FROM rangs
WHERE rang <= 10;
-- recuperer le top 10 des mots les plus tagués par mois V

SELECT u.pseudo, COUNT(e.id_e) AS nombre_evenements
FROM Utilisateur AS u
JOIN Participe AS p ON u.id_u = p.id_utilisateur
JOIN Evenement AS e ON p.id_evenement = e.id_e
GROUP BY u.pseudo;
-- recuperer le nombre d'evenements auxquels chaque utilisateur a participé V

SELECT pseudo FROM Utilisateur
WHERE id_u NOT IN (SELECT id_utilisateur FROM Participe);
-- recuperer les utilisateurs qui n'ont pas participé à d'evenements V

SELECT AVG(poids) AS poids_moyen FROM Utilisateur WHERE poids IS NOT NULL;
-- recuperer le poids moyen des utilisateurs V

SELECT * FROM Evenement WHERE date > NOW();
-- recuperer les evenements à venir V

SELECT u.pseudo, COUNT(*) AS likes
FROM Utilisateur AS u
JOIN Likes AS l ON u.id_u = l.id_utilisateur1
GROUP BY u.pseudo ORDER BY likes DESC;
-- recuperer le nombre de likes de chaque utilisateur V

SELECT DISTINCT l.adresse
FROM Lieu AS l
JOIN Evenement e ON l.id_l = e.lieu;
-- recuperer les adresses des lieux qui ont eu des evenements V

SELECT u.pseudo
FROM Utilisateur AS u
JOIN Participe AS p ON u.id_u = p.id_utilisateur
JOIN Evenement AS e ON p.id_evenement = e.id_e
GROUP BY u.pseudo
HAVING COUNT(DISTINCT e.lieu) > 1;
-- recuperer les utilisateurs qui ont participé à des evenements dans plusieurs lieux V

SELECT DATE_TRUNC('month', date_crea) AS mois, COUNT(*) AS nouveaux_utilisateurs
FROM Utilisateur
GROUP BY mois
ORDER BY mois;
-- recuperer le nombre de nouveaux utilisateurs par mois V