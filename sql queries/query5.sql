/*
5. How do engagement metrics vary over time for each team?
*/
-- Monthly Trends
SELECT 
    team_name, 
    DATEPART(MONTH, published_date) AS publish_month, 
    AVG(likes) AS average_likes, 
    AVG(views) AS average_views, 
    AVG(comment) AS average_comments
FROM 
    brasileiraoA
GROUP BY 
    team_name, 
    DATEPART(MONTH, published_date)
ORDER BY 
    publish_month;








