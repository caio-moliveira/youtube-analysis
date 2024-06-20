/*
Team with the highest likes // Team with the highest comments

*/

-- top 1 team with likes
SELECT TOP 1
team_name, sum(likes) AS sum_likes
FROM brasileiraoA
GROUP BY team_name
ORDER BY sum_likes DESC;

-- top 1 team with comments
SELECT TOP 1
team_name, sum(comment) AS sum_comments
FROM brasileiraoA
GROUP BY team_name
ORDER BY sum_comments DESC;

-- top 1 team with views
SELECT TOP 1
team_name, sum(views) AS sum_views
FROM brasileiraoA
GROUP BY team_name
ORDER BY sum_views DESC;