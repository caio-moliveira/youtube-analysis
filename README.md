# YouTube Channel Engagement Analysis of Brazilian League Teams

## Project Overview

This project analyzes YouTube engagement for the 20 teams in Brazil's main football league. By extracting the latest 50 videos from each team's official YouTube channel, the data is stored in SQL Server Management Studio (SSMS) and analyzed to compare engagement metrics. The insights gained are visualized through dynamic dashboards in Power BI. The goal is to understand which teams and video content types generate the most engagement, identify trends over time, and provide actionable recommendations for enhancing YouTube presence.


![Alt text](file:///C:/Users/35383/AppData/Local/Temp/Power%20BI%20Desktop/print-job-4e366167-f41c-4ed3-889f-3eca6b5d6a39/dashboard.pdf)


## Objectives

- Extract the latest 50 videos from each team's YouTube channel.
- Store the extracted data in SSMS.
- Analyze the data to compare engagement metrics.
- Visualize the results using Power BI.

## Project Steps

## 1. Data Extraction

Python scripts are used to interact with the YouTube API and extract data. Below are the steps to extract the latest 50 videos for each team.

#### Python Code for Data Extraction

```python
import os
import googleapiclient.discovery
from googleapiclient.discovery import build

youTubeApiKey = "youTubeApiKey"
youtube = build('youtube', 'v3', developerKey=youTubeApiKey)

channel_handle = 'channelName'
search_response = youtube.search().list(
    q=channel_handle,
    type='channel',
    part='id,snippet',
    maxResults=1
).execute()

if 'items' in search_response and len(search_response['items']) > 0:
    channel_id = search_response['items'][0]['snippet']['channelId']
    print(f"Channel ID: {channel_id}")

    try:
        res = youtube.channels().list(part='contentDetails', id=channel_id).execute()
        if 'items' in res and len(res['items']) > 0:
            uploads_playlist_id = res['items'][0]['contentDetails']['relatedPlaylists']['uploads']
        else:
            print("Error: Channel not found or no content details available.")
            uploads_playlist_id = None
    except Exception as e:
        print(f"An error occurred: {e}")
        uploads_playlist_id = None

    if uploads_playlist_id:
        playlist_videos = []
        nextPage_token = None

# ... (rest of the code)
```

*Note: The full Python script is provided in the attached file `channel-extract.ipynb`.*

## 2. Data Storage

The extracted data is moved to a CSV file and then imported into SQL Server Management Studio (SSMS) for further analysis.

## 3. Data Analysis

#### Highest Engagement

- **Team with the highest likes**: 
  - **São Paulo** with 239,715 likes.
  
- **Team with the highest comments**: 
  - **Cruzeiro** with 10,278 comments.
  
- **Team with the highest views**: 
  - **Vasco** with 3,133,404 views.

#### Top-Performing Videos

- **Top video in terms of views**: 
  - **Vasco's video** with 608,316 views.
  
- **Top video in terms of likes**: 
  - **São Paulo's video** with 39,078 likes.
  
- **Top video in terms of comments**: 
  - **Cruzeiro's video** with 2,026 comments.

  #### Key Questions Answered

1) Which team has the highest engagement with likes on their videos?

- The lower the score, the better. **Palmeiras** received a score of **8.67**, indicating that for every **8.67** viewers, **1** liked the video.

```sql
SELECT 
    team_name, 
    SUM(likes) AS engagement_likes, 
    SUM(views) AS engagement_views,
    ROUND(CAST(SUM(views) AS DECIMAL(10, 2)) / CAST(SUM(likes) AS DECIMAL(10, 2)), 2) AS total_engagement_likes
FROM 
    brasileiraoA
GROUP BY 
    team_name
HAVING 
    SUM(likes) IS NOT NULL AND SUM(views) IS NOT NULL
ORDER BY 
    total_engagement_likes;
```

2) Which team has the highest engagement with comments on their videos?

- The lower the score, the better. **Juventude** received a score of **175.63**, indicating that for every **175.63** viewers, **1** liked the video.

3) What are the top-performing videos in terms of views, likes, and comments?

#### Top-Performing Videos by Views

| Video ID     | Team         | Views   |
|--------------|--------------|---------|
| pLg5zInqLmA  | Vasco        | 608,316 |
| #NAME?       | Cruzeiro     | 433,113 |
| C03as2yI2BQ  | Cruzeiro     | 427,389 |
| d4VI5GrqIGg  | Fluminense   | 406,380 |
| qTbVPMNKArw  | São Paulo    | 370,966 |
| xSXaVS3DL64  | Flamengo     | 354,573 |
| qFlJuehyCuM  | Flamengo     | 331,801 |
| DDio0TNbgyc  | Corinthians  | 307,540 |
| dRCAi6EGQug  | Cuiabá       | 254,956 |
| gofJhZcjAq0  | Vasco        | 252,637 |

