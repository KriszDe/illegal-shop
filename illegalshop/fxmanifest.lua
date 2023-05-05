fx_version 'adamant'

game 'gta5'

description 'Illegál Eladó By Krisz'

server_scripts {
	'server/main.lua',
	'config.lua',
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

ui_page "html/index.html"
files({
    'html/index.html',
    'html/index.js',
    'html/index.css'
})