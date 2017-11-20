
version '1.0.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}
