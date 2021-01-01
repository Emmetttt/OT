function onUpdateDatabase()
	print("> Updating database to version 26 (track player stats)")
	db.query("ALTER TABLE `players` ADD COLUMN `player_kills` int(11) unsigned NOT NULL DEFAULT 0, ADD COLUMN `bot_kills` int(11) unsigned NOT NULL DEFAULT 0, ADD COLUMN `wins` int(11) unsigned NOT NULL DEFAULT 0, ADD COLUMN `games` int(11) unsigned NOT NULL DEFAULT 0")
	return true
end
