CREATE VIEW indian_players_view AS
SELECT player_name as 'name', SUM(IFNULL(runs_scored, 0 )) as 'runs'
FROM ball_batsman_runs RIGHT JOIN players ON striker = player_id
WHERE country_name = "India"
GROUP BY player_name;

CREATE TABLE indian_players 
AS (SELECT * FROM indian_players_view ORDER BY name ASC);