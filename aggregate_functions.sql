SELECT v.name, subq.runs
FROM match m
JOIN venues v ON m.venue_id = v.id,
(SELECT match_id, innings, t.name AS teams, SUM(runs) AS runs
FROM testruns
JOIN teams t ON testruns.team_id = t.id
WHERE t.name = 'India'
GROUP BY match_id, innings, t.name) AS subq
WHERE m.id = subq.match_id
ORDER BY subq.runs DESC



