function onUpdateDatabase()
	print("> Updating database to version 30 (player storage)")

	db.query("RENAME TABLE `player_storage` to `account_storage`;")
	db.query("ALTER TABLE `account_storage` CHANGE COLUMN `player_id` `account_id` int(11);")

	return true
end
