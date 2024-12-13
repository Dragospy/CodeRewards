#  Simple Rewards System (QB-Core)
***THIS IS NOT YET READY TO BE USED ON A LIVE SERVER***
- Creator: Dragospy (aka W4TCH3R)
- Framework: QB-Core
## Description

This is a simple reward code system for server owners to use<br>
<br>

It allows server owners to create reward codes that can then be claimed by players to recieve rewards such as cars, money and items (all chosen by the owner)

## Dependancy's
- QB-Core
- oxmysql

## Setup
- Drag and Drop the resource in your chosen resource folder (make sure to activate it in server.cfg)
- Drop the sql file in to your db (This will create a rewards table for the codes to be stored)
- Add the permission licenses in Config.lua and tweak the settings to your liking.
- Done!

## Preview ****Redesign is planned, this will make the rewards system have the same design style as my gang system****
- Hover over X button <br>
![image](https://github.com/user-attachments/assets/036e50ae-61f1-4bc8-9175-a05a5bd8481e)

- Hover over Section button <br>
![image](https://github.com/user-attachments/assets/07f4b7e0-906e-4169-a667-2fa7f7ba805e)

- Hover over Confirm Rewards button <br>
![image](https://github.com/user-attachments/assets/8e011cb2-2191-4dc1-a879-192d3cf8e573)

### Adding vehicles to the code
- Default Page <br>
![image](https://github.com/user-attachments/assets/43d250ca-74da-4c43-bf38-70dcd3571202)

- Filtering <br>
![image](https://github.com/user-attachments/assets/c1dcb5c3-6efa-45da-afbf-774b57a335d7)

### Adding money to the code
- Default Page <br>
![image](https://github.com/user-attachments/assets/0857fc97-72c7-4a70-9b52-59720f8ad405)
- Typing amount <br>
![image](https://github.com/user-attachments/assets/f86d667b-1095-400e-a5f9-216f0b834336)
### Adding items to the code
- Default Page <br>
![image](https://github.com/user-attachments/assets/383c63e5-da0e-4729-921a-f3da7817d41b)
- Filtering <br>
![image](https://github.com/user-attachments/assets/e2d45452-befb-4386-a356-810cb10519f0)

### Summary page
![image](https://github.com/user-attachments/assets/756c4137-08d3-493d-9b32-ff526d6a132a)

### Claim Code
![image](https://github.com/user-attachments/assets/ba0d5fd0-f9ad-498e-989f-ca925e205f79)



## The system currently plans to have the following features:
 ### Already implemented features:
 - Can filter through vehicles and items
 - Can add any number of vehicles and items to a code, as well as an unlimited amount of money
 - Summary page shows the rewards that will be given when the code is used
 - Code copies to clipboard and saves in db along with its rewarads
 ### Not yet implemented features:
 - Code summary sent to a discord channel using a webhook
 - Codes can be modified once generated using the UI
 - Rewards can be removed from code on the summary page without having to restart process
 - Rewards can can be removed from code once added incase of accidental press
