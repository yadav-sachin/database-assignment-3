SELECT player_name as 'bowler_name', over_runs as 'runs_scored'
FROM (
SELECT match_id, innings_no, over_id, bowler, over_runs
FROM (
    SELECT
        match_id, over_id, innings_no, bowler, SUM(runs_scored) as 'over_runs'
    FROM
        ball_bowler_runs_wnb
    GROUP BY
        match_id, over_id, bowler, innings_no
) B1 INNER JOIN (
SELECT MIN(over_runs) as 'min_over_runs'
FROM (
SELECT
    match_id, over_id, innings_no, bowler, SUM(runs_scored) as 'over_runs'
FROM
    ball_bowler_runs_wnb
GROUP BY
    match_id, over_id, bowler, innings_no
) A1) B2 ON B1.over_runs = B2.min_over_runs 
ORDER BY match_id ASC, innings_no, over_id) C1 INNER JOIN players WHERE bowler = player_id;