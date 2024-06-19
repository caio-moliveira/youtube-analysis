/*
3. What are the top-performing videos in terms of views, likes, and comments?
*/

-- Top 10 Videos by Views
SELECT TOP 10 
    video_id, 
    team_name, 
    views
FROM 
    brasileiraoA
ORDER BY 
    views DESC;

-- Top 10 Videos by Likes
SELECT TOP 10
    video_id, 
    team_name, 
    likes
FROM 
    brasileiraoA
ORDER BY 
    likes DESC;


-- Top 10 Videos by Comments
SELECT TOP 10
    video_id, 
    team_name, 
    comment
FROM 
    brasileiraoA
ORDER BY 
    comment DESC;




