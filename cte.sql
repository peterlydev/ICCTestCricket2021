--Number of players who reach half-centuries in each venue
WITH tests AS (
SELECT match_id, runs, balls 
FROM testruns AS b WHERE runs >= 50)
SELECT v.name AS venue, COUNT(tests.match_id) AS tests
FROM match AS m
JOIN venues AS v
ON m.venue_id = v.id
JOIN tests
ON tests.match_id = m.id
GROUP BY v.name
ORDER BY tests DESC

--Centuries
WITH tests AS (
SELECT match_id, runs, balls 
FROM testruns AS b WHERE runs >= 100)
SELECT v.name AS venue, COUNT(tests.match_id) AS tests
FROM match AS m
JOIN venues AS v
ON m.venue_id = v.id
JOIN tests
ON tests.match_id = m.id
GROUP BY v.name
ORDER BY tests DESC

--Total number of runs made so far by each player in the tournament
WITH test AS (
SELECT match_id, player_id, runs
FROM testruns)
SELECT p.name AS player, SUM(runs) AS highest_centuries
FROM players AS p
LEFT JOIN test AS t
ON p.id = t.player_id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY highest_centuries DESC
