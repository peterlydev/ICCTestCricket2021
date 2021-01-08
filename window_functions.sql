RANKINGS
--Rankings of Players scored the most runs in the Championship
SELECT p.name AS player,
RANK () OVER (ORDER BY SUM(runs)DESC) AS total_runs
FROM testruns AS t
JOIN players AS p
ON t.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs

SELECT p.name, SUM(runs),
RANK () OVER (ORDER BY SUM(runs)DESC) AS total_runs
FROM testruns AS t
JOIN players AS p
ON t.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs

¬¬--Number of balls bowled by each country
SELECT v.country, SUM(balls),
RANK () OVER (ORDER BY SUM(balls)DESC) AS total_balls
FROM testruns AS t
JOIN match AS m
ON t.match_id = m.id
JOIN venues AS v
ON m.venue_id = v.id
WHERE runs IS NOT NULL
GROUP BY v.country
ORDER BY total_balls
