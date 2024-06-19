/*
1. Which team has the highest likes engagement  on their videos?
*/

SELECT 
    team_name, 
    SUM(likes) AS engagement_likes, 
    SUM(views) AS engagement_views,
    ROUND(CAST(SUM(views) AS DECIMAL(10, 2)) / CAST(SUM(likes) AS DECIMAL(10, 2)), 2) AS total_engagement_likes
FROM 
    brasileiraoA
GROUP BY 
    team_name
HAVING 
    SUM(likes) IS NOT NULL AND SUM(views) IS NOT NULL
ORDER BY 
    total_engagement_likes;



