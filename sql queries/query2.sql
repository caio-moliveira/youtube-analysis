/*

Total Likes and Average Likes by Team

*/


SELECT team_name, SUM(likes) AS total_likes, AVG(likes) AS avg_likes, COUNT(team_name) AS numb_videos
FROM teams
GROUP BY team_name
ORDER BY total_likes DESC, avg_likes;
