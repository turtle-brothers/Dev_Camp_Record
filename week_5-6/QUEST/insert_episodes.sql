INSERT INTO episodes (season_id, program_id, episode_number, episode_title, episode_detail, video_time, release_date, views)
VALUES
(1, 1, 1, 'The Beginning', 'This is the first episode of our new show!', '02:00:00', DATE_ADD(CURRENT_DATE, INTERVAL - 2 DAY), 1000),
(1, 2, 2, 'Uncharted Territory', 'Our characters embark on an exciting adventure into unexplored lands.', '00:45:00', DATE_ADD(CURRENT_DATE, INTERVAL - 2 DAY), 1500),
(1, 3, 3, 'Secrets Revealed', 'The mysteries surrounding our main characters are finally unveiled.', '00:30:00', DATE_ADD(CURRENT_DATE, INTERVAL - 2 DAY), 1200),
(1, 1, 4, 'Pilot Episode', 'The first episode of our thrilling new series!', '00:30:00', DATE_ADD(CURRENT_DATE, INTERVAL - 1 DAY), 2000),
(1, 2, 5, 'Double Cross', 'Betrayal and deceit take center stage in this intense episode.', '01:00:00', DATE_ADD(CURRENT_DATE, INTERVAL - 1 DAY), 1800),
(1, 3, 6, 'The Chase Begins', 'The protagonist embarks on a high-stakes chase to catch the culprits.', '00:45:00', DATE_ADD(CURRENT_DATE, INTERVAL - 1 DAY), 1600),
(1, 1, 7, 'New Horizons', 'Our characters start a new chapter in their lives with exciting opportunities.', '00:30:00', CURDATE(), 900),
(1, 4, 8, 'Facing Fears', 'Our protagonist confronts their deepest fears in a life-changing journey.', '00:45:00', CURDATE(), 1100),
(1, 9, 9, 'Into the Unknown', 'Our characters venture into uncharted territory, facing unexpected challenges.', '00:30:00', CURDATE(), 1300),
(1, 10, 10, 'The Origins', 'Discover the origins of our main character in this intriguing episode.', '01:00:00', DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY), 1700),
(1, 11, 11, 'A Twist of Fate', 'A surprising turn of events changes the course of our character lives.', '01:00:00', DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY), 1900),
(1, 12, 12, 'The Final Showdown', 'The ultimate battle between good and evil reaches its climax.', '01:00:00', DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY), 2200),
(2, 21, 13, 'The Awakening', 'Our protagonist awakens to their true powers in this pivotal episode.', '00:30:00', DATE_ADD(CURRENT_DATE, INTERVAL 2 DAY), 950),
(2, 22, 14, 'Hidden Secrets', 'Dark secrets from the past resurface, threatening to unravel everything.', '00:45:00', DATE_ADD(CURRENT_DATE, INTERVAL 2 DAY), 1250),
(2, 23, 15, 'Race Against Time', 'Our characters race against the clock to prevent a catastrophic event.', '01:00:00', DATE_ADD(CURRENT_DATE, INTERVAL 2 DAY), 1450);

/*
(1, 1, 1, 'The Beginning', 'This is the first episode of our new show!', '02:00:00', '2022-01-01', 1000),
(1, 1, 2, 'Uncharted Territory', 'Our characters embark on an exciting adventure into unexplored lands.', '00:45:00', '2022-01-08', 1500),
(1, 1, 3, 'Secrets Revealed', 'The mysteries surrounding our main characters are finally unveiled.', '00:30:00', '2022-01-15', 1200),
(1, 1, 4, 'Pilot Episode', 'The first episode of our thrilling new series!', '00:30:00', '2022-02-05', 2000),
(1, 1, 5, 'Double Cross', 'Betrayal and deceit take center stage in this intense episode.', '01:00:00', '2022-02-12', 1800),
(1, 1, 6, 'The Chase Begins', 'The protagonist embarks on a high-stakes chase to catch the culprits.', '00:45:00', '2022-02-19', 1600),
(1, 2, 7, 'New Horizons', 'Our characters start a new chapter in their lives with exciting opportunities.', '00:30:00', '2022-03-03', 900),
(1, 2, 8, 'Facing Fears', 'Our protagonist confronts their deepest fears in a life-changing journey.', '00:45:00', '2022-03-10', 1100),
(1, 2, 9, 'Into the Unknown', 'Our characters venture into uncharted territory, facing unexpected challenges.', '00:30:00', '2022-03-17', 1300),
(1, 2, 10, 'The Origins', 'Discover the origins of our main character in this intriguing episode.', '01:00:00', '2022-04-02', 1700),
(1, 2, 11, 'A Twist of Fate', 'A surprising turn of events changes the course of our character lives.', '01:00:00', '2022-04-09', 1900),
(1, 2, 12, 'The Final Showdown', 'The ultimate battle between good and evil reaches its climax.', '01:00:00', '2022-04-16', 2200),
(2, 1, 13, 'The Awakening', 'Our protagonist awakens to their true powers in this pivotal episode.', '00:30:00', '2022-05-01', 950),
(2, 1, 14, 'Hidden Secrets', 'Dark secrets from the past resurface, threatening to unravel everything.', '00:45:00', '2022-05-08', 1250),
(2, 1, 15, 'Race Against Time', 'Our characters race against the clock to prevent a catastrophic event.', '01:00:00', '2022-05-15', 1450);
*/
