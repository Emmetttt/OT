function onUpdateDatabase()
	print("> Updating database to version 25 (Store inbox changes)")
	db.query([[
		CREATE TABLE IF NOT EXISTS `player_storeinboxitems` (
		  `account_id` int(11) NOT NULL,
		  `sid` int(11) NOT NULL,
		  `pid` int(11) NOT NULL DEFAULT '0',
		  `itemtype` smallint(6) NOT NULL,
		  `count` smallint(5) NOT NULL DEFAULT '0',
		  `attributes` blob NOT NULL,
		  UNIQUE KEY `account_id_2` (`account_id`, `sid`),
		  FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
		) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;
	]])
	return true
end
