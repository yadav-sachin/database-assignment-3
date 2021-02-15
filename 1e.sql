SELECT player_name as 'batsman_name', MAX(match_score) as 'runs'
FROM (
    SELECT match_id, player_id, player_name, SUM(runs_scored) as 'match_score'
    FROM ball_batsman_runs INNER JOIN players ON striker = player_id
    GROUP BY match_id, player_id, player_name
    ) A1
GROUP BY player_id, player_name
HAVING runs > 100
ORDER BY player_name ASC;