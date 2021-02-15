DROP DATABASE cricket;
CREATE DATABASE cricket;
USE cricket;

CREATE TABLE players(
    player_id INTEGER NOT NULL,
    player_name VARCHAR (300) NOT NULL,
    dob DATE NOT NULL,
    batting_hand VARCHAR (80),
    bowling_skill VARCHAR (300),
    country_name VARCHAR (80) NOT NULL,
    PRIMARY KEY (player_id)
);

CREATE TABLE teams(
    team_id INTEGER NOT NULL,
    team_name VARCHAR (300) NOT NULL,
    PRIMARY KEY (team_id)
);

CREATE TABLE matches(
    match_id INTEGER NOT NULL,
    team_1  INTEGER,
    team_2  INTEGER,
    match_date DATETIME NOT NULL,
    season_id INTEGER,
    venue VARCHAR (300),
    toss_winner INTEGER,
    toss_decision VARCHAR (80),
    win_type VARCHAR (80),
    win_margin INTEGER,
    outcome_type VARCHAR (80),
    match_winner INTEGER,
    man_of_the_match INTEGER,
    PRIMARY KEY (match_id),
    FOREIGN KEY (team_1) REFERENCES teams(team_id),
    FOREIGN KEY (team_2) REFERENCES teams(team_id),
    FOREIGN KEY (toss_winner) REFERENCES teams(team_id),
    FOREIGN KEY (match_winner) REFERENCES teams(team_id),
    FOREIGN KEY (man_of_the_match) REFERENCES players(player_id)
);

CREATE TABLE roles(
    match_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    role VARCHAR (80) NOT NULL,
    team_id INTEGER NOT NULL,
    PRIMARY KEY (match_id, player_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);


CREATE TABLE balls(
    match_id INTEGER NOT NULL,
    over_id INTEGER NOT NULL,
    ball_id INTEGER NOT NULL,
    innings_no INTEGER NOT NULL,
    team_batting INTEGER NOT NULL,
    team_bowling INTEGER NOT NULL,
    striker_batting_position INTEGER,
    striker INTEGER NOT NULL,
    non_striker INTEGER NOT NULL,
    bowler INTEGER NOT NULL,
    PRIMARY KEY (match_id, over_id, ball_id, innings_no),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (team_batting) REFERENCES teams(team_id),
    FOREIGN KEY (team_bowling) REFERENCES teams(team_id),
    FOREIGN KEY (striker) REFERENCES players(player_id),
    FOREIGN KEY (non_striker) REFERENCES players(player_id),
    FOREIGN KEY (bowler) REFERENCES players(player_id)
);

CREATE TABLE wickets(
    match_id INTEGER NOT NULL,
    over_id INTEGER NOT NULL,
    ball_id INTEGER NOT NULL,
    player_out INTEGER NOT NULL,
    kind_out VARCHAR (80),
    innings_no INTEGER NOT NULL,
    PRIMARY KEY (match_id, over_id, ball_id, innings_no),
    FOREIGN KEY (match_id, over_id, ball_id, innings_no) REFERENCES balls(match_id, over_id, ball_id, innings_no),
    FOREIGN KEY (player_out) REFERENCES players(player_id)
);

CREATE TABLE runs(
    match_id INTEGER NOT NULL,
    over_id INTEGER NOT NULL,
    ball_id INTEGER NOT NULL,
    runs_scored INTEGER DEFAULT 0,
    innings_no INTEGER NOT NULL,
    PRIMARY KEY(match_id, over_id, ball_id, innings_no),
    FOREIGN KEY (match_id, over_id, ball_id, innings_no) REFERENCES balls(match_id, over_id, ball_id, innings_no)
);

CREATE TABLE extras(
    match_id INTEGER NOT NULL,
    over_id INTEGER NOT NULL,
    ball_id INTEGER NOT NULL,
    extra_type VARCHAR (80),
    extra_runs INTEGER,
    innings_no INTEGER NOT NULL,
    PRIMARY KEY (match_id, over_id, ball_id, innings_no),
    FOREIGN KEY (match_id, over_id, ball_id, innings_no) REFERENCES balls(match_id, over_id, ball_id, innings_no)
);

CREATE VIEW ball_bowler_runs_wnb AS
SELECT *, (runs_scored + IFNULL(extra_runs,0)) as 'total_runs'
FROM balls NATURAL JOIN runs LEFT JOIN (
    SELECT *
    FROM extras 
    WHERE extra_type = "wides" OR "noballs"
) R2 USING(match_id, over_id, ball_id, innings_no);

CREATE VIEW ball_batsman_runs AS
SELECT *
FROM balls NATURAL JOIN runs;
