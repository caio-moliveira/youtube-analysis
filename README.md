## YouTube Channel Engagement Analysis of Brazilian League Teams

## About

This project analyzes YouTube engagement for the 20 teams in Brazil's main football league. By extracting the latest 50 videos from each team's official YouTube channel, we store the data in SQL Server Management Studio (SSMS) and perform detailed analysis to compare their engagement metrics. The insights gained are visualized through dynamic dashboards in Power BI. Our goal is to understand which teams and video content types generate the most engagement, identify trends over time, and provide actionable recommendations for enhancing YouTube presence. This fusion of data extraction, storage, and visualization showcases the power of integrating multiple tools to derive meaningful insights from social media data.



### Objectives
- Extract the latest 50 videos from each team's YouTube channel.
- Store the extracted data in SSMS.
- Analyze the data to compare engagement metrics.
- Visualize the results using Power BI.

### Project Overview

#### 1. Data Extraction
We use Python scripts to interact with the YouTube API and extract data. Below are the steps to extract the latest 50 videos for each team.

**Python Code for Data Extraction:**
```python
import os
import googleapiclient.discovery

def get_videos(channel_id, api_key):
    youtube = googleapiclient.discovery.build('youtube', 'v3', developerKey=api_key)

    request = youtube.search().list(
        part="snippet",
        channelId=channel_id,
        maxResults=50,
        order="date"
    )
    response = request.execute()
    
    videos = []
    for item in response['items']:
        video_data = {
            'video_id': item['id']['videoId'],
            'title': item['snippet']['title'],
            'published_at': item['snippet']['publishedAt']
        }
        videos.append(video_data)
    return videos

```

#### 2. Data Storage
Store the extracted data in SQL Server Management Studio (SSMS) for further analysis. 


#### 3. Data Analysis
Perform data analysis using SQL queries within SSMS to retrieve insights. For example, calculate average views, likes, and comments for each channel.

##### Questions to be Answered

1. **Which team has the highest average engagement on their videos?**
   - Measure the average number of likes, views, and comments per video for each team.

2. **What are the top-performing videos in terms of views, likes, and comments?**
   - Identify the top 10 videos for each metric.

3. **How do engagement metrics vary over time for each team?**
   - Analyze trends in likes, views, and comments over different periods (e.g., monthly, quarterly).

4. **Which video content types or topics generate the most engagement?**
   - Use video titles and descriptions to categorize content and compare engagement metrics across categories.

5. **Is there a correlation between the publishing time and the engagement received?**
   - Analyze if videos published at specific times of the day or week have higher engagement.

##### Key Performance Indicators (KPIs)

1. **Average Views per Video**
   - Formula: Total Views / Number of Videos
   - Indicates the overall popularity and reach of the videos.

2. **Average Likes per Video**
   - Formula: Total Likes / Number of Videos
   - Reflects the audience's approval and satisfaction with the content.

3. **Average Comments per Video**
   - Formula: Total Comments / Number of Videos
   - Shows the level of interaction and engagement from the audience.

4. **Engagement Rate per Video**
   - Formula: (Total Likes + Total Comments) / Total Views * 100%
   - Provides a comprehensive measure of how actively the audience is engaging with the videos.

5. **Top 10 Videos by Views, Likes, and Comments**
   - Highlight the most successful content based on different engagement metrics.


**Example SQL Query for Analysis:**
```sql
SELECT 
    channel_id,
    AVG(views) AS avg_views,
    AVG(likes) AS avg_likes,
    AVG(comments) AS avg_comments
FROM 
    YouTubeVideos
GROUP BY 
    channel_id
```

#### 4. Data Visualization
Visualize the analyzed data using Power BI. Connect Power BI to the SSMS database and create interactive dashboards to showcase the insights.

### Requirements
- Python 3.x
- YouTube Data API v3
- SQL Server Management Studio (SSMS)
- Power BI
- Libraries: `google-api-python-client`, `pyodbc`

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/YouTubeEngagementAnalysis.git
   ```
2. Install the required Python libraries:
   ```bash
   pip install google-api-python-client pyodbc
   ```
3. Set up your YouTube Data API key and SSMS credentials in the `config.py` file.


### Conclusion
This project demonstrates the process of extracting, storing, analyzing, and visualizing YouTube engagement data for Brazilian league teams. By leveraging Python, SSMS, and Power BI, we can gain valuable insights into the YouTube performance of these teams.

### Contributions
Contributions are welcome! Please feel free to submit a pull request or open an issue to discuss any changes or improvements.


