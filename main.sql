select 
-- CREATE COLUMNS FROM OCCUPATION TYPES
group_concat(if (occupation='doctor', name, null)),
group_concat(if (occupation='professor', name, null)),
group_concat(if (occupation='singer', name, null)),
group_concat(if (occupation='actor', name, null))
-- CREATE SOURCE WHERE TABLE IS PARTIONED, PIVOTED, AND GROUPED BY OCCUPATION
-- "row_number()" IS REQUIRED FOR THE OVER PARTITION
-- T1 AND T2 ALIASES ARE NECESSARY BECAUSE OF THE AGG FUNCTION IN THE COLUMNS BUT ARE NOT OTHERWISE REFERENCED EXCEPT FOR THE T2 GROUPING
FROM
    (select occupation, name, row_number() OVER (PARTITION BY occupation order by name) AS t2
        FROM occupations) as t1
    GROUP BY t2