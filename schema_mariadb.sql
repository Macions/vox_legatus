-- clubs
CREATE TABLE clubs (
	id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL, 
	type VARCHAR(255) NOT NULL, 
	color VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id)
);

-- users
CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT, 
	username VARCHAR(255) NOT NULL, 
	password_hash VARCHAR(255) NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	club VARCHAR(255), 
	role VARCHAR(255) NOT NULL, 
	permissions JSON NOT NULL, 
	`group` VARCHAR(255), 
	PRIMARY KEY (id)
);

-- sessions
CREATE TABLE sessions (
	id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL, 
	date VARCHAR(255), 
	city VARCHAR(255), 
	number VARCHAR(255), 
	start VARCHAR(255), 
	start_time VARCHAR(255), 
	`end` VARCHAR(255), 
	end_time VARCHAR(255), 
	PRIMARY KEY (id)
);

-- speakers
CREATE TABLE speakers (
	id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL, 
	club VARCHAR(255), 
	role VARCHAR(255), 
	status VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id)
);

-- current_session
CREATE TABLE current_session (
	id INT NOT NULL AUTO_INCREMENT, 
	title VARCHAR(255) NOT NULL, 
	status VARCHAR(255) NOT NULL, 
	active TINYINT(1) NOT NULL, 
	date VARCHAR(255), 
	start VARCHAR(255), 
	start_time VARCHAR(255), 
	`end` VARCHAR(255), 
	end_time VARCHAR(255), 
	current_speaker JSON, 
	current_point JSON, 
	schedule JSON NOT NULL, 
	zo_content VARCHAR(255) NOT NULL, speakers JSON DEFAULT '[]', session_mode VARCHAR(255) DEFAULT 'normal', 
	PRIMARY KEY (id)
);

-- ideas
CREATE TABLE ideas (
	id INT NOT NULL AUTO_INCREMENT, 
	content TEXT NOT NULL, 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, 
	PRIMARY KEY (id)
);

-- parliamentarians
CREATE TABLE parliamentarians (
	id INT NOT NULL AUTO_INCREMENT, 
	first_name VARCHAR(255) NOT NULL, 
	last_name VARCHAR(255) NOT NULL, 
	club_id INTEGER, 
	functions JSON NOT NULL, 
	commissions JSON NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(club_id) REFERENCES clubs (id) ON DELETE SET NULL
);

-- resolutions
CREATE TABLE resolutions (
	id INT NOT NULL AUTO_INCREMENT, 
	title VARCHAR(255) NOT NULL, 
	slug VARCHAR(255) NOT NULL, 
	file_name VARCHAR(255), 
	author_id INTEGER, 
	author VARCHAR(255) NOT NULL, 
	party VARCHAR(255), 
	session_id INTEGER, 
	preamble VARCHAR(255), 
	chapters JSON NOT NULL, 
	signatures INTEGER NOT NULL, 
	status VARCHAR(255) NOT NULL, 
	created_at VARCHAR(255), 
	file_path VARCHAR(255), 
	PRIMARY KEY (id)
);

-- amendments
CREATE TABLE amendments (
	id INT NOT NULL AUTO_INCREMENT, 
	resolution_id INTEGER NOT NULL, 
	author VARCHAR(255) NOT NULL, 
	author_id INTEGER, 
	club VARCHAR(255), 
	content VARCHAR(255) NOT NULL, 
	status VARCHAR(255) NOT NULL, 
	created_at VARCHAR(255), 
	withdrawn_reason VARCHAR(255), 
	changes JSON NOT NULL, 
	target JSON, 
	PRIMARY KEY (id), 
	FOREIGN KEY(resolution_id) REFERENCES resolutions (id) ON DELETE CASCADE
);

-- votings
CREATE TABLE votings (
	id INT NOT NULL AUTO_INCREMENT, 
	title VARCHAR(255) NOT NULL, 
	description VARCHAR(255), 
	category VARCHAR(255) NOT NULL, 
	start_time VARCHAR(255), 
	end_time VARCHAR(255), 
	status VARCHAR(255) NOT NULL, 
	recipients_type VARCHAR(255) NOT NULL, 
	selected_groups JSON NOT NULL, 
	selected_members JSON NOT NULL, 
	linked_item_type VARCHAR(255) NOT NULL, 
	linked_item_id VARCHAR(255), 
	applicant VARCHAR(255), 
	managers JSON NOT NULL, 
	attachments JSON NOT NULL, 
	created_by VARCHAR(255), 
	options JSON NOT NULL, voting_mode VARCHAR(255) NOT NULL DEFAULT 'single', questions JSON NOT NULL DEFAULT '[]', 
	PRIMARY KEY (id)
);

-- votes
CREATE TABLE `votes` (
                id INT NOT NULL AUTO_INCREMENT,
                voting_id INTEGER NOT NULL,
                user_id INTEGER NOT NULL,
                value VARCHAR(255) NOT NULL,
                question_id VARCHAR(255),
                PRIMARY KEY (id),
                CONSTRAINT uq_votes_voting_user_question
                    UNIQUE (voting_id, user_id, question_id),
                FOREIGN KEY(voting_id) REFERENCES votings (id) ON DELETE CASCADE,
                FOREIGN KEY(user_id) REFERENCES users (id)
            );

-- resolution_signatures
CREATE TABLE resolution_signatures (
	id INT NOT NULL AUTO_INCREMENT, 
	resolution_id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	timestamp VARCHAR(255) NOT NULL, 
	type VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id), 
	CONSTRAINT uq_resolution_signatures_resolution_user UNIQUE (resolution_id, user_id), 
	FOREIGN KEY(resolution_id) REFERENCES resolutions (id) ON DELETE CASCADE, 
	FOREIGN KEY(user_id) REFERENCES users (id)
);

