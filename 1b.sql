SELECT
    player_name as 'name',
    COUNT(player_out) as 'frequency'
FROM
    players
    LEFT JOIN (SELECT * FROM wickets WHERE kind_out = "caught") A2 ON player_id = player_out
GROUP BY
    player_name
ORDER BY
    COUNT(player_out) ASC,
    player_name ASC;