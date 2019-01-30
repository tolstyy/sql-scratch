SELECT COUNT (DISTINCT utm_campaign) AS 'number_of_campaigns'
FROM page_visits
;

SELECT COUNT (DISTINCT utm_source) AS 'number_of_sources'
FROM page_visits
;

SELECT DISTINCT utm_source,
utm_campaign
FROM page_visits
ORDER BY utm_source
;
/* additional query that is included in my pptx presentation */
SELECT DISTINCT utm_source,
	utm_campaign
FROM page_visits
WHERE utm_source IN ('email','google')
;

--------------

SELECT DISTINCT page_name
FROM page_visits
;

/* additional query that is included in my pptx presentation */
SELECT COUNT (DISTINCT user_id) AS 'dist_visits_per_page',
	page_name
FROM page_visits
GROUP BY 2
ORDER BY 1 DESC
;

/* additional query that is included in my pptx presentation */

SELECT COUNT (*) AS 'total_visits'
FROM page_visits
GROUP BY page_name
;
SELECT COUNT (DISTINCT user_id) AS 'unique_visits'
FROM page_visits
GROUP BY page_name
;


WITH first_touch AS (
	SELECT user_id,
	MIN (timestamp) AS 'first_touch_at'
FROM page_visits
GROUP BY user_id)
SELECT COUNT (ft.user_id) AS 'ft_per_campaign',
	pv.utm_campaign AS 'name_of_campaign'
FROM first_touch ft
JOIN page_visits pv
ON ft.user_id = pv.user_id
WHERE ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC
;


WITH first_touch AS (
	SELECT user_id,
	MIN (timestamp) AS 'first_touch_at'
FROM page_visits
GROUP BY user_id)
SELECT COUNT (ft.user_id) AS 'ft_campaign',
	pv.utm_campaign AS 'name_of_campaign',
	pv.utm_source AS 'source'
FROM first_touch ft
JOIN page_visits pv
ON ft.user_id = pv.user_id
WHERE ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC
;

/* additional query that is included in my pptx presentation */

SELECT COUNT (*) AS 'total_visits',
	utm_campaign,
	utm_source
FROM page_visits
WHERE page_name = '1 - landing_page'
GROUP BY 2
ORDER BY 1 DESC
;

SELECT COUNT (*) AS 'total_visits',
	utm_campaign,
	utm_source
FROM page_visits
WHERE page_name = '4 - purchase'
GROUP BY 2
ORDER BY 1 DESC
;


WITH last_touch AS (
	SELECT utm_campaign,
	MAX (timestamp) AS 'lt_touch_at',
	user_id
FROM page_visits
GROUP BY user_id)
SELECT COUNT (lt.lt_touch_at) As 'lt_campaign',
	pv.utm_campaign AS 'name_of_campaign'
FROM last_touch lt
JOIN page_visits pv
ON lt.user_id = pv.user_id
WHERE lt.lt_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC
;

WITH last_touch AS (
	SELECT utm_campaign,
	MAX (timestamp) AS 'lt_touch_at',
	user_id
FROM page_visits
GROUP BY user_id)
SELECT COUNT (lt.lt_touch_at) As 'lt_campaign',
	pv.utm_campaign AS 'name_of_campaign'
FROM last_touch lt
JOIN page_visits pv
ON lt.user_id = pv.user_id
WHERE lt.lt_touch_at = pv.timestamp
AND page_name = '4 - purchase'
GROUP BY 2
ORDER BY 1 DESC
;














