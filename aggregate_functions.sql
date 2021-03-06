COUNT
-- Top 50 players with the most wickets
SELECT p.name, COUNT(*) AS wickets
FROM testruns
JOIN players AS p
ON testruns.bowler_id = p.id
GROUP BY p.name
ORDER BY wickets DESC
LIMIT 50

--Wickets made by All rounders
SELECT p.name, COUNT(*) AS wickets
FROM testruns t
JOIN players p
ON t.bowler_id = p.id
JOIN roles r
ON p.role_id = r.id
WHERE role = 'All-rounder'
GROUP BY p.name
ORDER BY wickets DESC

 

-- 50 players who have played the most test matches during the tournament
SELECT p.name, COUNT(*) AS matches
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
GROUP BY p.name
ORDER BY matches
LIMIT 50

--Number of ducks made in a test match 
SELECT p.name, runs, COUNT(*) AS ducks
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs= 0
AND wicket_id != 6
GROUP BY p.name, runs
ORDER BY COUNT(*) DESC

SUM
-- Top 50 players with the most runs
SELECT p.name, SUM(runs) AS total_runs
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs DESC
LIMIT 50

--All rounders with the most runs
SELECT p.name, SUM(runs) AS total_runs
FROM testruns t
JOIN players p
ON t.player_id = p.id
JOIN roles r
ON p.role_id = r.id
WHERE role = 'All-rounder'
GROUP BY p.name
ORDER BY total_runs DESC

-- Wicketkeepers with the most runs
SELECT p.name, SUM(runs) AS total_runs
FROM testruns t
JOIN players p
ON t.player_id = p.id
JOIN roles r
ON p.role_id = r.id
WHERE role = 'Wicket-keeper'
GROUP BY p.name
ORDER BY total_runs DESC


--Number of balls faced in descending order
SELECT p.name, SUM(balls) AS total_balls
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_balls DESC
LIMIT 50


--Most Boundaries by a player in the tournament
SELECT p.name, SUM(fours + sixes) AS total_boundaries
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_boundaries DESC
LIMIT 50
MAX
-- Most runs scored in an innings in the tournament
SELECT p.name, MAX(runs) AS maxruns
FROM testruns AS t
JOIN players AS p
ON t.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY t.match_id, p.name
ORDER BY maxruns DESC
