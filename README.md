# SpaceLaunches

This is a dataset from Maven's data playground that shows all missions and rockets launched from 1957 to 2022. 

- The data is quite an interesting one and below are some of the key insights

- We had a total of 4555 Space Missions Carried out by 370 Rockets.

- 62 Companies with 46 Space Centers across 22 Countries were involved in the Space Missions.

- 89.89% of the Space Missions carried out were successful.

- 21.81% of the Space Rockets are still on active duty.


# Data Cleaning

After importing the dataset in SQL, I used the PARSENAME function to separate Location into individual columns: Address, City, and Country and updatng the table. Also removing any null values.

<img width="1051" alt="Screenshot 2022-11-03 at 2 15 24 PM" src="https://user-images.githubusercontent.com/87345933/199802535-30de86e7-f6e1-4537-9693-80b4d8f6945b.png">
