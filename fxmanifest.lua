fx_version 'adamant'

game 'gta5'

name 'esx_nicedeath'
description 'esx death fx and cooldown'

version '1.0.2'

server_scripts {
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
}

dependencies {
	'es_extended',
}
