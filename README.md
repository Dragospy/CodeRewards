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
### Adding vehicles to the code
### Adding money to the code
### Adding items to the code
### Summary page
### Claim Code

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
