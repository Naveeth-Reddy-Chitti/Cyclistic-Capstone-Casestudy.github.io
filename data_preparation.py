# Data Preperation - Capstone Project - Cyclistic data

# Mounting drive
from google.colab import drive
drive.mount('/content/drive/')

# read all 12 months csv files as dataframes
df1 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202203-divvy-tripdata.csv")
df2 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202202-divvy-tripdata.csv")
df3 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202201-divvy-tripdata.csv")
df4 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202112-divvy-tripdata.csv")
df5 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202111-divvy-tripdata.csv")
df6 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202110-divvy-tripdata.csv")
df7 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202109-divvy-tripdata.csv")
df8 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202108-divvy-tripdata.csv")
df9 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202107-divvy-tripdata.csv")
df10 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202106-divvy-tripdata.csv")
df11 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202105-divvy-tripdata.csv")
df12 = pd.read_csv("/content/drive/MyDrive/Cyclistic data/202104-divvy-tripdata.csv")


# Date formats are different for each month file. Making each of them consistent. 

df1['started_at'] = pd.to_datetime(df1['started_at'], format='%m/%d/%Y %H:%M')
df1['ended_at'] = pd.to_datetime(df1['ended_at'], format='%m/%d/%Y %H:%M')

df2['started_at'] = pd.to_datetime(df2['started_at'], format='%Y/%m/%d %H:%M:%S')
df2['ended_at'] = pd.to_datetime(df2['ended_at'], format='%Y/%m/%d %H:%M:%S')

df3['started_at'] = pd.to_datetime(df3['started_at'], format='%Y/%m/%d %H:%M:%S')
df3['ended_at'] = pd.to_datetime(df3['ended_at'], format='%Y/%m/%d %H:%M:%S')

df4['started_at'] = pd.to_datetime(df4['started_at'], format='%Y/%m/%d %H:%M:%S')
df4['ended_at'] = pd.to_datetime(df4['ended_at'], format='%Y/%m/%d %H:%M:%S')

df5['started_at'] = pd.to_datetime(df5['started_at'], format='%Y/%m/%d %H:%M:%S')
df5['ended_at'] = pd.to_datetime(df5['ended_at'], format='%Y/%m/%d %H:%M:%S')

df6['started_at'] = pd.to_datetime(df6['started_at'], format='%Y/%m/%d %H:%M:%S')
df6['ended_at'] = pd.to_datetime(df6['ended_at'], format='%Y/%m/%d %H:%M:%S')

df7['started_at'] = pd.to_datetime(df7['started_at'], format='%m/%d/%Y %H:%M')
df7['ended_at'] = pd.to_datetime(df7['ended_at'], format='%m/%d/%Y %H:%M')

df8['started_at'] = pd.to_datetime(df8['started_at'], format='%Y/%m/%d %H:%M:%S')
df8['ended_at'] = pd.to_datetime(df8['ended_at'], format='%Y/%m/%d %H:%M:%S')

df9['started_at'] = pd.to_datetime(df9['started_at'], format='%Y/%m/%d %H:%M:%S')
df9['ended_at'] = pd.to_datetime(df9['ended_at'], format='%Y/%m/%d %H:%M:%S')

df10['started_at'] = pd.to_datetime(df10['started_at'], format='%Y/%m/%d %H:%M:%S')
df10['ended_at'] = pd.to_datetime(df10['ended_at'], format='%Y/%m/%d %H:%M:%S')

df11['started_at'] = pd.to_datetime(df11['started_at'], format='%Y/%m/%d %H:%M:%S')
df11['ended_at'] = pd.to_datetime(df11['ended_at'], format='%Y/%m/%d %H:%M:%S')

df12['started_at'] = pd.to_datetime(df12['started_at'], format='%Y/%m/%d %H:%M:%S')
df12['ended_at'] = pd.to_datetime(df12['ended_at'], format='%Y/%m/%d %H:%M:%S')

# Combining all the 12 files for analysis 
frames = [df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12]
bike_share_data = pd.concat(frames)

# Writing this file to drive as a csv
bike_share_data.to_csv('/drive/My Drive/Cyclistic data/bike_share_data.csv')

