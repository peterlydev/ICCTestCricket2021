CREATE TABLE match (
id INT PRIMARY KEY,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
venue_id INT NOT NULL,
teamA INT,
teamB INT,
umpirea_id INT,
umpireb_id INT,
winner INT,
potm INT

);

CREATE TABLE umpires (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
country VARCHAR(50) NOT NULL
);

CREATE TABLE wickets (
id SERIAL PRIMARY KEY,
dismissal VARCHAR(25)
);

CREATE TABLE players (
id INT NOT NULL,
name VARCHAR(100) NOT NULL, 
role_id INT NOT NULL,
team_id INT NOT NULL
 );


CREATE TABLE roles (
id INT IDENTITY(1,1) PRIMARY KEY,
role VARCHAR(25)
);

CREATE TABLE venues (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
city VARCHAR(100),
country VARCHAR(100)
);

CREATE TABLE testruns(
match_id INT NOT NULL,
team_id INT NOT NULL,
innings INT,
player_id INT,
runs INT,
balls INT,
fours INT,
sixes INT,
bowler_id INT,
wicket_id INT,
notes VARCHAR(100)
);

CREATE TABLE teams (
id INT NOT NULL PRIMARY KEY,
short_name VARCHAR(3),
name VARCHAR(25),
coach VARCHAR(50)
);

