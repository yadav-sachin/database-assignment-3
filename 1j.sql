SELECT player_name as 'name', total_runs as 'runs'
FROM ( SELECT player_id, SUM(runs_scored) AS 'total_runs'
FROM (ball_batsman_runs as T1 INNER JOIN (SELECT * FROM matches WHERE season_id = 3) M1 USING(match_id)) INNER JOIN (SELECT * FROM roles WHERE role = "Captain") C1 ON T1.match_id = C1.match_id AND striker = player_id AND team_batting = team_id
WHERE role = "Captain" AND season_id = 3
GROUP BY player_id
HAVING SUM(runs_scored) > 50 ) Z1 INNER JOIN players USING (player_id)
ORDER BY player_name ASC;