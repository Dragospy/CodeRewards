fx_version 'cerulean'
game 'gta5'

author 'W4TCH3R'
description 'A reward code creation system'
version '1.0.0'

client_scripts{
    "client/*.lua"
}

server_scripts{
    "server/*.lua"
}

shared_script 'config.lua'

ui_page 'UI/main.html'

files {
    'UI/main.html',
    'UI/main.css',
    'UI/main.js',
}