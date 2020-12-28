function onUpdateDatabase()
	print("> Updating database to version 26 (track player stats)")
	db.query("ALTER TABLE `players` ADD COLUMN `kills` int(11) unsigned NOT NULL DEFAULT 0, ADD COLUMN `deaths` int(11) unsigned NOT NULL DEFAULT 0, ADD COLUMN `longest_streak` int(11) unsigned NOT NULL DEFAULT 0")
	return true
end
