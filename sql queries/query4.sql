/*
4. Measure the average number of likes, views, and comments per video for each team.
*/

SELECT 
    team_name, 
    AVG(likes) AS average_likes, 
    AVG(views) AS average_views, 
    AVG(comment) AS average_comments
FROM 
    brasileiraoA
GROUP BY 
    team_name
ORDER BY 
    average_views DESC, average_likes, average_comments;




