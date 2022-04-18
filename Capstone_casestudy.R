
# Installing and loading necessary packages

install.packages("tidyverse")
install.packages("ggplot2")
library(tidyverse)
library(lubridate) 
library(dplyr)
library(ggplot2)
library(readr)
# Note: Install the packages9If not done yet), before loading them


# Importing the dataset: for data source see read me file
bike_share_data <- read_csv("C:/Users/Administrator/Downloads/bike_share_data.csv")
head(bike_share_data)

# Inspect the dataset and drop unwanted columns: start_lat, start_lng, end_lat, end_lng and save it separately in other version v2
all_trips_v2 <- bike_share_data %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng))
  
# inspect the column names and check the consistency of all the columns. 
colnames(all_trips_v2)
str(all_trips_v2)
table(all_trips_v2$member_casual) # to check if the values in the column are consistent


# extracting 'month', 'year', 'day', 'day_of_week' and 'hour' columns from the "started_at"(date) column
all_trips_v2$date <- as.Date(all_trips_v2$started_at) #The default format is yyyy-mm-dd
all_trips_v2$month <- format(as.Date(all_trips_v2$date), "%m")
all_trips_v2$day <- format(as.Date(all_trips_v2$date), "%d")
all_trips_v2$year <- format(as.Date(all_trips_v2$date), "%Y")
all_trips_v2$day_of_week <- format(as.Date(all_trips_v2$date), "%A")
all_trips_v2$hour <- format(as.POSIXct(all_trips_v2$started_at), format = "%H")

# Adding a column to get duration of the ride
all_trips_v2$ride_length <- difftime(all_trips_v2$ended_at,all_trips_v2$started_at) 

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(all_trips_v2$ride_length)
all_trips_v2$ride_length <- as.numeric(as.character(all_trips_v2$ride_length))
is.numeric(all_trips_v2$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative.
# We will create a new version of the dataframe (v3) since data is being removed
all_trips_v3 <- all_trips_v2[!(all_trips_v2$start_station_name == "HQ QR" | all_trips_v2$ride_length<0),]



# Analyze:

# 1. First, we do Descriptive analysis on ride_length (all figures in seconds)
mean_ride_length <- mean(all_trips_v3$ride_length, na.rm = TRUE)#straight average (total ride length / rides)
median_ride_length <- median(all_trips_v3$ride_length, na.rm = TRUE) #midpoint in the ascending array of ride lengths
max_ride_length <- max(all_trips_v3$ride_length, na.rm = TRUE) #longest ride
min_ride_length <- min(all_trips_v3$ride_length, na.rm = TRUE) #shortest ride
summary(all_trips_v3$ride_length, na.rm = TRUE)

# 2. Compare members and casual users using aggregate functions 
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual, FUN = mean)
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual, FUN = median)
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual, FUN = max)
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual, FUN = min)

# 3. Now compare member and casual by each day of week
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual + all_trips_v3$day_of_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
all_trips_v3$day_of_week <- ordered(all_trips_v3$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Now, let's run the average ride time by each day for members vs casual users
aggregate(all_trips_v3$ride_length ~ all_trips_v3$member_casual + all_trips_v3$day_of_week, FUN = mean)


# 4. analyze ridership data by type and weekday
# i.e., Get the number of rides and average ride length by members and casual riders on each day of week.
all_trips_v3 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)	


# 5. Let's visualize the number of rides by member/casual riders on each day of week
all_trips_v3 %>% drop_na() %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# 6. Now, same visualization for average duration
all_trips_v3 %>% drop_na() %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")


# create a new version of the dataset by dropping NA values
all_trips_v4 <- all_trips_v3 %>% drop_na()

# Compare member/casual riders based on hourly statistics
hour_data <- all_trips_v4 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, hour) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, hour)


# Combine 'start_station_name' and 'end_station_name' to summarize based on outes taken by riders
all_trips_v5 <- all_trips_v4 %>% 
  unite(route, c("start_station_name", "end_station_name"), sep=" to ")



# 7. Export a summary file for further analysis.
# Create csv files that we will use to visualize on Tableau public

write.csv(all_trips_v4, file = 'C:\\Users\\Administrator\\Desktop\\New_bike_share.csv')
write.csv(hour_data, file = 'C:\\Users\\Administrator\\Desktop\\hour_data.csv')
write.csv(all_trips_v5, file = 'C:\\Users\\Administrator\\Desktop\\Cyclistic_bike_share_data.csv')


# Use these exported files to creates visualizations in Tableau
