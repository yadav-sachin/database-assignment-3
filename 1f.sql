SELECT player_name as 'batsman_name', average as 'value'
FROM (
    SELECT player_id, player_name, SUM(match_runs) AS 'total_score', COUNT(match_id) AS 'matches_played', SUM(match_runs)/COUNT(match_id) AS 'average'
FROM (
    SELECT match_id, player_id, player_name, SUM(runs_scored) as 'match_runs'
    FROM (ball_batsman_runs LEFT JOIN matches USING (match_id)) INNER JOIN players ON striker = player_id
    WHERE season_id = 2
    GROUP BY match_id, player_id, player_name) A1
GROUP BY player_id, player_name
ORDER BY average DESC
LIMIT 3 ) A2
ORDER BY player_name ASC;