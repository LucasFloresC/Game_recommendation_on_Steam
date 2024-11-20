# Objetivos
# Encontrar top juegos por año (2020,2021,2022,2023)
# Encontrar peores juegos por año (2020,2021,2022,2023) 
# Media de los ratings de esos juegos 
# Media de horas jugadas a esos juegos 


SELECT *
FROM games.game;

SELECT *
FROM games.users;

SELECT *
FROM games.recommendations;

-- TOP JUEGOS 2020
-- Utilizamos una CTE para filtrar en la tabla por año 
WITH good_games_2020 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2020 AND año < 2021 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating 

	,top_games_2020 AS (
		SELECT app_id,
			title,
			año,
			date_release,
			price_final,
			price_original,
			(price_original - price_final) AS diff,
			AVG(positive_ratio) AS Ratio_20,
			AVG(user_reviews) AS user_rev_20,
			MAX(user_reviews) AS max_rev_20
			FROM good_games_2020
			GROUP BY app_id, title, date_release, año, price_final, price_original
			ORDER BY Ratio_20 DESC, user_rev_20 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la maxima ratio, teniendo en cuenta las mejores puntiaciones de los users        
	SELECT *, RANK() over (order by max_rev_20 DESC) AS 'rank_20'
    FROM top_games_2020
    WHERE Ratio_20 = 100
    LIMIT 10;
    
-- APP_ID: 1422050, 1176050,1290220,1770090,1424630,1395730,1242754,1327820,1418570,1232010 
   
-- TOP JUEGOS 2021
-- Utilizamos una CTE para filtrar en la tabla por año y rating
WITH good_games_2021 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2021 AND año < 2022 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_games_2021 AS (
		SELECT app_id,
			title,
			año,
			date_release,
			price_original,
			price_final,
			(price_original - price_final) AS diff,
			MAX(positive_ratio) AS Ratio_21,
			AVG(user_reviews) AS user_rev_21,
			MAX(user_reviews) AS max_rev_21
			FROM good_games_2021
			GROUP BY app_id, title, año, date_release, price_original, price_final
			ORDER BY Ratio_21 DESC, user_rev_21 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la maxima ratio, teniendo en cuenta las mejores puntiaciones de los users   
     
	SELECT *, RANK() over (order by max_rev_21 DESC) AS 'rank'
    FROM top_games_2021
    WHERE Ratio_21 = 100
    LIMIT 10;
 
 -- APP_ID: 1590900, 1727520,1801660,1796170,1727830,1773090,1527850,1674270,1229060,1400910
 
 -- TOP JUEGOS 2022
 
WITH good_games_2022 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2022 AND año < 2023 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_games_2022 AS (
		SELECT app_id,
			title,
			date_release,
			año,
			price_original,
			price_final,
			(price_original - price_final) AS diff,
			MAX(positive_ratio) AS Ratio_22,
			AVG(user_reviews) AS user_rev_22,
			MAX(user_reviews) AS max_rev_22
			FROM good_games_2022
			GROUP BY app_id, title, date_release, año, price_original, price_final
			ORDER BY Ratio_22 DESC, user_rev_22 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la maxima ratio, teniendo en cuenta las mejores puntiaciones de los users        
	SELECT *, RANK() over (order by max_rev_22 DESC) AS 'rank_22'
    FROM top_games_2022
    WHERE Ratio_22 = 100
    LIMIT 10;

-- APP_ID: 2206340,2112520,1420810,2084930,1532710,1925870,1029650,1667320,1192440,1857650

-- TOP JUEGOS 2023
WITH good_games_2023 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2023
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_games_2023 AS (
		SELECT app_id,
			title,
			date_release, 
			price_original,
			price_final,
			(price_original - price_final) AS diff,
			MAX(positive_ratio) AS Ratio_23,
			AVG(user_reviews) AS user_rev_23, 
			MAX(user_reviews) AS max_rev_23
			FROM good_games_2023
			GROUP BY app_id, title, date_release, price_original, price_final
			ORDER BY Ratio_23 DESC, user_rev_23 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la maxima ratio, teniendo en cuenta las mejores puntiaciones de los users        
	SELECT *, RANK() over (order by max_rev_23 DESC) AS 'rank_23'
    FROM top_games_2023
    WHERE Ratio_23 = 100
    LIMIT 10;

-- APP_ID: 2262610,2443110,2128270,1882500,1707400,2055910,2205290,1955830,2059660,2078510     
    
-- Exploramos las otras tablas
-- Podemos hacer JOINS entre game y recommendations

-- Unimos Game con recommendations y users para ver la big picture
-- Miramos del TOP juegos 2020 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id, 
		title, 
		date_release,
		g.año, hours,
		u.user_id 
		FROM games.game AS g
		LEFT JOIN games.recommendations AS r
		ON g.app_id = r.app_id
		LEFT JOIN games.users AS u
		ON r.user_id = u.user_id
		WHERE g.app_id IN (1422050, 1176050,1290220,1770090,1424630,1395730,1242754,1327820,1418570,1232010)
)sub1
WHERE user_id IS NOT NULL
;

-- Miramos del TOP juegos 2021 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id,
		title,
		date_release,
		g.año,
		hours,
		u.user_id 
		FROM games.game AS g
		LEFT JOIN games.recommendations AS r
		ON g.app_id = r.app_id
		LEFT JOIN games.users AS u
		ON r.user_id = u.user_id
		WHERE g.app_id IN (1590900, 1727520,1801660,1796170,1727830,1773090,1527850,1674270,1229060,1400910)
)sub2
WHERE user_id IS NOT NULL
;

-- Miramos del TOP juegos 2022 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id,
		title,
		date_release,
		g.año,
		cast(hours AS float) AS hours,
		u.user_id 
		FROM games.game AS g
		LEFT JOIN games.recommendations AS r
		ON g.app_id = r.app_id
		LEFT JOIN games.users AS u
		ON r.user_id = u.user_id
		WHERE g.app_id IN (2206340,2112520,1420810,2084930,1532710,1925870,1029650,1667320,1192440,1857650)
)sub3
WHERE user_id IS NOT NULL
;


-- Miramos del TOP juegos 2023 por año las horas por cada juego, de 2023 no podemos sacar estos datos.
-- Ya que no tenemos datos disponibles para las horas y los usuarios, esto se debe a que la el data set es de 2023 
-- Suponemos que faltan datos por actualizar

SELECT *
FROM (
	SELECT 
		g.app_id, 
		title,
		date_release,
		g.año,
		hours,
		u.user_id
	FROM games.game AS g
	LEFT JOIN games.recommendations AS r
	ON g.app_id = r.app_id
	LEFT JOIN games.users AS u
	ON r.user_id = u.user_id
	WHERE g.app_id IN (2262610,2443110,2128270,1882500,1707400,2055910,2205290,1955830,2059660,2078510)
)sub4
;

-- TOP PEORES JUEGOS 2020
-- Utilizamos una CTE para filtrar en la tabla por año 
WITH bad_games_2020 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2020 AND año < 2021 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por  el minimo positive rating 

	,top_bad_games_2020 AS (
		SELECT app_id, 
        title, 
        año, 
        date_release,
        price_final,
        price_original,
        (price_original - price_final) AS diff,
        MIN(positive_ratio) AS min_ratio_20,
        AVG(user_reviews) AS user_rev_20, 
        MIN(user_reviews) AS min_rev_20
		FROM bad_games_2020
		GROUP BY app_id, title, date_release, año, price_final, price_original
		ORDER BY min_ratio_20, user_rev_20 DESC
        )
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir del minimo ratio, teniendo en cuenta las peores puntiaciones de los users
        
	SELECT *, RANK() over (order by min_rev_20 ASC) AS 'rank_20'
    FROM top_bad_games_2020
    WHERE min_ratio_20 BETWEEN 0 AND 10
    LIMIT 10
    ;
    
-- APP_ID: 1374740,1312740,1304100,1430980,667170,1194690,1360360,1429751,1300450
   
-- TOP PEORES JUEGOS 2021
-- Utilizamos una CTE para filtrar en la tabla por año y rating
WITH bad_games_2021 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2021 AND año < 2022 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_bad_games_2021 AS (
		SELECT app_id,
        title,
        año,
        date_release,
        price_original,
        price_final,
        (price_original - price_final) AS diff,
        MIN(positive_ratio) AS min_ratio_21,
        AVG(user_reviews) AS user_rev_21,
        MIN(user_reviews) AS min_rev_21
		FROM bad_games_2021
		GROUP BY app_id, title, año, date_release, price_original, price_final
		ORDER BY min_ratio_21, user_rev_21 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la minima ratio, teniendo en cuenta las peores puntiaciones de los users   
     
	SELECT *, RANK() over (order by min_rev_21 ASC) AS 'rank'
    FROM top_bad_games_2021
    WHERE min_ratio_21 BETWEEN 0 AND 10
    LIMIT 10;
 
 -- APP_ID: 1416420,1500320,2146190,1752830,917020,1703151,1597260,1390650,1270520,1717658
 
 -- TOP PEORES JUEGOS 2022
 
WITH bad_games_2022 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2022 AND año < 2023 
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_bad_games_2022 AS (
		SELECT app_id,
        title,
        date_release,
        año,
        price_original, 
        price_final, 
        (price_original - price_final) AS diff,
        MIN(positive_ratio) AS min_ratio_22,
        AVG(user_reviews) AS user_rev_22, 
        MIN(user_reviews) AS min_rev_22
		FROM bad_games_2022
		GROUP BY app_id, title, date_release, año, price_original, price_final
		ORDER BY min_ratio_22 , user_rev_22 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la minima ratio, teniendo en cuenta las peores puntiaciones de los users        
	SELECT *, RANK() over (order by min_rev_22 ASC) AS 'rank_22'
    FROM top_bad_games_2022
    WHERE min_ratio_22 BETWEEN 0 AND 10
    LIMIT 10;

-- APP_ID: 2098860,1932670,2229080,2008010,2167800,1877360,1940762,2117780,1915410,2078460

-- TOP PEORES JUEGOS 2023
WITH bad_games_2023 AS (
	SELECT *
	FROM games.game
	WHERE año >= 2023
	ORDER BY date_release ASC)

-- Volvemos a filtrar por rating pero numericamente

	,top_bad_games_2023 AS (
		SELECT app_id,
        title, 
        date_release,
        price_original,
        price_final,
        (price_original - price_final) AS diff,
        MIN(positive_ratio) AS min_ratio_23,
        AVG(user_reviews) AS user_rev_23,
        MIN(user_reviews) AS min_rev_23
		FROM bad_games_2023
		GROUP BY app_id, title, date_release, price_original, price_final
		ORDER BY min_ratio_23, user_rev_23 DESC)
        
-- Hacemos un ranking para quedarnos con el TOP 10 a partir de la minima ratio, teniendo en cuenta las peores puntiaciones de los users        
	SELECT *, RANK() over (order by min_rev_23 DESC) AS 'rank_23'
    FROM top_bad_games_2023
    WHERE min_ratio_23 BETWEEN 0 AND 10
    LIMIT 10;

-- APP_ID: 2357570,2338770,2185750,2104734,2104732,2104731,2104733,2010380,2403280,2197253

-- Miramos del TOP PEORES juegos 2020 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id,
    title,
    date_release,
    g.año,
    hours,
    u.user_id 
	FROM games.game AS g
	LEFT JOIN games.recommendations AS r
	ON g.app_id = r.app_id
	LEFT JOIN games.users AS u
	ON r.user_id = u.user_id
	WHERE g.app_id IN (1374740,1312740,1304100,1430980,667170,1194690,1360360,1429751,1300450)
)sub5
;

-- Miramos del TOP PEORES juegos 2021 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id,
    title,
    date_release,
    g.año,
    hours,
    u.user_id 
	FROM games.game AS g
	LEFT JOIN games.recommendations AS r
	ON g.app_id = r.app_id
	LEFT JOIN games.users AS u
	ON r.user_id = u.user_id
	WHERE g.app_id IN (1416420,1500320,2146190,1752830,917020,1703151,1597260,1390650,1270520,1717658)
)sub6
WHERE user_id IS NOT NULL
;

-- Miramos del TOP PEORES juegos 2022 por año las horas por cada juego ignorando los nulls que salgan ya que son muy pocos

SELECT *
FROM (
	SELECT g.app_id,
    title,
    date_release,
    g.año,
    hours,
    u.user_id 
	FROM games.game AS g
	LEFT JOIN games.recommendations AS r
	ON g.app_id = r.app_id
	LEFT JOIN games.users AS u
	ON r.user_id = u.user_id
	WHERE g.app_id IN (2098860,1932670,2229080,2008010,2167800,1877360,1940762,2117780,1915410,2078460)
)sub3
WHERE user_id IS NOT NULL
;


-- Miramos del TOP PEORES juegos 2023 por año las horas por cada juego, de 2023 no podemos sacar estos datos.
-- Ya que no tenemos datos disponibles para las horas y los usuarios, esto se debe a que la el data set es de 2023 
-- Suponemos que faltan datos por actualizar

SELECT *
FROM (
	SELECT g.app_id,
    title,
    date_release, 
    g.año, 
    hours,
    u.user_id 
	FROM games.game AS g
	LEFT JOIN games.recommendations AS r
	ON g.app_id = r.app_id
	LEFT JOIN games.users AS u
	ON r.user_id = u.user_id
	WHERE g.app_id IN (2357570,2338770,2185750,2104734,2104732,2104731,2104733,2010380,2403280,2197253)
)sub4
;