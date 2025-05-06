SELECT u.pseudo, COUNT(ar.id_a) AS act FROM Utilisateur AS u JOIN ActiviteReseau AS ar ON u.id_u = ar.id_utilisateur GROUP BY u.id_u ORDER BY act DESC LIMIT 10;
-- recupere le TOP 10 des utilisateurs les plus actifs sur les reseaux V

SELECT est_abonne, AVG(match_count) FROM (
    SELECT u.id_u, u.est_abonne, COUNT(*) AS match_count
    FROM Utilisateur AS u
    JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2
    GROUP BY u.id_u, u.est_abonne
) AS q2 WHERE q2.est_abonne = TRUE GROUP BY q2.est_abonne;
-- recupere le nombre moyen de match des utilisateurs abonnes  V

SELECT u.est_abonne, AVG(match_count) AS average_matches
FROM (
    SELECT u.id_u, u.est_abonne, COUNT(*) AS match_count
    FROM Utilisateur AS u
    JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2
    GROUP BY u.id_u, u.est_abonne
) AS subquery GROUP BY u.est_abonne;
-- comparer le nombre de match des utilisateur abonnés et pas abonnés V

SELECT * FROM Utilisateur;
-- recuperer les evenements les plus hype X

SELECT u.pays, COUNT(ar.id_a) AS act FROM Utilisateur AS u JOIN ActiviteReseau AS ar ON u.id_u = ar.id_utilisateur 
GROUP BY u.pays ORDER BY act DESC;
-- recuperer les pays les + actifs sur les reseaux  V

SELECT DISTINCT(u.genre) FROM Utilisateur AS u JOIN Likes AS l ON u.id_u = l.id_utilisateur1 WHERE u.id_u = l.id_utilisateur1
ORDER BY u.genre DESC;
-- recuperer le genre qui like LE PLUS V

SELECT site, COUNT(id_h) FROM HistoriqueAchat GROUP BY site ORDER BY COUNT(id_h) DESC;
-- recuperer le site ou les utilisateurs font le plus d'achats V

SELECT * FROM Utilisateur;
-- recuperer les informations des utilisateurs qui font le plus d'achats sur le site ou les utilisateurs font le plus d'achats X

SELECT * FROM Utilisateur;
-- recuperer une correlation entre les utilisateurs qui 

SELECT u1.pseudo AS utilisateur1, u2.pseudo AS utilisateur2, COUNT(DISTINCT t1.id_motcle) AS mc_commun 
FROM Tag t1 JOIN Tag t2 ON t1.id_motcle = t2.id_motcle AND t1.id_utilisateur < t2.id_utilisateur
JOIN Utilisateur AS u1 ON t1.id_utilisateur = u1.id_u
JOIN Utilisateur AS u2 ON t2.id_utilisateur = u2.id_u
GROUP BY u1.id_u, u2.id_u
HAVING COUNT(DISTINCT t1.id_motcle) > 3
ORDER BY mc_commun DESC;
-- utilisateurs avec des centres d'interet similaires V/X

SELECT (COUNT(DISTINCT m.id_utilisateur1, m.id_utilisateur2)::FLOAT / COUNT(DISTINCT l.id_utilisateur1, l.id_utilisateur2)) * 100 AS taux
FROM Likes AS l
LEFT JOIN Match m ON (l.id_utilisateur1 = m.id_utilisateur1 AND l.id_utilisateur2 = m.id_utilisateur2);
-- taux de conversion des likes en matchs X

SELECT DATE_TRUNC('month', date) AS mois, COUNT(id_h), SUM(prix) FROM HistoriqueAchat GROUP BY mois ORDER BY mois; 
-- evolution des achats au cours des mois V

SELECT u.pseudo, COUNT(*) AS nb_match FROM Utilisateur AS u JOIN Match AS m ON u.id_u = m.id_utilisateur1 OR u.id_u = m.id_utilisateur2 
GROUP BY u.id_u ORDER BY nb_match DESC LIMIT 10;
-- top 10 utilisateurs avec le plus de matchs  V

SELECT l.adresse, COUNT(e.id_e) AS evenements FROM Lieu AS l JOIN Evenement AS e ON l.id_l = e.lieu 
GROUP BY l.adresse ORDER BY evenements DESC LIMIT 10;
-- les 10 villes avec le plus d'evenements V

SELECT EXTRACT(MONTH FROM e.date) as mois, COUNT(e.id_e) as evenements FROM Evenement AS e 
JOIN Lieu AS l ON e.lieu = l.id_l GROUP BY l.type ORDER BY mois DESC;
-- les type d'evenements les plus recurents au cours de l'année V

