-- Outcomes with each player batting (CASE STATEMENT)
SELECT match_id, team_id, innings, player_id, runs, balls,
CASE WHEN runs= 0 THEN 'Duck!'
WHEN runs BETWEEN 50 AND 100 THEN 'Half Century'
WHEN runs BETWEEN 100 AND 200 THEN 'Century'
WHEN runs>= 200 THEN 'Double Century'
WHEN runs IS NULL THEN 'Did not bat'
ELSE 'Howzat!' END AS outcome
FROM testruns

--Total number of runs made in the tournament so far
SELECT 
CASE WHEN team_id = 5003 THEN 'England'
WHEN team_id = 5001 THEN 'Australia'
WHEN team_id = 5006 THEN 'Pakistan'
WHEN team_id = 5007 THEN 'South Africa'
WHEN team_id = 5004 THEN 'India'
WHEN team_id = 5005 THEN 'New Zealand'
WHEN team_id = 5002 THEN 'Bangladesh'
WHEN team_id = 5008 THEN 'Sri Lanka'
ELSE 'West Indies'
END AS team,
SUM(runs) AS total_runs
FROM testruns
GROUP BY team
ORDER BY total_runs DESC

