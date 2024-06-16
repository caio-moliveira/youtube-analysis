/*

Total Comments and Average Comments by Team

*/


SELECT team_name, SUM(comment) AS total_comment, AVG(comment) AS avg_comment, COUNT(team_name) AS numb_videos
FROM teams
GROUP BY team_name
ORDER BY total_comment DESC, avg_comment;
