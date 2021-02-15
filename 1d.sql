SELECT player_name as 'bowler_name', average 
FROM (SELECT SUM(total_runs) / COUNT(player_out) as 'average'
FROM ((ball_bowler_runs_wnb INNER JOIN matches USING (match_id)) INNER JOIN players ON bowler = player_id) LEFT JOIN 
(SELECT * FROM wickets 
WHERE NOT(kind_out = "retired hurt" OR kind_out = "obstructing the field" OR kind_out="run out")) A2
USING (match_id, over_id, innings_no, ball_id)
WHERE season_id = 5
GROUP BY bowler, player_name
HAVING COUNT(player_out) > 0
ORDER BY average ASC, player_name ASC
LIMIT 1) Z1 NATURAL JOIN (SELECT player_name, SUM(total_runs) / COUNT(player_out) as 'average'
FROM ((ball_bowler_runs_wnb INNER JOIN matches USING (match_id)) INNER JOIN players ON bowler = player_id) LEFT JOIN 
(SELECT * FROM wickets 
WHERE NOT(kind_out = "retired hurt" OR kind_out = "obstructing the field" OR kind_out="run out")) A2
USING (match_id, over_id, innings_no, ball_id)
WHERE season_id = 5
GROUP BY bowler, player_name
HAVING COUNT(player_out) > 0
ORDER BY average ASC, player_name ASC) Z2
ORDER BY player_name ASC;