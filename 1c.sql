SELECT venue as 'venue_name', number_of_legbye_runs
FROM (SELECT venue, SUM(IFNULL(extra_runs,0)) as 'number_of_legbye_runs'
FROM matches LEFT JOIN (SELECT * FROM extras WHERE extra_type = "legbyes") A2 USING(match_id)
GROUP BY venue
ORDER BY number_of_legbye_runs DESC, venue ASC) C1 INNER JOIN (SELECT SUM(IFNULL(extra_runs,0)) as 'number_of_legbye_runs'
FROM matches LEFT JOIN (SELECT * FROM extras WHERE extra_type = "legbyes") A2 USING(match_id)
GROUP BY venue
ORDER BY number_of_legbye_runs DESC
LIMIT 1) B1 USING(number_of_legbye_runs);
