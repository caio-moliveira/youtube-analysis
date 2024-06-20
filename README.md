Here is a reorganized and more structured README file for your project, formatted in Markdown to enhance readability and professionalism.

---

# YouTube Channel Engagement Analysis of Brazilian League Teams

## Project Overview

This project analyzes YouTube engagement for the 20 teams in Brazil's main football league. By extracting the latest 50 videos from each team's official YouTube channel, the data is stored in SQL Server Management Studio (SSMS) and analyzed to compare engagement metrics. The insights gained are visualized through dynamic dashboards in Power BI. The goal is to understand which teams and video content types generate the most engagement, identify trends over time, and provide actionable recommendations for enhancing YouTube presence.

## Objectives

- Extract the latest 50 videos from each team's YouTube channel.
- Store the extracted data in SSMS.
- Analyze the data to compare engagement metrics.
- Visualize the results using Power BI.

## Project Steps

### 1. Data Extraction

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

### 2. Data Storage

The extracted data is moved to a CSV file and then imported into SQL Server Management Studio (SSMS) for further analysis.

### 3. Data Analysis

Data analysis is performed using SQL queries within SSMS to retrieve insights. Example analysis includes calculating average views, likes, and comments for each channel.

#### Example SQL Query for Analysis

```sql
SELECT 
    channel_id,
    AVG(views) AS avg_views,
    AVG(likes) AS avg_likes,
    AVG(comment) AS avg_comments
FROM 
    brasileiraoA
GROUP BY 
    channel_id
```

### Key Questions Answered

- Which team has the highest engagement with likes on their videos?
- Which team has the highest engagement with comments on their videos?
- What are the top-performing videos in terms of views, likes, and comments?
- What is the average number of likes, views, and comments per video for each team?

### Key Performance Indicators (KPIs)

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

### 4. Data Visualization

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
