function onUpdateDatabase()
	print("> Updating database to version 28 (track account player name)")
	db.query("ALTER TABLE `accounts` ADD COLUMN `player_name` varchar(255) NOT NULL")
	return true
end
