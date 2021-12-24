
fx_version 'cerulean'
games { 'gta5' }

client_scripts {
	'@es_extended/locale.lua',
	"src/RageUI.lua",
	"src/Menu.lua",
	"src/MenuController.lua",
	"src/components/*.lua",
	"src/elements/*.lua",
	"src/items/*.lua",
	"src/panels/*.lua",
	"src/windows/*.lua",
	"client.lua"
}

server_scripts {
	'@es_extended/locale.lua',
	"@mysql-async/lib/MySQL.lua",
	"server.lua"
}

dependencies {
	'es_extended',
	'esx_status'
}

