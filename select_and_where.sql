--Number of runs scored in 1st innings of 1st test of the Ashes 2019
SELECT match_id, team_id, innings, SUM(runs)
FROM testruns
WHERE match_id = 1001
AND innings = 1
GROUP BY match_id, team_id, innings
ORDER BY match_id

--Matches that took place in Australia
SELECT * FROM match
JOIN venues 
ON match.venue_id = venues.id
WHERE country = 'Australia'

--Which players were out via LBW
SELECT * FROM testruns
JOIN wickets
ON testruns.wicket_id = wickets.id
WHERE dismissal = 'LBW'

--Number of catches made by Ben Stokes
SELECT * FROM testruns
WHERE notes LIKE '%Ben Stokes%'


-- Matches that were umpired by Marais Erasmus
SELECT * FROM match
JOIN umpires AS u1
ON match.umpirea_id = u1.id
JOIN umpires AS u2
ON match.umpireb_id = u2.id
WHERE u1.name = 'Marais Erasmus'
OR u2.name = 'Marais Erasmus'
