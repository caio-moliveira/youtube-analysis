/*
5. How do engagement metrics vary over time for each team?
*/
-- Monthly Trends
-- Example: Analyze engagement based on the hour of publishing
SELECT 
    team_name, 
    HOUR(TIMESTAMP(published_date)) AS publish_hour, 
    AVG(likes) AS average_likes, 
    AVG(views) AS average_views, 
    AVG(comment) AS average_comments
FROM 
    brasileiraoA
GROUP BY 
    team_name, 
    month(TIMESTAMP(published_date))
ORDER BY 
    publish_hour;






