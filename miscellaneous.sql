--StrikeRates for each player 
SELECT p.name, (SUM(runs)/NULLIF(SUM(balls), 0.0)* 100) AS SR
FROM matchruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
AND runs != 0
GROUP BY p.name
ORDER BY SR DESC


SELECT p.name, (SUM(runs)/NULLIF(SUM(balls), 0.0)* 100) AS SR
FROM testruns t
JOIN players p
ON t.player_id = p.id
WHERE runs IS NOT NULL
AND runs != 0
GROUP BY match_id, p.name
ORDER BY SR DESC

--Number of Player of the Match Awards
SELECT p.name playerofthematch, COUNT(*)
FROM match
JOIN players AS p
ON match.potm = p.id
GROUP BY p.name
ORDER BY COUNT(*) DESC

--Most Wickets
SELECT p.name, COUNT(*) AS tournament_wickets
FROM testruns m
JOIN players p
ON m.bowler_id = p.id
GROUP BY p.name
ORDER BY tournament_wickets DESC

--Most Runs
SELECT p.name, SUM(runs) AS tournament_runs
FROM testruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC

--Most Fours
SELECT p.name, SUM(fours) AS tournament_runs
FROM testruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC

--Most Sixes
SELECT p.name, SUM(sixes) AS tournament_runs
FROM testruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC, p.name
