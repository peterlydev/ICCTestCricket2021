--Running total of runs and average
SELECT match_id, testruns.team_id, p.name AS player, runs, innings,
SUM(runs) OVER(ORDER BY match_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
AVG(runs) OVER(ORDER BY match_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg
FROM testruns
LEFT JOIN players AS p
ON testruns.player_id = p.id

--Number of Overs played in a game
SELECT match_id, innings, team_id, SUM(balls/6.0) AS overs
FROM testruns
GROUP BY match_id, innings, team_id
ORDER BY match_id, innings

--Run ranges by a player (Kane Willamson)
With bins AS (
SELECT generate_series(0, 290, 10) AS lower,
generate_series(10, 300, 10) AS upper),
runs AS (SELECT player_id, runs FROM testruns)
SELECT lower, upper, count(runs)
FROM bins
JOIN runs
ON runs >= lower
AND runs < upper
WHERE player_id = 8503
GROUP BY lower, upper
ORDER BY lower

-- Number of balls bowled within a range
WITH bins AS (
SELECT generate_series (0, 500, 50) AS lower,
generate_series (50, 550, 50) AS upper),
balls AS (
SELECT balls FROM testruns)
SELECT lower, upper, COUNT(*)
FROM bins
JOIN balls
ON balls >= lower
AND balls < upper
GROUP BY lower, upper
ORDER BY lower

-- Mean and Median of runs made per venue
SELECT v.name AS venue, AVG(runs) AS mean, percentile_disc(0.5)
WITHIN GROUP (ORDER BY runs) AS runs
FROM testruns
JOIN match AS m
ON testruns.match_id = m.id
JOIN venues AS v
ON m.venue_id = v.id
GROUP BY v.name
ORDER BY mean DESC

-- Mean and Median of runs made per player
SELECT p.name AS player, AVG(runs) AS mean, percentile_disc(0.5)
WITHIN GROUP (ORDER BY runs) AS runs
FROM testruns
JOIN players AS p
ON testruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY mean DESC