#### Top-Performing Videos by Likes

| Video ID     | Team         | Likes   |
|--------------|--------------|---------|
| qTbVPMNKArw  | São Paulo    | 39,078  |
| d4VI5GrqIGg  | Fluminense   | 27,555  |
| qy3TJejV5lc  | São Paulo    | 26,461  |
| #NAME?       | Cruzeiro     | 21,316  |
| qFlJuehyCuM  | Flamengo     | 20,916  |
| DDio0TNbgyc  | Corinthians  | 20,165  |
| BWxFHmPLsXA  | Vasco        | 19,662  |
| cvesVnaEMhQ  | São Paulo    | 19,359  |
| C03as2yI2BQ  | Cruzeiro     | 19,043  |
| AdsyeanM6BI  | Corinthians  | 18,035  |

#### Top-Performing Videos by Comments

| Video ID     | Team         | Comments |
|--------------|--------------|----------|
| C03as2yI2BQ  | Cruzeiro     | 2,026    |
| qTbVPMNKArw  | São Paulo    | 1,314    |
| #NAME?       | Cruzeiro     | 1,219    |
| ddEZXb131x0  | São Paulo    | 893      |
| qy3TJejV5lc  | São Paulo    | 879      |
| DDio0TNbgyc  | Corinthians  | 846      |
| ePNJOQFPfbs  | Vasco        | 773      |
| BWxFHmPLsXA  | Vasco        | 674      |
| XDDbodCztfY  | Vasco        | 602      |
| AWWynz4S6CQ  | Fluminense   | 531      |



4) What is the average number of likes, views, and comments per video for each team?

- **NULL** values indicate information that could not be extracted from YouTube API, such as likes from Botafogo's and Athletico Paranaense's videos, and comments from Vitória's.

#### Average Engagement Per Team

| Team                  | Avg Likes | Avg Views | Avg Comments |
|-----------------------|-----------|-----------|--------------|
| Vasco                 | 3,602     | 62,668    | 157          |
| São Paulo             | 4,794     | 51,855    | 149          |
| Cruzeiro              | 4,354     | 43,472    | 205          |
| Flamengo              | 2,491     | 36,895    | 30           |
| Corinthians           | 2,838     | 32,607    | 88           |
| Fluminense            | 2,316     | 31,719    | 80           |
| Grêmio                | 1,374     | 26,962    | 56           |
| Botafogo              | NULL      | 19,209    | 67           |
| Palmeiras             | 2,119     | 18,369    | 77           |
| Atletico Mineiro      | 1,362     | 17,114    | 33           |
| Bahia                 | 990       | 14,208    | 33           |
| Vitória               | 795       | 12,593    | NULL         |
| Fortaleza             | 807       | 11,061    | 45           |
| Cuiabá                | 242       | 8,952     | 21           |
| Internacional         | 635       | 7,120     | 35           |
| Criciúma              | 169       | 4,232     | 7            |
| Bragantino            | 92        | 2,581     | 4            |
| Juventude             | 133       | 2,075     | 11           |
| Atletico Goianiense   | NULL      | 1,456     | 13           |
| Athletico Paranaense  | 97        | 1,377     | 5            |


### Key Performance Indicators (KPIs)

- The KPIs will appear on the dashboard created in the next chapter using PowerBI and will display the following analysis:

- **Average Views per Video**
  - *Formula:* Total Views / Number of Videos
  - *Description:* Indicates the overall popularity and reach of the videos.
  
- **Average Likes per Video**
  - *Formula:* Total Likes / Number of Videos
  - *Description:* Reflects the audience's approval and satisfaction with the content.
  
- **Average Comments per Video**
  - *Formula:* Total Comments / Number of Videos
  - *Description:* Shows the level of interaction and engagement from the audience.
  
- **Engagement Rate per Video**
  - *Formula:* (Total Likes + Total Comments) / Total Views * 100%
  - *Description:* Provides a comprehensive measure of how actively the audience is engaging with the videos.
  
- **Top 10 Videos by Views, Likes, and Comments**
  - *Description:* Highlight the most successful content based on different engagement metrics.


## 4. Data Visualization

The analyzed data is visualized using Power BI. By connecting Power BI to the SSMS database, interactive dashboards are created to showcase the insights.

## Requirements

- Python 3.x
- YouTube Data API v3
- SQL Server Management Studio (SSMS)
- Power BI
- Libraries: `google-api-python-client`

## Conclusion

This project demonstrates the process of extracting, storing, analyzing, and visualizing YouTube engagement data for Brazilian league teams. By leveraging Python, SSMS, and Power BI, valuable insights into the YouTube performance of these teams are gained.

## Contributions

Contributions are welcome! Please feel free to submit a pull request or open an issue to discuss any changes or improvements.

---

Feel free to adjust any sections as necessary to better fit your specific project details or preferences.
