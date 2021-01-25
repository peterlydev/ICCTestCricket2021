CREATE PROCEDURE [dbo].[createrecord]
(
@match_id AS INT,
@team_id AS INT,
@innings AS INT,
@player_id AS INT,
@runs AS NUMERIC,
@balls AS NUMERIC,
@fours AS NUMERIC,
@sixes AS NUMERIC,
@bowler_id AS INT,
@wicket_id AS INT,
@notes AS nvarchar(100)
)
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO testruns(match_id, team_id, innings, player_id, runs, balls, fours, sixes, bowler_id, wicket_id, notes) 
VALUES (@match_id, @team_id, @innings, @player_id, @runs, @balls, @fours, @sixes, @bowler_id, @wicket_id, @notes);

SELECT * FROM dbo.testruns
END;

CREATE PROCEDURE [dbo].[Matchlist]
AS
BEGIN
SELECT m.id, start_date, end_date, v.name AS venue, t1.name, t2.name, u1.name, u2.name, t3.name, p.name
FROM match m
LEFT JOIN venues v
ON m.venue_id = v.id
LEFT JOIN teams t1
ON m.teama = t1.id
LEFT JOIN teams t2
ON m.teamb = t2.id
LEFT JOIN umpires u1
ON m.umpirea_id = u1.id
LEFT JOIN umpires u2
ON m.umpireb_id = u2.id
LEFT JOIN teams t3
ON m.winner = t3.id
LEFT JOIN players p
ON m.potm = p.id
ORDER BY m.id
END

CREATE PROCEDURE [dbo].[Scorecard]
AS
BEGIN
SELECT match_id, t.name Team, p1.name Batsman, runs, balls, fours, sixes, p2.name Bowler, w.dismissal Dismissal, notes
FROM testruns AS m
LEFT JOIN teams AS t
ON m.team_id = t.id
LEFT JOIN players AS p1
ON m.player_id = p1.id
LEFT JOIN players AS p2
ON m.bowler_id = p2.id
LEFT JOIN wickets AS w
ON m.wicket_id = w.id
END