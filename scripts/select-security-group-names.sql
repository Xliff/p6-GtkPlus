SELECT DISTINCT
    JSON_UNQUOTE(
		JSON_EXTRACT(
			JSON_EXTRACT(i1.`security-groups`,  '$[*].GroupName'),
			CONCAT('$[', i2.idx, ']')
		) 
	) GroupName,
    LEFT(`availability-zone`, char_length(`availability-zone`) - 1).
FROM instances i1
JOIN (
  SELECT  0 AS idx UNION ALL
  SELECT  1 UNION ALL
  SELECT  2 UNION ALL
  SELECT  3 UNION ALL
  SELECT  4 UNION ALL
  SELECT  5
) AS i2 ON JSON_EXTRACT(
	JSON_EXTRACT(i1.`security-groups`,  '$[*].GroupName'),
    CONCAT('$[', i2.idx, ']')
) IS NOT NULL
order by 1;

SELECT 
	JSON_EXTRACT(
		`security-groups`,  
        '$[*].GroupName[0]'
	) GroupName
FROM instances