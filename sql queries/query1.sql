/*

Total Views and Average Views by Team

*/


SELECT team_name, SUM(views) AS total_views, AVG(views) AS avg_views, COUNT(team_name) AS numb_videos
FROM teams
GROUP BY team_name
ORDER BY total_views DESC, avg_views;
