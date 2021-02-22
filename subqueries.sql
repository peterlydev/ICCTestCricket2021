--Semi Scorecard for matches taken place at Old Trafford (Semi Join)
SELECT t.match_id, innings, player_id , runs, balls, bowler_id, wicket_id
FROM testruns AS t
WHERE match_id IN (SELECT id FROM match
WHERE venue_id = 4)
ORDER BY t.match_id

--Semi Scorecard for matches taken place with Richard Illingworth as the Umpire (Semi Join)
SELECT t.match_id, innings, player_id , runs, balls, bowler_id, wicket_id
FROM testruns AS t
WHERE match_id IN (SELECT id FROM match
WHERE umpirea_id = 3 OR umpireb_id = 3)
ORDER BY t.match_id

FROM 
-- Number of wickets taken per venue (Mitchell Starc)
SELECT v.name, subquery.wickets
FROM match
JOIN venues AS v
ON match.venue_id = v.id,
(SELECT match_id, p.name AS bowler, COUNT(*) AS wickets
FROM testruns 
JOIN players AS p
ON testruns.bowler_id = p.id
WHERE p.name = 'Mitchell Starc'
GROUP BY match_id, p.name) AS subquery
WHERE match.id = subquery.match_id

--Number of runs made per venue 
SELECT v.name, subquery.total_runs
FROM match
JOIN venues AS v
ON match.venue_id = v.id,
(SELECT match_id, p.name AS batsman, SUM(runs) AS total_runs
FROM testruns 
JOIN players AS p
ON testruns.player_id = p.id
WHERE p.name = 'Ajinkya Rahane'
GROUP BY match_id, p.name) AS subquery
WHERE match.id = subquery.match_id

--Players who score more than 100 runs in the tournament
SELECT * FROM 
(SELECT * FROM testruns WHERE runs > 100) a

-- Show all scores where Pakistan won
SELECT * FROM testruns
WHERE match_id
IN (SELECT id FROM match WHERE winner = 5006)

--Show all LBW dismissals
SELECT * FROM testruns
WHERE wicket_id
IN (SELECT id FROM wickets WHERE dismissal = 'LBW')

--Show all match taken place at Old Trafford
SELECT * FROM match
WHERE venue_id 
	IN (SELECT id FROM venues WHERE name = 'Old Trafford')

-- Total number of runs made by each team throughout
SELECT teams.name AS country,
(SELECT SUM(runs) FROM testruns
 WHERE teams.id = testruns.team_id) AS runs
 FROM teams
 ORDER by runs DESC

--Runs made by each player compared to overall
SELECT p.name, SUM(runs) AS total_runs_per_test,
(SELECT SUM(runs) FROM testruns) AS overall_AVG
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs_per_test DESC

-- Run AVG from each stadium compared to overall
SELECT v.name AS venue, ROUND(AVG(runs),2) AS Test_AVG, 
(SELECT ROUND(AVG(runs), 2) FROM testruns) AS overall_AVG
FROM testruns 
JOIN match AS m
ON testruns.match_id = m.id
JOIN venues AS v
ON m.venue_id = v.id
GROUP BY v.name
?
-- Number of runs scored by each team specifically via match and innings
SELECT teams.name AS country,
(SELECT SUM(runs) FROM testruns
 WHERE teams.id = testruns.team_id AND match_id= 1001 AND innings= 1) AS runs
 FROM teams
 ORDER by runs

--Number of runs made by each team vs overall
SELECT t.name AS country, SUM(runs) AS team_runs,
(SELECT SUM(runs) FROM testruns) AS runs
 FROM testruns
 JOIN teams AS t
 ON testruns.team_id = t.id
 GROUP BY t.name
 ORDER by team_runs DESC

-- Number of runs made by each stadium
SELECT v.name, 
(SELECT SUM(runs) FROM testruns 
WHERE match.id = testruns.match_id) AS total_runs
FROM match
JOIN venues AS v
ON match.venue_id = v.id
ORDER BY total_runs DESC
