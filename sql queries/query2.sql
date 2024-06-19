/*
2. Which team has the highest comment engagement  on their videos?
*/

SELECT 
    team_name, 
    SUM(comment) AS engagement_comments, 
    SUM(views) AS engagement_views,
    ROUND(CAST(SUM(views) AS DECIMAL(10, 2)) / CAST(SUM(comment) AS DECIMAL(10, 2)), 2) AS total_engagement_comments
FROM 
    brasileiraoA
GROUP BY 
    team_name
HAVING 
    SUM(likes) IS NOT NULL AND SUM(comment) IS NOT NULL
ORDER BY 
    total_engagement_comments;



