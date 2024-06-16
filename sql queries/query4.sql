/*

Engagement Rate by Team

*/


SELECT team_name, 
       ROUND(AVG(CAST(likes AS FLOAT)) / AVG(CAST(views AS FLOAT)) * 100, 2) AS average_likes_per_view,
       ROUND(AVG(CAST(comment AS FLOAT)) / AVG(CAST(views AS FLOAT)) * 100, 2) AS average_comments_per_view
FROM teams
GROUP BY team_name
ORDER BY average_likes_per_view DESC, average_comments_per_view DESC;



